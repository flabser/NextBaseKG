package help.page.article

import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		// TODO Auto-generated method stub
		def cdb = session.getCurrentDatabase();
		def id = formData.getValueSilently("docID");
		def rootTag = new _Tag("query");
		
		if(id == ""){
			return;
		}
		
		try{
			def doc = cdb.getDocumentByID(id);
			rootTag.addTag(new _Tag("topic", doc.getValueString("topic")));
			rootTag.addTag(new _Tag("briefcontent", doc.getValueString("briefcontent")));
			rootTag.addTag(new _Tag("url", doc.getFullURL()));
			def catTag = new _Tag("category", doc.doc.getViewTextList()[2])
			catTag.setAttr("id",  doc.getValueString("category"));
			rootTag.addTag(catTag);
			try{
				def linkeddocs = new _Tag("linked_docs");
				def lc = ((_CrossLinkCollection) doc.getValueObject("linked_docs")).getBaseObject().getLinkCollection();
				lc.each{
					def entry = new _Tag("entry", it.getViewText());
					entry.setAttr("url", it.getURL());
					linkeddocs.addTag(entry);
				}
				
				rootTag.addTag(linkeddocs);
				 
			}catch(Exception e){}
			
			// extract attached files
			try{
				 
			}catch(Exception e){
			}
			
			rootTag.setAttr("favourites", doc.doc.isFavourite());
			rootTag.setAttr("docid", doc.getDocID());
			rootTag.setAttr("id", doc.getID());
			
			// иерархия статей
			try{
				def pdoc = doc.getParentDocument();
				def list = [];
				def hTag = new _Tag("hierarchy");
				if(pdoc != null){
					list = getParentDocs(pdoc, list);
				}
				
				for(int i = list.size()-1; i >=0; --i){
					hTag.addTag(list[i]);   
				}
				rootTag.addTag(hTag);
			}catch(Exception e){}
			
		}catch(Exception e){println(e.toString())}
		
		def xml = new _XMLDocument(rootTag);
		setContent(xml);
	} 
	
	def getParentDocs(def pdoc, list){
		def entry = new _Tag("entry");
		entry.setAttr("viewtext", pdoc.getViewText());
		entry.setAttr("url", "Provider?type=page&id=article&docID=${pdoc.getID()}&page=1");
		list.add(entry);
		def ppdoc = pdoc.getParentDocument();
		if(ppdoc != null){
			list = getParentDocs(ppdoc, list);		
		}
		return list;
	}
}
