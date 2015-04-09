package structure.form.organization
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen
import kz.nextbase.script.struct._Organization

class QueryOpen extends _FormQueryOpen {


	@Override
	public void doQueryOpen(_Session ses, _WebFormData webFormData, String lang) {
		def user = ses.getCurrentAppUser()
		def actionBar = ses.createActionBar();
		
		 if (user.hasRole(["supervisor"])){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
	}

	@Override
	public void doQueryOpen(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

        def organization  = (_Organization)doc;
        publishValue("title",getLocalizedWord("Организация", lang) + " " + organization.getFullName())
        publishValue("fullname", organization.getFullName())
        publishValue("shortname", organization.getShortName())
        publishValue("address", organization.organization.getAddress())
        publishValue("comment", organization.organization.getComment())
        publishValue("bin", organization.getBIN());
        def user = ses.getCurrentAppUser()
        def actionBar = ses.createActionBar();
        if (user.hasRole(["supervisor"])){
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
        }
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
        publishElement(actionBar)
	}	
	
}