package page.help_articlebycategory

import kz.nextbase.script._Session;
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData;
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript;
import kz.nextbase.script.outline._OutlineEntry

class DoScript extends _DoScript{

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def cdb = session.getCurrentDatabase();
		def category = formData.getValueSilently("category");
		def rootTag = new _Tag("query");
		def docs = cdb.getDocsCollection("form = 'article' and category='$category' and parentdoctype#number=890",1,400).getBaseCollection();
		
		for(def bd in docs){
			rootTag.addTag(getResponses(bd));
		}
		
		def xml = new _XMLDocument(rootTag);
		setContent(xml);
	}
	
	def getResponses(def bd){
		def entry = new _Tag("entry");
		entry.setAttr("id", bd.getDdbID());
		entry.setAttr("docid", bd.getDocID());
		entry.setAttr("viewtext", bd.getViewText());
		
		bd.fillResponses();
		if(bd.getResponses().size()>0){
			for(def d in bd.getResponses()){
				entry.addTag(getResponses(d));
			}
		} 
		return entry; 
	}
}
