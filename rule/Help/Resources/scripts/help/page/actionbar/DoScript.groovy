package help.page.actionbar

import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript{
	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		String id = formData.getValue("id");
		String mode = formData.getValueSilently("mode");
		if(id == "articlebycategory" || id == "homepage" || id == "articleview" ) id = "article"; 
		
		if (user.hasRole(["administrator"])){
			def newDocAction = new _Action(getLocalizedWord("Добавить",lang),getLocalizedWord("Добавить",lang),"new_document")
			newDocAction.setURL("Provider?type=edit&element=document&id=${id}&key=");
			actionBar.addAction(newDocAction);
			
			actionBar.addAction(new _Action(getLocalizedWord("Редактировать", lang),getLocalizedWord("Редактировать",lang), "edit"))
			actionBar.addAction(new _Action(getLocalizedWord("Удалить",lang),getLocalizedWord("Удалить",lang),_ActionType.DELETE_DOCUMENT));
		}
		actionBar.addAction(new _Action(getLocalizedWord("Печать", lang),getLocalizedWord("Печать",lang), "print"))
		actionBar.addAction(new _Action(getLocalizedWord("Избранные", lang),getLocalizedWord("Избранные",lang), "favs"))
		setContent(actionBar);
	}
}
