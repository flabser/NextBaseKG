package knowledgebase.form.article
 
import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen
import kz.nextbase.script.task._Control;
import kz.nextbase.script.constants._DocumentModeType;

import java.util.Collection;
import java.util.Date;

class QueryOpen  extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData,
			String lang) {
			
		def actionBar = session.createActionBar();
		if(session.getCurrentAppUser().hasRole("administrator")){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		publishElement(actionBar)
		
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
		publishValue("title",getLocalizedWord("Статья", lang));
		publishEmployer("docauthor", session.currentUserID);
		publishValue("docdate", session.getCurrentDateAsString());
		publishElement(glossariesList(session, "category"));
	}

	@Override
	public void doQueryOpen(_Session session, _Document doc,
			_WebFormData webFormData, String lang) {
			
		def actionBar = session.createActionBar();
		if(session.getCurrentAppUser().hasRole("administrator")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}
		if(doc.editMode == _DocumentModeType.EDIT){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		publishElement(actionBar)
		publishElement(glossariesList(session, "category"));
		try{
			publishValue("title",getLocalizedWord("Статья", lang)+ ": "+ doc.getValueString("topic"))
			publishValue("topic",doc.getValueString("topic"))
			publishEmployer("docauthor",doc.getAuthorID());
			publishValue("docdate",doc.getRegDate().format("HH:mm dd.MM.yyyy"));
			publishValue("briefcontent", doc.getValueString("briefcontent"))
			publishGlossaryValue("category", doc.getValueString("category"));
			publishGlossaryValue("subcategory", doc.getValueString("subcategory"));
			
			try{
				publishAttachment("rtfcontent","rtfcontent")
			}catch(Exception e){}

			publishElement(session.getPage("outline", webFormData))
			
		}catch(Exception e){}

        def editors = getReadersListWithoutGroup(doc.getEditors().toList());
       publishEmployer("editors", editors);

        def readers = [];
        for(r in doc.getReaders())   {
            readers.add(r.getUserID())
        }
        readers = getReadersListWithoutGroup(readers);
        readers.removeAll(editors);
        publishEmployer("readers", readers);

	}

    def getReadersListWithoutGroup(def readers){

        for (int i = 0; i < readers.size(); i++) {
            if(readers.get(i).startsWith("[") && readers.get(i).endsWith("]") &&
                    readers.contains(readers.get(i).substring(1, readers.get(i).length()-1 )))
                readers.remove(i);
        }
        //readers.remove("[supervisor]")
        return readers;
    }
	def glossariesList(_Session ses, String gloss_form){
		
		def cdb = ses.getCurrentDatabase();
		def glist = cdb.getGlossaryDocs(gloss_form, "form='$gloss_form'");
		def glossaries = new _Tag("glossaries", "");
		def rootTag = new _Tag(gloss_form, "");
		
		for(def gdoc in glist){
			
			def etag = new _Tag("entry");
			etag.setAttr("docid", gdoc.getDocID());
			etag.setAttr("id", gdoc.getID());
			etag.setAttr("viewtext", gdoc.getViewText());
			def resp = gdoc.getResponses(); 
			if(resp.size() > 0){
				def responses = new _Tag("responses");
				for(def d in resp){
					def rentry = new _Tag("entry", d.getViewText());
					rentry.setAttr("id", d.getID())
					responses.addTag(rentry);
				}
				etag.addTag(responses);
			}
			rootTag.addTag(etag);
		}
		glossaries.addTag(rootTag);
		def xml = new _XMLDocument(glossaries);
		return xml;
	}
}
 