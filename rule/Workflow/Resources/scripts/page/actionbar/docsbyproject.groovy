package page.actionbar

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._DoScript

class docsbyproject extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
        def formid = formData.getValueSilently("formid");
        if(formid == "IN"){
            if (user.hasRole(["registrator_incoming"])){
                def newDocAction = new _Action(getLocalizedWord("Новый входящий документ", lang),getLocalizedWord("Создать новый входящий документ",lang), "new_document")
                newDocAction.setURL("Provider?type=edit&element=document&id=in&docid=")
                actionBar.addAction(newDocAction);
            }
            if (user.hasRole(["chancellery"])){
                actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
            }

        }else if(formid == "out"){
            if (user.hasRole(["registrator_outgoing", "administrator"])){
                def newDocAction = new _Action(getLocalizedWord("Новый исходящий документ", lang),getLocalizedWord("Новый исходящий документ", lang),"new_document")
                newDocAction.setURL("Provider?type=edit&element=document&id=out&docid=")
                actionBar.addAction(newDocAction);
            }
            if (user.hasRole(["administrator", "chancellery"])){
                actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
            }
        } else if(formid == "task"){
            if (user.hasRole(["registrator_tasks"])){
                def newDocAction = new _Action(getLocalizedWord("Новое задание", lang),getLocalizedWord("Создать новое задание", lang),"new_document")
                newDocAction.setURL("Provider?type=edit&element=document&id=task&docid=")
                actionBar.addAction(newDocAction);
            }
            if (user.hasRole(["supervisor","administrator","chancellery"])){
                actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
            }
        }
        setContent(actionBar);
	}
}

