package knowledgebase.page.views

import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData;
import kz.nextbase.script.events._DoScript;

class ArticlesByCategory extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {

		def db = session.getCurrentDatabase();
		def page = formData.getValue("page").toInteger();
		def cat =  formData.getValueSilently("category")
		def col = db.getCollectionOfDocuments("form = 'article' and category='$cat'", page, false, true);
		setContent(col)
	}
}
