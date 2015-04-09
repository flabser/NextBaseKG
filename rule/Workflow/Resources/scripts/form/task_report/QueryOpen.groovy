package form.task_report

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._Task

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Отчет", lang))
		def nav = session.getPage("outline", webFormData)
		
		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сформировать отчет", lang),getLocalizedWord("Сформировать отчет", lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		publishElement(actionBar)
		
		publishElement(nav)
		//publishElement(getActionBar(session))
	}


	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		
		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сформировать отчет", lang),getLocalizedWord("Сформировать отчет", lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		publishElement(actionBar)
		
		try{	
			publishValue("title",getLocalizedWord("Отчет", lang) + ":" + doc.getViewText())
			def nav = session.getPage("outline", webFormData)
			publishElement(nav)
			//publishElement(getActionBar(session, doc))
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*private getActionBar(_Session session, _Document doc){
		String lang="";
		def actionBar = new _ActionBar(session)
		def cuserID = session.getCurrentAppUser().getUserID();
			
		actionBar.addAction(new _Action(getLocalizedWord("Сформировать отчет", lang),getLocalizedWord("Сформировать отчет", lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		return actionBar
	}
	
	private getActionBar(_Session session){
		String lang="";
		def actionBar = new _ActionBar(session)		
		actionBar.addAction(new _Action(getLocalizedWord("Сформировать отчет", lang),getLocalizedWord("Сформировать отчет", lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
		return actionBar
	}*/
}