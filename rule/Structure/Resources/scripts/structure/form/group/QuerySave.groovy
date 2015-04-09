package structure.form.group
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave
import kz.nextbase.script.struct._UserGroup

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

		//println(webFormData)

		boolean v = validate(webFormData)
		if(v == false){
			stopSave()
			return;
		}

		def user = ses.getCurrentAppUser()

		if (user.hasRole("supervisor")){
			def group  = (_UserGroup)doc;
			group.setGroupName(webFormData.getValueSilently("groupname"));
			group.setDescription(webFormData.getValueSilently("description"));
			group.setOwner(webFormData.getValueSilently("ownergroup"));
			group.resetMembers();
            group.setListOfMembers(webFormData.getListOfValuesSilently("members"));
			group.setListOfRoles(webFormData.getListOfValuesSilently("role"));
			//group.setViewText(webFormData.getValue("groupname"));
			doc.setViewText(webFormData.getValueSilently('ownergroup') );
			doc.addViewText(webFormData.getValueSilently("groupname"));
			doc.setViewDate(new Date());
		}
        setRedirectURL(ses.getURLOfLastPage());
	}

	def validate(_WebFormData formData){

		if (formData.getValueSilently("groupname") == ""){
			localizedMsgBox("Поле \"Название группы\" не заполнено.");
			return false;
		}
		if (formData.getValueSilently('groupname').length() > 2046){
			localizedMsgBox('Поле \'Название группы\' содержит значение превышающее 2046 символов');
			return false;
		}
		return true;

	}
}
