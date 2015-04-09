package help.page.outline


import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

class OutlineFavDocs extends _DoScript{
	public void doProcess(_Session session, _WebFormData formData, String lang) {
	 
		def list = []
		def user = session.getCurrentAppUser()
		def cdb = session.getCurrentDatabase();
		def fdocs = cdb.getDocsCollection("favorites#number = 1", 0, 0);
		// Статьи видят все
		//def docs_outline = new _Outline(getLocalizedWord("Статьи",lang), getLocalizedWord("Статьи",lang), "docs")
		//docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Домашняя страница",lang), getLocalizedWord("Домашняя страница",lang), "homepage", "Provider?type=page&id=homepage&page=0"))
		
		setContent(list);
	}
}