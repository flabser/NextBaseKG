package page.actionbar

import java.util.ArrayList;
import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class letters extends _DoScript { 

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		if (user.hasRole(["registrator_letter", "administrator"])){
			def newDocAction = new _Action(getLocalizedWord("Новое обращение", lang),getLocalizedWord("Новое обращение граждан", lang),"new_document")
			newDocAction.setURL("Provider?type=edit&element=document&id=l&docid=")
			actionBar.addAction(newDocAction);
		}
		if (user.hasRole(["administrator", "chancellery"])){
			actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
		}
		setContent(actionBar);
	}
}

