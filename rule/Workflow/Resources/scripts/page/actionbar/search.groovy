package page.actionbar

import java.util.ArrayList;
import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class search extends _DoScript { 

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		//println(formData)

		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		def newDocAction = new _Action(getLocalizedWord("Вернуться к списку документов", lang),getLocalizedWord("Вернуться к списку документов", lang),"custom")
		newDocAction.setURL(session.getURLOfLastPage().urlAsString)
		actionBar.addAction(newDocAction);			
		setContent(actionBar);
	}
}




