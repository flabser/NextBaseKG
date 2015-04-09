package form.in
import kz.nextbase.script._Document
import kz.nextbase.script._Exception
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen

class QueryOpen extends _FormQueryOpen {

	
	@Override
	public void doQueryOpen(_Session ses, _WebFormData webFormData, String lang) {
		def user = ses.getCurrentAppUser()
		
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = ses.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)

		publishValue("title",getLocalizedWord("Входящий документ", lang))
		publishEmployer("author", ses.getCurrentAppUser().getUserID())
		publishValue("dvn", ses.getCurrentDateAsString())
		publishValue("ctrldate", ses.getCurrentDateAsString(30))
	}


	@Override
	public void doQueryOpen(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
		def user = ses.getCurrentAppUser()
		
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = new _ActionBar(ses)
		def show_compose_actions = false
		def recipients = doc.getValueList("recipients")
		for (String recipient: recipients) {
			if(recipient == user.getUserID()){
				show_compose_actions = true
			}
		}
		if(show_compose_actions){
			actionBar.addAction(new _Action(getLocalizedWord("Резолюция",lang),getLocalizedWord("Резолюция",lang),"compose_task"))
			actionBar.addAction(new _Action(getLocalizedWord("Исполнить",lang),getLocalizedWord("Исполнить",lang),"compose_execution"))
		}
		
		if(doc.getEditMode() == _DocumentModeType.EDIT){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		if(user.hasRole("supervisor")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
		publishValue("title",getLocalizedWord("Входящий документ", lang) + " ")
		publishEmployer("author",doc.getAuthorID())
		publishValue("vn",doc.getValueString("vn"))
		publishValue("dvn",doc.getValueString("dvn"))
		publishValue("in",doc.getValueString("in"))

		if (doc.getField("vid")) {
			publishGlossaryValue("vid",doc.getValueGlossary("vid"))
		}

		if (doc.getField("corr")) {
			publishGlossaryValue("corr", doc.getValueGlossary("corr"))
		}

		if (doc.getField("deliverytype")) {
			publishGlossaryValue("deliverytype", doc.getValueGlossary("deliverytype"))
		}

		if (doc.getField("project")) {
			publishGlossaryValue("project", doc.getValueGlossary("project"))
		}

		if (doc.getField("category")) {
			publishGlossaryValue("category", doc.getValueGlossary("category"))
		}

		publishValue("din",doc.getValueString("din"))
		//publishGlossaryValue("corr",doc.getValueGlossary("corr"))
		//publishEmployer("recipient",doc.getValueString("recipient"))
		publishEmployer("recipient", doc.getValueList("recipients"))
		//publishGlossaryValue("deliverytype", doc.getValueString("deliverytype").toInteger())
		//publishGlossaryValue("project",doc.getValueGlossary("project"))
		//publishGlossaryValue("category",doc.getValueGlossary("category"))
		publishValue("briefcontent",doc.getValueString("briefcontent"))
		publishValue("ctrldate",doc.getValueString("ctrldate"))
		
		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(_Exception e){

		}
		publishValue("remark",doc.getValueString("remark"))
		publishValue("lang",doc.getValueString("lang"))
		publishValue("np",doc.getValueString("np"))

	}
	
	private Collection<String> getRecipient(_Document doc){
		def recipients = doc.getValueList("recipient");
		return recipients
	}

}