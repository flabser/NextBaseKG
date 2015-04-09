package form.addressee

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._Task

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Адресат", lang))
		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)

		
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
//		publishElement(getActionBar(session))
		

	}


	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
			def glos = (_Glossary)doc
			
			def actionBar = session.createActionBar();
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
			actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
			publishElement(actionBar)
			
			publishValue("title",getLocalizedWord("Адресат", lang) + ":" + glos.getViewText())
			publishEmployer("author",glos.getAuthorID())
			publishValue("name",glos.getName())
			publishValue("shortname",glos.getShortName())
			publishValue("fullname",glos.getField("fullname"))
			publishValue("extid",glos.getField("extid"))
			
			
			def nav = session.getPage("outline", webFormData)
			publishElement(nav)
	//	publishElement(getActionBar(session))
		
		
	}

	/*private getActionBar(_Session session){
		def actionBar = new _ActionBar(session)

		def user = session.getCurrentAppUser()
		if (user.hasRole("administrator")){
			actionBar.addAction(new _Action("Сохранить и закрыть","Сохранить и закрыть",_ActionType.SAVE_AND_CLOSE))
			actionBar.addAction(new _Action("Закрыть","Закрыть без сохранения",_ActionType.CLOSE))
		}
		return actionBar

	}
*/
}