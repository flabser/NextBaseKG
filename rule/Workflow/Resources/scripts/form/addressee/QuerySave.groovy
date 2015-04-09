package form.addressee

import java.text.SimpleDateFormat
import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.events._FormQuerySave
class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		
		println(webFormData)
		
		boolean v = validate(webFormData);
		if(v == false){
			stopSave()
			return;
		}
		
		def glos = (_Glossary)doc;
		doc.setParentDocID(webFormData.getValue("parentdocid").toInteger())
		doc.setParentDocType(webFormData.getValue("parentdoctype").toInteger())
		glos.setForm("addressee")
		glos.setName(webFormData.getValue("fullname"))
		doc.setValueString("shortname",webFormData.getValue("shortname"))
		doc.setValueString("fullname",webFormData.getValue("fullname"))
		doc.setValueString("extid",webFormData.getValue("extid"))
		glos.setViewText(glos.getName())
		glos.addViewText(webFormData.getValue("fullname"))
		glos.addViewText(webFormData.getValue("shortname"))
		glos.addViewText(webFormData.getValue("extid"))
		glos.addViewText("addressee")
		glos.setViewNumber(2)
		def returnURL = session.getURLOfLastPage()
		if (doc.isNewDoc) {
			returnURL.changeParameter("page", "0");
		}
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("fullname") == ""){
			localizedMsgBox("Поле \"Полное имя\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('fullname').length() > 2046){
			localizedMsgBox('Поле \'Полное имя\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("shortname") == ""){
			localizedMsgBox("Поле \"Сокращенное имя\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('shortname').length() > 2046){
			localizedMsgBox('Поле \'Сокращенное имя\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("extid") == ""){
			localizedMsgBox("Поле \"ID во внешней системе\" не заполнено")
			return false
		}

		return true;
	}
}
