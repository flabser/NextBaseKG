package structure.page.delete_document
import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		println(formData)

		def deletedList = []
		def unDeletedList = []

		def db = session.getCurrentDatabase()
		def documentid_col = formData.getListOfValuesSilently("docid")
        def doctype = formData.getNumberValueSilently("doctype", 890)
		for(def id:documentid_col){
			if (id == "null"){
				unDeletedList << new _Tag("entry","error=docid is \"null\"")
			}else{
				try{
                    def doc
                    if (doctype != 900) {
                        doc = db.getDocumentByID(id)
                    } else {
                        doc = db.getDocumentByComplexID(doctype, id.toInteger())
                    }
					def viewText = doc.getViewText()
					try{
						if(db.deleteDocument(id, true)){
							deletedList << new _Tag("entry",viewText)
						}else{
							unDeletedList << new _Tag("entry",viewText)
						}
					}catch(Exception e){
						println(e)
						unDeletedList << new _Tag("entry",viewText)
					}
				}catch(_Exception e){
					unDeletedList << new _Tag("entry","error=" + e.getMessage())
				}
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
