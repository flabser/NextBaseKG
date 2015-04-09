package form.article

import kz.nextbase.script.constants._DocumentModeType

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._Task

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		 
		publishValue("title",getLocalizedWord("Новая статья", lang));
		publishEmployer("docauthor", session.currentUserID);
		publishValue("docdate",session.getCurrentDateAsString());
		publishValue("mode", webFormData.getValueSilently("mode")); 
		publishElement(getActionBar(session, lang))
		def nav = session.getPage("outline", webFormData)
		publishElement(nav) 
		publishElement(glossariesList(session, "category"))
	}
	
	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		 
		publishValue("title", getLocalizedWord("Статья", lang) + ": " + doc.getValueString("topic"));
		publishEmployer("docauthor",doc.getAuthorID());
		publishValue("docdate",doc.getRegDate().format("hh:mm dd:MM:yyyy"))
		publishGlossaryValue("category", doc.getValueString("category"));
		publishValue("topic", doc.getValueString("topic"));
		publishValue("briefcontent", doc.getValueString("briefcontent"));
		publishValue("favourites", doc.isFavourite());
		publishValue("url", doc.getFullURL());
		publishValue("mode", webFormData.getValueSilently("mode"));
		
		/* Связанные документы */
		try{
			publishValue("linked_docs", (_CrossLinkCollection) doc.getValueObject("linked_docs"));
		}catch(Exception e){println(e.toString())}
		
		/* Прикрепленные файлы */
		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(Exception e){ println(e.toString()) }
		
		publishElement(session.getPage("outline", webFormData))
		publishElement(getActionBar(session, lang, doc))
		publishElement(glossariesList(session, "category"))
		
		// иерархия статей
		 
		try{
			def pdoc = doc.getParentDocument();
			def list = [];
			def hTag = new _Tag("entry");
			if(pdoc != null){
				list = getParentDocs(pdoc, list);
			}
			
			for(int i = list.size()-1; i >=0; --i){
				hTag.addTag(list[i]);
			}
			def xml = new _XMLDocument(hTag);
			publishValue("hierarchy", xml);
		}catch(Exception e){}
		
	}
	
	private getActionBar(_Session session, String lang){
		
		def actionBar = new _ActionBar(session)
		if(session.getCurrentAppUser().hasRole("administrator"))
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		
		return actionBar
	}
    private getActionBar(_Session session, String lang, _Document doc){

        def actionBar = new _ActionBar(session)
        if(doc.getEditMode() == _DocumentModeType.EDIT)
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))

        return actionBar
    }

	def glossariesList(_Session ses, String gloss_form){
		
		def cdb = ses.getCurrentDatabase();
		def glist = cdb.getGlossaryDocs(gloss_form, "form='$gloss_form'");
		def glossaries = new _Tag("glossaries", "");
		def rootTag = new _Tag(gloss_form, "");
		
		for(def gdoc in glist){
			
			def etag = new _Tag("entry", gdoc.getViewText());
			etag.setAttr("docid", gdoc.getDocID());
			etag.setAttr("id", gdoc.getID());
			rootTag.addTag(etag);
		}
		glossaries.addTag(rootTag);
		def xml = new _XMLDocument(glossaries);
		return xml;
	}
	
	def getParentDocs(def pdoc, list){
		def entry = new _Tag("entry");
		entry.setAttr("viewtext", pdoc.getViewText());
		entry.setAttr("url", "Provider?type=edit&element=document&id=articleview&docid=${pdoc.getID()}");
		list.add(entry);
		def ppdoc = pdoc.getParentDocument();
		if(ppdoc != null){
			list = getParentDocs(ppdoc, list);
		}
		return list;
	}
}

