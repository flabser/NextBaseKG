package form.corr

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
		glos.setForm("corr")
		glos.setName(webFormData.getValue("name"))
		doc.setValueString("shortname",webFormData.getValue("shortname"))
		doc.setValueString("corrid",webFormData.getValue("corrid"))
		doc.setValueString("email",webFormData.getValue("email"))
		doc.setValueString("typeofintegration",webFormData.getValue("typeofintegration"))
		glos.setCode(webFormData.getValue("code"))
		glos.setCategory(webFormData.getValue("corrcat"))

		glos.setViewText(glos.getName())
		glos.addViewText(glos.getCode())
		glos.addViewText(webFormData.getValue("corrid"))
		glos.addViewText(webFormData.getValue("email"))
		glos.addViewText(webFormData.getValue("typeofintegration"))
		glos.addViewText(glos.getShortName())
		glos.setViewNumber(1)
		def returnURL = session.getURLOfLastPage()
		if (doc.isNewDoc) {
			returnURL.changeParameter("page", "0");
		}
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("name") == ""){
			localizedMsgBox("Поле \"Имя корреспондента\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('name').length() > 2046){
			localizedMsgBox('Поле \'Имя корреспондента\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("shortname") == ""){
			localizedMsgBox("Поле \"Короткое имя корреспондента\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('shortname').length() > 2046){
			localizedMsgBox('Поле \'Короткое имя корреспондента\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("code") == ""){
			localizedMsgBox("Поле \"Код\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("corrcat") == ""){
			localizedMsgBox("Поле \"Категория\" не заполнено")
			return false
		}

		return true;
	}
}
