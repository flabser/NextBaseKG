package help.page.search

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript
import nextbase.groovy.*

class DoScript extends _DoScript {
	
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def db = session.getCurrentDatabase();
		
		//def page = formData.getValueSilently("page"); 
		//def col = db.search(formData.getValueSilently("keyword"), Integer.parseInt(page));
		//setContent(col);
		String keyword = new String(((String)formData.getValueSilently("keyword")).getBytes("ISO-8859-1"),"UTF-8");
		println(keyword)
		def rootTag = new _Tag("query");
		def docs = db.getDocsCollection("form = 'article' and viewtext ~'$keyword'",1,400).getBaseCollection();
		
		for(def bd in docs){
			def entry = new _Tag("entry");
			entry.setAttr("id", bd.getDdbID());
			entry.setAttr("docid", bd.getDocID());
			entry.setAttr("viewtext", bd.getViewText());
			
			rootTag.addTag(entry);
		}
		
		def xml = new _XMLDocument(rootTag);
		setContent(xml);
	}
}
