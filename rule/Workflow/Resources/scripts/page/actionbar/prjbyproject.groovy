package page.actionbar

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._DoScript

class prjbyproject extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
        def formid = formData.getValueSilently("formid");

        if(formid == "officememoprj"){
            if (user.hasRole(["registrator_projects" ,"administrator"])){
                def newDocAction = new _Action(getLocalizedWord("Проект внутреннего документа", lang),getLocalizedWord("Проект внутреннего документа", lang),"new_document")
                newDocAction.setURL("Provider?type=edit&element=document&id=officememoprj&docid=")
                actionBar.addAction(newDocAction);
            }
        }else if(formid == "outgoingprj"){
            if (user.hasRole(["registrator_projects" ,"administrator"])){
                def newDocAction = new _Action(getLocalizedWord("Проект исходящего документа", lang),getLocalizedWord("Проект исходящего документа", lang),"new_document")
                newDocAction.setURL("Provider?type=edit&element=document&id=outgoingprj&docid=")
                actionBar.addAction(newDocAction);
            }

        }
        if (user.hasRole(["administrator", "chancellery"])){
            actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
        }
        setContent(actionBar);
	}
}

