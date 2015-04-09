package structure.form.post

import kz.nextbase.script._Document
import kz.nextbase.script._Glossary
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave

/**
 * Created by Bekzat on 4/15/14.
 */
class QuerySave extends _FormQuerySave {

    @Override
    void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
        println(webFormData)
        if(validate(webFormData) == false){
            stopSave()
            return;
        }

        def glos = (_Glossary)doc;
        glos.setForm("post")
        glos.setName(webFormData.getValue("name"))
        glos.setCode(webFormData.getValue("code"))
        glos.setRankText(webFormData.getValue("ranktext"))
        glos.setViewText(glos.getName());
        glos.addViewText(glos.getCode())
        glos.addViewText(glos.getRankText());
        setRedirectURL(ses.getURLOfLastPage());
    }

    def validate(_WebFormData webFormData){

        if (webFormData.getValueSilently("name") == ""){
            localizedMsgBox("Поле \"Заказчик\" не заполнено")
            return false
        }
        if (webFormData.getValueSilently("code") == ""){
            localizedMsgBox("Поле \"Код\" не заполнено.");
            return false
        }
        if (webFormData.getValueSilently("ranktext") == ""){
            localizedMsgBox("Поле \"Ранг\" не заполнено.");
            return false
        }
        return true;
    }
}
