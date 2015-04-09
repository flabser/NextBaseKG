package knowledgebase.form.subcategory


import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._Task;
import kz.nextbase.script._Glossary;


class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData,
			String lang) {
		// TODO Auto-generated method stub
			publishValue("title",getLocalizedWord("Подкатегория", lang))
			
			def actionBar = session.createActionBar();
			def user = session.getCurrentAppUser();
			if (user.hasRole("administrator")){
				actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
			}
			actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
			publishElement(actionBar)
			publishEmployer("docauthor",session.currentUserID)
			publishValue("docdate", session.getCurrentDateAsString())
			def nav = session.getPage("outline", webFormData)
			publishElement(nav)
			def parentid = webFormData.getValueSilently("parentid");
			if(parentid != "")
				publishGlossaryValue("category", parentid)
			publishElement(glossariesList(session, "category"))
	}

	@Override
	public void doQueryOpen(_Session session, _Document doc,
			_WebFormData webFormData, String lang) {
		// TODO Auto-generated method stub
			def glos = (_Glossary)doc;
			def actionBar = session.createActionBar();
			def user = session.getCurrentAppUser();
			if (user.hasRole("administrator")){
				actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
			}
			actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
			publishElement(actionBar)
			
			publishValue("title",getLocalizedWord("Название", lang) + ": " + glos.getViewText())
			publishValue("name",doc.getValueString("name"))
			publishEmployer("docauthor",doc.getAuthorID())
			publishValue("docdate",doc.getRegDate().format("hh:mm dd:MM:yyyy"))
			def nav = session.getPage("outline", webFormData)
			publishElement(nav)
			def parentid = glos.getParentDocument().getID();
			publishGlossaryValue("category", parentid)
			publishElement(glossariesList(session, "category"))
	}
			
	def glossariesList(_Session ses, String gloss_form){
		
		def cdb = ses.getCurrentDatabase();
		def glist = cdb.getGlossaryDocs(gloss_form, "form='$gloss_form'");
		def glossaries = new _Tag("glossaries", "");
		def rootTag = new _Tag("category", "");
		
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

}
