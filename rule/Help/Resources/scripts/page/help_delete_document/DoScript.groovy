package page.help_delete_document


import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.outline.*;

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		println(formData)

		def deletedList = []
		def unDeletedList = []
		
		def db = session.getCurrentDatabase()
		def documentid_col = formData.getListOfValuesSilently("docid")
		for(def id:documentid_col){
			def doc = db.getDocumentByID(id)
			def viewText = doc.getViewText();
			// get responses
			//def resp = doc.getDescendants();
			doc.doc.fillResponses();
			def resp = doc.doc.getResponses();
			try{
				if(db.deleteDocument(id, true)){
					deletedList << new _Tag("entry",viewText)
					for(def rdoc in resp){
						db.deleteDocument(rdoc.getDdbID(), true);
					}
				}else{
					unDeletedList << new _Tag("entry",viewText)
				}
			}catch(Exception e){
				println(e)
				unDeletedList << new _Tag("entry",viewText)
			}
		}
		
		def rootTag = new _Tag(formData.getValue("id"),"")
		def d = new _Tag("deleted",deletedList)
		d.setAttr("count", deletedList.size())
		rootTag.addTag(d)
		def ud = new _Tag("undeleted",unDeletedList)
		ud.setAttr("count", unDeletedList.size())
		rootTag.addTag(ud)
				
		def xml = new _XMLDocument(rootTag)
		//println(xml)
		setContent(xml);
	}
}

