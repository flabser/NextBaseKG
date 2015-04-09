package structure.page.actionbar

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._DoScript

/**
 * Created by Bekzat on 3/18/14.
 */
class DoScript extends _DoScript{
    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def actionBar = new _ActionBar(session);
        def user = session.getCurrentAppUser();
        def pageid = formData.getValueSilently("id")

        def newDocAction = new _Action(getLocalizedWord("Добавить",lang),getLocalizedWord("Добавить",lang),"new_document")
        if(pageid == "group")
            newDocAction.setURL("Provider?type=document&id=group&key=")
        else if(pageid == "subdivisionlist")
            newDocAction.setURL("Provider?type=document&id=subdivision&key=")
        else if(pageid == "organizations")
            newDocAction.setURL("Provider?type=edit&element=document&id=organization&key=")
        else
            newDocAction.setURL("Provider?type=edit&element=document&id=$pageid&key=");
        actionBar.addAction(newDocAction);
        actionBar.addAction(new _Action(getLocalizedWord("Удалить",lang),getLocalizedWord("Удалить",lang),_ActionType.DELETE_DOCUMENT));


        if (user.hasRole(["org_keeper", "supervisor"]) && pageid == "organizations"){
            setContent(actionBar);
        }
        if(user.hasRole(["struct_keeper", "supervisor"]) && pageid != "organizations") {
            setContent(actionBar);
        }
    }
}
