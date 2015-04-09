package structure.form.organization
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave
import kz.nextbase.script.struct._Organization

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

		println(webFormData)
		
		boolean v = validate(webFormData)
		if(v == false){
			stopSave()
			return;
		}

		def org  = (_Organization)doc;
		org.setFullName(webFormData.getValueSilently("fullname"));
		org.setShortName(webFormData.getValueSilently("shortname"));
		org.setAddress(webFormData.getValueSilently("address"));
		org.setComment(webFormData.getValueSilently("comment"));
		org.setBIN(webFormData.getValueSilently("bin"));
		org.setViewText(org.getFullName());

	}

	def validate(_WebFormData formData){

		if (formData.getValueSilently("fullname") == ""){
			localizedMsgBox("Поле \"Название\" не заполнено.");
			return false;
		}else if (formData.getValueSilently('fullname').length() > 2046){
			localizedMsgBox('Поле \'Название\' содержит значение, превышающее 2046 символов');
			return false;
		}else if (formData.getValueSilently("shortname") == ""){
			localizedMsgBox("Поле \"Сокращенное название\" не заполнено.");
			return false;
		}else if (formData.getValueSilently('shortname').length() > 2046){
			localizedMsgBox('Поле \'Сокращенное название\' содержит значение, превышающее 2046 символов');
			return false;
		}else if (formData.getValueSilently("bin") == ""){
            localizedMsgBox("Поле \"БИН\" не заполнено.");
            return false;
        }else if (formData.getValueSilently('bin').length() != 12){
            localizedMsgBox('Поле \'БИН\' содержит некорректное количество символов');
            return false;
        }
        return true;
		
	}
}
