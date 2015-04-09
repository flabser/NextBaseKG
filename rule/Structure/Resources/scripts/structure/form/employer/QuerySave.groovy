package structure.form.employer

import java.util.ArrayList;
import java.text.SimpleDateFormat
import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.struct.*
import kz.nextbase.script._Helper;

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

		println(webFormData)

		boolean v = validate(webFormData)
		if(v == false){
			stopSave()
			return;
		}

		def emp  = (_Employer)doc;
		emp.setUserID(webFormData.getValueSilently("userid"));
		emp.setFullName(webFormData.getValueSilently("fullname"));
		emp.setShortName(webFormData.getValueSilently("shortname"));
		emp.setComment(webFormData.getValueSilently("comment"));
		emp.setIndex(webFormData.getValueSilently("index"));
		emp.setRank(webFormData.getValueSilently("rank"));
		emp.setPhone(webFormData.getValueSilently("phone"));
		emp.setPostID(webFormData.getValueSilently("post"));
		emp.setSendTo(webFormData.getValueSilently("sendto"));
		emp.setObl(webFormData.getValueSilently("obl"));
		emp.setRegion(webFormData.getValueSilently("region"));
		emp.setVillage(webFormData.getValueSilently("village"));	
		emp.setPasswordHash(webFormData.getValueSilently("password").trim());
		emp.setEmail(webFormData.getValueSilently("email"));
		emp.setMessenger(webFormData.getValueSilently("instmsgaddress"));
		emp.setDepID(webFormData.getValueSilently("depid"));
		String birthDate = webFormData.getValueSilently("birthdate");
		if (birthDate) {
			def bd = _Helper.convertStringToDate(birthDate)
			println(bd)
			if (bd) emp.setBirthDate(bd)
		}
		
		if(webFormData.getValueSilently("fired") == "1"){
			emp.setStatus(_EmployerStatusType.FIRED)
		}else{
			emp.setStatus(_EmployerStatusType.HIRED)
		}

		def user = ses.getCurrentAppUser()
	
		if (user.hasRole("supervisor")){
			emp.setListOfRoles(webFormData.getListOfValuesSilently("role"));
			def apps = webFormData.getListOfValuesSilently("enabledapps");
			//def lm = webFormData.getListOfValuesSilently("loginmode");
			//String[] apps = ["Workflow","Support2"]
			//String[] lm = ["0","0"]
			if (apps.length > 0){
				emp.clearEnabledAppsList();
				for(int i = 0; i < apps.length; i++){
					if (!apps[i].equals("")){
						def profile = new _UserApplicationProfile(apps[i],"0");
						if(profile.needQuestAnsw()){
							profile.addQuestionAnswer((String[])webFormData.getListOfValuesSilently("question_" + profile.getAppName()), (String[])webFormData.getListOfValuesSilently("answer_" + profile.getAppName()));
						}
						emp.addEnabledApp(profile);
					}
				}
			}
		}
		
		emp.setViewText(emp.getFullName());
		emp.addViewText(emp.getRank().toString());
		if(webFormData.getValueSilently("fired") == "1"){
			emp.addViewText("-1");
		}

	}

	def validate(_WebFormData formData){
		def valemail = _Validator.checkEmail(formData.getValueSilently("email"));
		def valphone = _Validator.checkPhoneNumber_kz(formData.getValueSilently("phone"));
		def valbdate = true;

		if(formData.getValueSilently("birthdate")!= "" ){
			String birthDate = formData.getValueSilently("birthdate");
			valbdate =_Validator.checkDate(birthDate);
		}
		if (formData.getValueSilently("userid") == ""){
			localizedMsgBox("Поле \"UserID\" не заполнено.");
			return false;
		}
		if (formData.getValueSilently("rank") == ""){
			localizedMsgBox("Поле \"Ранг\" не заполнено.");
			return false;
		}
		if (formData.getValueSilently("post") == ""){
			localizedMsgBox("Поле \"Должность\" не выбрано.");
			return false;
		}
		if (formData.getValueSilently("shortname") == ""){
			localizedMsgBox("Поле \"Сокращенное имя\" не заполнено.");
			return false;
		}
		if (formData.getValueSilently('shortname').length() > 2046){
			localizedMsgBox('Поле \'Сокращенное имя\' содержит значение превышающее 2046 символов');
			return false;
		}
		if (formData.getValueSilently("fullname") == ""){
			localizedMsgBox("Поле \"Полное имя\" не заполнено.");
			return false;
		}
		if (formData.getValueSilently('fullname').length() > 2046){
			localizedMsgBox('Поле \'Полное имя\' содержит значение превышающее 2046 символов');
			return false;
		}
		if  (!valemail && formData.getValueSilently("email")!= "" ){
			localizedMsgBox("Поле \"Email\" заполнено неверно.");
			return false;
		}
		if  (!valphone && formData.getValueSilently("phone")!= "" ){
			localizedMsgBox("Поле \"Телефон\" заполнено неверно.");
			return false;
		}
		if  (!valbdate){
			localizedMsgBox("Поле \"Дата рождения\" заполнено неверно.");
			return false;
		}
		if  (formData.getValueSilently("password") != formData.getValueSilently("repassword")){
			localizedMsgBox("Поле \"Поля 'Пароль' и 'Повтор пароля'\" не совпадают.");
			return false;
		}
		return true;

	}
}
