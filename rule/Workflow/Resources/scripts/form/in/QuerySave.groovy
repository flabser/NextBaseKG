package form.in
import kz.nextbase.script._Document
import kz.nextbase.script._Helper
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

		println(webFormData)
		
		boolean v = validate(webFormData)
		if(v == false){
			stopSave()
			return
		}

		doc.setForm("in");
		doc.addStringField("sign", webFormData.getValueSilently("sign"))
		doc.addStringField("signedfields", webFormData.getValueSilently("signedfields"))
		doc.addStringField("in", webFormData.getValue("in"))
		String din = webFormData.getValue("din")
		if(din != "") doc.addDateField("din", _Helper.convertStringToDate(din))
		doc.addGlossaryField("corr", webFormData.getNumberValueSilently("corr",0))
		def recipients = webFormData.getListOfValuesSilently("recipient")

        doc.replaceListField("recipients", recipients as ArrayList);
		doc.addStringField("briefcontent", webFormData.getValue("briefcontent"))
		Date cDate = null
		String ctrldate = webFormData.getValueSilently("ctrldate")
		if(ctrldate != ""){
			cDate = _Helper.convertStringToDate(ctrldate)
		}
		doc.addDateField("ctrldate", cDate)
		doc.addGlossaryField("deliverytype", webFormData.getNumberValueSilently("deliverytype",0))
		doc.addStringField("author", webFormData.getValue("author"))
		doc.addFile("rtfcontent", webFormData)
		doc.addGlossaryField("vid", webFormData.getNumberValueSilently("vid",0))
		doc.addStringField("remark", webFormData.getValue("remark"))
		doc.addStringField("lang", webFormData.getValue("lang"))
		doc.addStringField("np", webFormData.getValue("np"))
		doc.addGlossaryField("project", webFormData.getNumberValueSilently("project",0))
		doc.addGlossaryField("category", webFormData.getNumberValueSilently("category",0))

		doc.addReader(webFormData.getListOfValuesSilently("recipient") as HashSet<String>)
		def returnURL = session.getURLOfLastPage()
        Date tDate = new Date()
        if (doc.isNewDoc || !doc.getValueString("vn")){
            def db = session.getCurrentDatabase()
            int num = db.getRegNumber('in_' + doc.getValueString("project"))
            String vnAsText = Integer.toString(num)
            doc.addStringField("mailnotification", "")
            doc.replaceStringField("vn", vnAsText)
            doc.replaceIntField("vnnumber",num)
            doc.replaceDateField("dvn", new Date())
			localizedMsgBox(getLocalizedWord("Документ зарегистрирован под № ",lang) + vnAsText)
			returnURL.changeParameter("page", "0");
		}

        doc.setViewText(getLocalizedWord('Входящий документ',lang) +' № '+ doc.getValueString('vnnumber') + '  ' + getLocalizedWord('от',lang) + ' ' + tDate.format("dd.MM.yyyy HH:mm:ss") + ' '+ session.getStructure().getEmployer(doc.getValueString('author')).shortName + ' : '+doc.getValueString('briefcontent'))
        doc.addViewText(doc.getValueString('briefcontent'))
        doc.addViewText("" + doc.getGlossaryValue("corr", "docid#number=" + doc.getValueString("corr"), "name"))
        doc.addViewText(doc.getValueString("vn"))
		doc.setViewNumber(doc.getValueNumber("vnnumber"))
		doc.setViewDate(doc.getValueDate("dvn"))
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено.")
			return false
		}
		if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}
		if (webFormData.getValueSilently('remark').length() > 2046){
			localizedMsgBox('Поле \'Содержание\' содержит значение превышающее 2046 символов');
			return false;
		}
		if (webFormData.getValueSilently("vid") == ""){
			localizedMsgBox("Поле \"Тип документа\" не указано.")
			return false
		}

		if (webFormData.getValueSilently("recipient") == ""){
			localizedMsgBox("Поле \"Кому адресован\" не выбрано.")
			return false
		}

		if (webFormData.getValueSilently("corr") == ""){
			localizedMsgBox("Поле \"Откуда поступил\" не выбрано.")
			return false
		}

		if (webFormData.getValueSilently("din") == ""){
			localizedMsgBox("Поле \"Дата исх. документа\" не указано.")
			return false
		}

		if (webFormData.getValueSilently("in") == ""){
			localizedMsgBox("Поле \"Исходящий №\" не заполнено.")
			return false
		}
        if (webFormData.getValueSilently("project") == " " || webFormData.getValueSilently("project") == ""){
            localizedMsgBox("Поле \"Связан с проектом\" не выбрано.");
            return false;
        }
		return true
	}
}
