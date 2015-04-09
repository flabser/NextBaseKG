package help.page.outline

import kz.flabs.dataengine.Const
import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript;
import kz.nextbase.script.outline.*

class DoScript extends _DoScript{
	public void doProcess(_Session session, _WebFormData formData, String lang) {
	 
		def list = []
		def user = session. getCurrentAppUser()
		def outline = new _Outline("", "", "outline")
		def cdb = session.getCurrentDatabase();
		//def start_outline = new _Outline(getLocalizedWord("Домашняя страница",lang), getLocalizedWord("Домашняя страница",lang), "start")
		// Статьи видят все
		def docs_outline = new _Outline(getLocalizedWord("Статьи",lang), getLocalizedWord("Статьи",lang), "docs")
		docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Домашняя страница",lang), getLocalizedWord("Домашняя страница",lang), "homepage", "Provider?type=page&id=homepage&page=0"))
		docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Избранные",lang), getLocalizedWord("Избранные",lang), "favdocs", "Provider?type=page&id=favdocs&page=0"))
		def col = cdb.getGroupedEntries("category",1,400)
		col.each{ 
			try{
				String id = it.getViewText(0);
			
				def gl = cdb.getGlossaryDocument("category", "ddbid='$id'");
				def outlineEntry = new _OutlineEntry(gl.getViewText(), gl.getViewText(), "${gl.getID()}", "Provider?type=page&id=articlebycategory&category="+gl.getID()+"&page=0")
				def articles = cdb.getDocsCollection("category='$id' and parentdoctype#number=890", 1, 400).getBaseCollection();
				 
				for(def d in articles){
					 
					outlineEntry.addEntry(getResponses(d));
				}
				docs_outline.addEntry(outlineEntry)
			}catch(Exception e){}
			 
		} 
		
		list.add(docs_outline);
		if (user.hasRole(["administrator"])){
			def docs1_outline = new _Outline(getLocalizedWord("Справочники",lang), getLocalizedWord("Справочники",lang), "docs1")
			docs1_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категории",lang), getLocalizedWord("Категории",lang), "category", "Provider?type=page&id=category&page=0"))
			
			list.add(docs1_outline);
		}

        //def docsl = cdb.getCollectionOfDocuments("category='37H44HHeH45H6493'",1, true, false, true);
		setContent(list);
       // setContent(docsl)
	}

	
	// takes BaseDocument
	def getResponses(def d){
		def entry = new _OutlineEntry(d.getValueAsString("topic")[0], d.isFavourite().toString(), "article"+d.getDdbID(), "Provider?type=edit&element=document&id=articleview&docid="+d.getDdbID());
        d.fillResponses();
		if(d.getResponses().size()>0){
			for(def bd in d.getResponses()){
				entry.addEntry(getResponses(bd));
			}
		}
		return entry;
	}
}