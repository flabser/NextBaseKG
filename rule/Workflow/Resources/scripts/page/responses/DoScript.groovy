package page.responses
import java.text.SimpleDateFormat
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript
import nextbase.groovy.*

class DoScript extends _DoScript {
	
	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def page = 1;
		if (formData.containsField("page") && formData.getValue("page")){
			page = Integer.parseInt(formData.getValue("page"))
		}
		def db = session.getCurrentDatabase()
		def docid =formData.getValue("docid");
		def doctype =formData.getValue("doctype");
		if(doctype == '887'){
			doctype = '894'
		}
		String sf = "parentdocid = " + docid +" and parentdoctype = "+ doctype
		def viewParam = session.createViewEntryCollectionParam()
				.setPageNum(0)
				.setPageSize(0)
				.setUseFilter(true)
				.setCheckResponse(true)
		
		def collection
		if (doctype == '894'){		
			collection = db.getCollectionOfGlossaries(viewParam.setQuery(sf))
		}else{
			collection = db.getCollectionOfDocuments(viewParam.setQuery(sf))
		}
		setContent(collection)
	}
}