package knowledgebase.page.actionbar

import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class RecycleBin extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session)
		def user = session.getCurrentAppUser()
		if (user.hasRole(["supervisor", "administrator"])){
			actionBar.addAction(new _Action(getLocalizedWord("Удалить из корзины", lang),
					getLocalizedWord("Удалить из корзины", lang), "CLEAR_RECYCLEBIN"))
			actionBar.addAction(new _Action(getLocalizedWord("Восстановить документ", lang),
					getLocalizedWord("Восстановить документ", lang), "RECOVER_RECYCLEBIN"))
		}
		setContent(actionBar)
	}
}
