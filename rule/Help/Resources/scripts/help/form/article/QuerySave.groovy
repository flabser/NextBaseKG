package help.form.article

import java.util.Map;

import kz.nextbase.script._CrossLink
import kz.nextbase.script._Document;
import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData;
import kz.nextbase.script.events._FormQuerySave;
import kz.nextbase.script._Helper;
import kz.nextbase.script._CrossLinkCollection;

class QuerySave extends _FormQuerySave {

	def validate(_WebFormData webFormData){

		if (webFormData.getValueSilently("topic") == ""){
			localizedMsgBox("Поле \"Заголовок\" не заполнено.");
			return false;
		}
		if (webFormData.getValueSilently("category") == ""){
			localizedMsgBox("Поле \"Категория\" не выбрано.");
			return false;
		}
		if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Содержание\" не заполнено.");
			return false;
		}
		return true;
	}

	@Override
	public void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

		println(webFormData)
		
		boolean v = validate(webFormData)
		if(v == false){
			stopSave()
			return
		}

		doc.addStringField("topic", webFormData.getValue("topic"))
		doc.doc.addStringField("briefcontent", webFormData.getValue("briefcontent"))
		doc.addStringField("category", webFormData.getValue("category"))
		def cdb = ses.getCurrentDatabase();
		def lc = new _CrossLinkCollection(ses)
		def linkedDocs = webFormData.getListOfValuesSilently("linked_docs");
		
		if (linkedDocs[0] != ""){
			linkedDocs.each{
				// ddbid
				if(it!=""){
					def ldoc = cdb.getDocumentByID(it)
					def crosslink = new _CrossLink(ses, ldoc)
					lc.add(crosslink);
				}
			}
			doc.addField("linked_docs", lc);
		}
		
		doc.addFile("rtfcontent", webFormData)
		
//		if(doc.isNewDoc){
//			doc.addEditor(ses.getCurrentAppUser().getUserID());
//			doc.addReader(ses.getCurrentAppUser().getUserID());
//            doc.addReader("[all]");
//		}
        doc.addReader("[article_reader]");
        doc.addEditor("[article_editor]");
        doc.addReader("[all]");

		doc.setViewText(webFormData.getValue("topic"));
		doc.addViewText(webFormData.getValue("topic"));
		doc.addViewText(doc.getGlossaryValue("category","ddbid='" + webFormData.getValue("category")+"'", "name"));
			
 
		//	doc.addViewText(webFormData.getValue("linked_docs"))
		//	doc.addViewText(webFormData.getValue("linked_docs_comment"))
		doc.setViewDate(new Date())
		doc.setForm("article")
		def returnURL = ses.getURLOfLastPage()
		setRedirectURL(returnURL)
	}
}

