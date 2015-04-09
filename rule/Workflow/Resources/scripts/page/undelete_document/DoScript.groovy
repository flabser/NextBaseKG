package page.undelete_document
import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		println(formData)

		def restoredList = []
		def unRestoredList = []

		def db = session.getCurrentDatabase()
		def documentid_col = formData.getListOfValuesSilently("docid")
		for(def id:documentid_col){
			if (id == "null"){
                unRestoredList << new _Tag("entry","error=docid is \"null\"")
			}else{
				try{

					def doc = db.getDocumentByID(id)
					def viewText = doc.getViewText()
					try{
						if(db.unDeleteDocument(id)){
							restoredList << new _Tag("entry",viewText)
						}else{
							unRestoredList << new _Tag("entry",viewText)
						}
					}catch(_Exception e){
                        unRestoredList << new _Tag("entry",viewText + ",error=" + e.getLocalizedMessage())
					}

				}catch(_Exception e){
                    unRestoredList << new _Tag("entry","error=" + e.getLocalizedMessage() + ". docid=" + id )
				}
			}
		}

		def rootTag = new _Tag(formData.getValue("id"),"")
		def d = new _Tag("restored", restoredList)
		d.setAttr("count", restoredList.size())
		rootTag.addTag(d)
		def ud = new _Tag("unrestored",unRestoredList)
		ud.setAttr("count", unRestoredList.size())
		rootTag.addTag(ud)

		def xml = new _XMLDocument(rootTag)
		setContent(xml);
	}
}
