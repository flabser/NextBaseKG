package form.l

import java.text.SimpleDateFormat
import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.events.*;
import kz.nextbase.script._Helper;


class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		
		println(webFormData)
		
		boolean v = validate(webFormData);
		if(v == false){
			stopSave()
			return;
		}

		doc.setForm("L");
		doc.addDateField("dvn", new Date());
		doc.addStringField("briefcontent", webFormData.getValue("briefcontent"));
		doc.addStringField("np", webFormData.getValue("np"));
		doc.addStringField("np2", webFormData.getValue("np2"));
		doc.addStringField("vn", webFormData.getValue("vn"));
		doc.addStringField("fio", webFormData.getValue("fio"));
		doc.addStringField("author", webFormData.getValue("author"));

		webFormData.containsField("otype") ? doc.addStringField("otype", webFormData.getValue("otype")) : println("");
		doc.addStringField("regionview", webFormData.getValue("regionview"));
		doc.addStringField("har", webFormData.getValue("har"));
		doc.addStringField("recipient", webFormData.getValue("recipient"));
		doc.addReader(doc.getValueString("recipient"))
		doc.addStringField("address", webFormData.getValue("address"));
		doc.addStringField("lang", webFormData.getValue("lang"));
		doc.addStringField("vid", webFormData.getValue("vid"));

		webFormData.containsField("comment") ? doc.addStringField("comment", webFormData.getValue("comment")) : println("");
		webFormData.containsField("vid") ? doc.addStringField("vid", webFormData.getValue("vid")) : println("");

		doc.addStringField("resultview", webFormData.getValue("resultview"));
		doc.addStringField("phone", webFormData.getValue("phone"));

		doc.addStringField("private", webFormData.getValue("private"));

		String din = webFormData.getValue("ctrldate");
		if(din != "") doc.addDateField("ctrldate", _Helper.convertStringToDate(din));


		doc.addStringField("remark", webFormData.getValue("remark"));
		doc.addFile("rtfcontent", webFormData)
		if (doc.isNewDoc ){
			def db = session.getCurrentDatabase();
			int num = db.getRegNumber('l');
			String vnAsText =  Integer.toString(num);
			doc.addStringField("vn", vnAsText);
			doc.addNumberField("vnnumber",num);
			localizedMsgBox(getLocalizedWord("Документ зарегистрирован под № ",lang) + vnAsText)
		}
		def nowdate = new Date()
		doc.setViewText(getLocalizedWord('Обращение',lang) + ' № ' + doc.getValueString("vn") + ' ' + getLocalizedWord('от',lang)  + ' ' +  nowdate.format("dd.MM.yyyy HH.mm.ss")+ ' ' + session.getStructure().getEmployer(doc.getValueString('author')).shortName + ' : ' + doc.getValueString('briefcontent'))
        doc.addViewText(doc.getValueString('briefcontent'))
		doc.addViewText(session.getStructure().getEmployer(doc.getValueString("recipient")).getShortName())
		doc.addViewText(doc.getValueString("vn"))
		doc.addViewText(doc.getValueString("briefcontent"))
		doc.setViewNumber(doc.getValueNumber("vnnumber"))
		doc.setViewDate(doc.getValueDate("dvn"))
		
		def redirectURL = session.getLastPageURL()
		setRedirectURL(redirectURL)

	}


	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("fio") == ""){
			localizedMsgBox("Поле \"Ф.И.О.\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("recipient") == ""){
			localizedMsgBox("Поле \"Получатель\" не выбрано.")
			return false
		}else if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено.");
			return false
		}else if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently('remark').length() > 2046){
			localizedMsgBox('Поле \'Примечание\' содержит значение превышающее 2046 символов');
			return false;
		}
		return true;
	}
}
