package form.out
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
			
		Date tDate = null
					
		doc.form = "out"			
		doc.addStringField("briefcontent", webFormData.getValue("briefcontent"))
		doc.addStringField("signedby", webFormData.getValue("signedby"))
		doc.addNumberField("category", webFormData.getNumberValueSilently("category",-1))
		doc.addNumberField("project", webFormData.getNumberValueSilently("project",-1))

        doc.replaceListField("corr", webFormData.getListOfValuesSilently("corr") as List<String>)

		doc.addNumberField("deliverytype", webFormData.getNumberValueSilently("deliverytype",0))
		doc.addStringField("lang", webFormData.getValue("lang"))
		doc.addNumberField("vid", webFormData.getNumberValueSilently("vid",0))
		doc.addNumberField("blanknumber", webFormData.getNumberValueSilently("blanknumber",0))
		doc.addNumberField("np", webFormData.getNumberValueSilently("np",1))
		doc.addNumberField("np2", webFormData.getNumberValueSilently("np2",1))
		doc.addNumberField("nomentype", webFormData.getNumberValueSilently("nomentype",0))
		doc.addStringField("contentsource", webFormData.getValue("contentsource"))
		doc.addFile("rtfcontent", webFormData)

        Date dates = new Date()

		def redirectURL = session.getURLOfLastPage()
		
		def vnAsText
		if (doc.isNewDoc || !doc.getValueString("vn")){
			def db = session.getCurrentDatabase()
            int num = db.getRegNumber("out_" + webFormData.getValueSilently("project"))
			vnAsText = Integer.toString(num)
			def nomenvalue = doc.getGlossaryValue("n", "docid#number=" + doc.getValueInt("nomentype"), "ndelo")
			def depid = session.getCurrentAppUser().getDepartmentID();
			def depindex  = session.getStructure().getDepartment(depid, session).getValueString("index");
			if (nomenvalue != ''){
				nomenvalue = nomenvalue + "/"
			}
			if (depindex != ''){
				depindex = depindex + "-"
			}
			vnAsText = depindex + nomenvalue + vnAsText
			doc.replaceStringField("vn", vnAsText)
			doc.replaceIntField("vnnumber",num)
			doc.replaceDateField("dvn", new Date())
			localizedMsgBox(getLocalizedWord("Документ зарегистрирован под № ",lang) + vnAsText);
			redirectURL.changeParameter("page", "0")
		//	doc.addStringField("mailnotification", "")
			doc.setViewNumber(num)
		}
		doc.setViewText(getLocalizedWord('Исходящий документ',lang) + ' № ' + vnAsText + ' ' + getLocalizedWord('от',lang) + ' ' + dates.format("dd.MM.yyyy HH.mm.ss") + ' ' + session.getStructure().getEmployer(doc.getValueString('author')).shortName + ' : ' + doc.getValueString('briefcontent'))
		doc.addViewText(doc.getValueString('briefcontent'))
		doc.addViewText(session.dataBase.getGlossaryCustomFieldValueByID(webFormData.getValueSilently("corr").toInteger(), "name"))
		doc.setViewDate(_Helper.convertStringToDate(doc.getValueString("dvn")))
		setRedirectURL(redirectURL)
			 
	}
	
	def validate(_WebFormData webFormData){
		
		if (webFormData.getValueSilently("deliverytype") == ""){
			localizedMsgBox("Поле \"Вид доставки\" не заполнено.");
			return false;
		}
		
		if (webFormData.getValueSilently("signedby") == ""){
			localizedMsgBox("Поле \"Кто подписал\" не выбрано.");
			return false;
		}
		
		if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено.");
			return false;
		}
		if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}
		if (webFormData.getValueSilently('contentsource').length() > 2046){
			localizedMsgBox('Поле \'Содержание\' содержит значение превышающее 2046 символов');
			return false;
		}
		if (webFormData.getValueSilently("corr") == ""){
			localizedMsgBox("Поле \"Получатель\" не выбрано.");
			return false;
		}
		if (webFormData.getValueSilently("nomentype") == ""){
			localizedMsgBox("Поле \"Номенклатура дел\" не выбрано.");
			return false;
		}
        if (webFormData.getValueSilently("project") == " " || webFormData.getValueSilently("project") == ""){
            localizedMsgBox("Поле \"Связан с проектом\" не выбрано.");
            return false;
        }
		return true;
		
	}
}
