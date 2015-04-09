package knowledgebase.form.subcategory

import java.text.SimpleDateFormat
import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.events._FormQuerySave

class QuerySave  extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
		 
		boolean v = validate(webFormData);
		if(v == false){
			stopSave()
			return;
		}
		
		def glos = (_Glossary)doc;
		glos.setForm("subcategory")
		glos.setName(webFormData.getValue("name"))
				
		glos.setViewText(glos.getName());
		def parentid = webFormData.getValue("category");
		def parentdoc = ses.getCurrentDatabase().getGlossaryDocument("category","ddbid='$parentid'");
		glos.setParentDoc(parentdoc)
		
		def returnURL = ses.getURLOfLastPage();
		if (doc.isNewDoc) {
			returnURL.changeParameter("page", "0");
		}
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("name") == ""){
			localizedMsgBox("Поле \"Название\" не заполнено")
			return false
		}

		return true;
	}

}
