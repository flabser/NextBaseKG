package structure.form.group

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.struct.*

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
		def group  = (_UserGroup)doc;
		publishValue("title",getLocalizedWord("Группа сотрудников", lang) + " " + group.getName())
		publishValue("groupname", group.getName())
		publishValue("description", group.getDescription())
		def owner = group.getOwner()
		if (owner != "") publishEmployer("ownergroup", owner)
		publishEmployer("member", group.getListOfMembers())
		publishValue("role", group.getListOfRoles())
		
		def user = ses.getCurrentAppUser()
		def actionBar = ses.createActionBar();
		
		if (user.hasRole(["struct_keeper","supervisor"])){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
	}	
	
}