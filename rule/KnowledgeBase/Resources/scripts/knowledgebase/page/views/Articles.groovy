package knowledgebase.page.views

import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData;
import kz.nextbase.script.events._DoScript;

class Articles extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		
		def db = session.getCurrentDatabase();
		def page = formData.getValueSilently("page");
		int _page = page != "" ? page.toInteger() : 0;
		def col = db.getCollectionOfDocuments("form = 'article'", _page, false, true);
		setContent(col)
	}
}