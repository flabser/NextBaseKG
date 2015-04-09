package page.actionbar

import java.util.ArrayList;
import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class corrlist extends _DoScript { 

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		if (user.hasRole(["supervisor","administrator","chancellery"])){
			def newDocAction = new _Action(getLocalizedWord("Новый корреспондент", lang),getLocalizedWord("Новый корреспондент",lang), "new_glossary")
			newDocAction.setURL("Provider?type=edit&id=corr&key=")
			actionBar.addAction(newDocAction);
		}
		if (user.hasRole(["supervisor","administrator","chancellery"])){
			actionBar.addAction(new _Action(getLocalizedWord("Удалить документ",lang), getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
		}
		setContent(actionBar);
	}
}

