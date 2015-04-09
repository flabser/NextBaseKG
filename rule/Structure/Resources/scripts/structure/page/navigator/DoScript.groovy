package structure.page.navigator

import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData;
import kz.nextbase.script.events._DoScript;
import kz.nextbase.script.outline.*;
import kz.nextbase.script.*;

/**
 * Created by Bekzat on 2/10/14.
 */

class DoScript extends _DoScript{
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def cuser = session.getCurrentAppUser();
        def list = [];
        def docs_outline = new _Outline(getLocalizedWord("Структура",lang), getLocalizedWord("Структура",lang), "str")

        //if(cuser.hasRole(["struct_keeper", "supervisor"])) {
            docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Структура организации",lang), getLocalizedWord("Структура организации",lang), "structure", "Provider?type=page&id=structure"))
            docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Группы пользователей",lang), getLocalizedWord("Группы пользователей",lang), "group", "Provider?type=page&id=group"))
            docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Должность",lang), getLocalizedWord("Должность",lang), "post", "Provider?type=page&id=post&sortfield=VIEWTEXT2&order=ASC"))
            docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип подразделения",lang), getLocalizedWord("Тип подразделения",lang), "subdivisionlist", "Provider?type=page&id=subdivisionlist&sortfield=VIEWTEXT1&order=ASC"))
       // }

       // if(cuser.hasRole(["org_keeper", "supervisor"])){
            docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Организации",lang), getLocalizedWord("Организации",lang), "organizations", "Provider?type=page&id=organizations"))
       // }
        list.add(docs_outline)
        setContent(list)
    }
}
