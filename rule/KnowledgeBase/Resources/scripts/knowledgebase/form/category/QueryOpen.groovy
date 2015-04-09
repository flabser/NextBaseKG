package knowledgebase.form.category


import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._Task;
import kz.nextbase.script._Glossary;

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Категория", lang))

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
		
		//publishElement(getActionBar(session))
	}


	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		def glos = (_Glossary)doc;
		def actionBar = session.createActionBar();
		def user = session.getCurrentAppUser();
		if (user.hasRole("administrator")){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		publishElement(actionBar)
		
		publishValue("title",getLocalizedWord("Название", lang) + ":" + glos.getViewText())
		publishValue("name",doc.getValueString("name"))
		publishEmployer("docauthor",doc.getAuthorID())
		publishValue("docdate",doc.getRegDate().format("hh:mm dd:MM:yyyy"))
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
		
	}
	
	
}

