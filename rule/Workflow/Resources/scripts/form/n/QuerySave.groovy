package form.n

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
		glos.setForm("n")
		glos.setName(webFormData.getValue("name"))
		glos.setCode(webFormData.getValue("code"))
		glos.setRank(webFormData.getValue("rank"))
		glos.setNomenclature(webFormData.getValue("ndelo"))
		doc.setValueString("storagelife",webFormData.getValueSilently("storagelife"))

		glos.setViewText(glos.getName())
		glos.addViewText(glos.getCode())
		def returnURL = session.getURLOfLastPage()
		if (doc.isNewDoc) {
			returnURL.changeParameter("page", "0");
		}
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("name") == ""){
			localizedMsgBox("Поле \"Номенклатура дел\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently('name').length() > 2046){
			localizedMsgBox('Поле \'Номенклатура дел\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently("code") == ""){
			localizedMsgBox("Поле \"Код\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("rank") == ""){
			localizedMsgBox("Поле \"Ранг\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("ndelo") == ""){
			localizedMsgBox("Поле \"Номенклатура\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("storagelife") == ""){
			localizedMsgBox("Поле \"Срок хранения\" не указано.")
			return false
		}

		return true;
	}
}
