package knowledgebase.page.views

import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData;
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.events._DoScript;

class Search extends _DoScript {
	
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		println(formData)
		def page = 1;
        if (formData.containsField("page")) {
            page = formData.getNumberValueSilently("page", 1)
        }
		def db = session.getCurrentDatabase()
		def col = db.search(formData.getValue("keyword"), page)
		
		setContent(col)
		
		def actionBar = new _ActionBar(session);
		def newDocAction = new _Action(getLocalizedWord("Вернуться к списку документов", lang),getLocalizedWord("Вернуться к списку документов", lang),"custom")
		newDocAction.setURL(session.getURLOfLastPage().urlAsString)
		actionBar.addAction(newDocAction);
		setContent(actionBar);
		
		return;
	}
}
 