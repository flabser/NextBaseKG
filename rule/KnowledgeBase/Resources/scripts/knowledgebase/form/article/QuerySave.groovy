package knowledgebase.form.article

import kz.nextbase.script.*
import kz.nextbase.script.events._FormQuerySave


class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

		//println(webFormData)

		boolean v = validate(webFormData)
		if(v == false){
			stopSave()
			return
		}

		doc.addStringField("topic", webFormData.getValueSilently("topic"))
		doc.addStringField("briefcontent", webFormData.getValueSilently("briefcontent"))
		doc.addStringField("category", webFormData.getValueSilently("category"))
		doc.addStringField("subcategory", webFormData.getValueSilently("subcategory"))
		doc.addStringField("content", webFormData.getValueSilently("content"))
		doc.addFile("rtfcontent", webFormData)

		doc.addStringField("editors", "")
		def editors = webFormData.getListOfValuesSilently("editors")
//		for (String editor : editors) {
//			if(editor != ""){
			//	doc.addValueToList("editors", editor)
//			}
//		}

		def readers = webFormData.getListOfValuesSilently("readers")
//		for (String reader : readers) {
//			if(reader != ""){
			//	doc.addValueToList("readers", reader)
//			}
//		}

		doc.clearReaders()
		doc.clearEditors()
        println(readers)
		doc.addEditor(doc.getAuthorID())
		doc.addReader(doc.getAuthorID())

		for (String reader: readers) {
			doc.addReader(reader)
		}
		for (String editor: editors) {
			doc.addEditor(editor)
		}

		doc.setViewText(webFormData.getValueSilently("topic"))
		doc.addViewText(doc.getGlossaryValue("category", "ddbid='" + webFormData.getValueSilently("category") + "'", "name"))
		doc.addViewText(doc.getGlossaryValue("subcategory", "ddbid='" + webFormData.getValueSilently("subcategory") + "'", "name"))

		// notification
		if(doc.isNewDoc) {
			doc.addViewText("0")
		} else {
			doc.addViewText("1")
		}
		doc.setForm("article")
		def returnURL = ses.getURLOfLastPage()
		setRedirectURL(returnURL)
	}

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("topic") == ""){
			localizedMsgBox("Поле \"Заголовок\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("category") == ""){
			localizedMsgBox("Поле \"Категория\" не выбрано")
			return false
		}else if (webFormData.getValueSilently("subcategory") == ""){
			localizedMsgBox("Поле \"Подкатегория\" не выбрано")
			return false
		}else if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Содержание\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("briefcontent").length() > 2046){
			localizedMsgBox("Поле \"Содержание\" содержит значение превышающее 2046 символов")
			return false
		}

		return true
	}
}
