package form.l

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.constants.*

class QueryOpen extends _FormQueryOpen {

	
	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		
		def user = session.getCurrentAppUser()
		
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)

		
		publishValue("title",getLocalizedWord("Обращение граждан", lang))
		publishEmployer("author", session.getCurrentAppUser().getUserID())
		publishValue("dvn", session.getCurrentDateAsString())
		publishValue("ctrldate", session.getCurrentDateAsString(30))
	
	}


	@Override
	public void doQueryOpen(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
		def user = ses.getCurrentAppUser()
		
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = new _ActionBar(ses)
		
		if(doc.getValueString("recipient") == user.getUserID()){
			actionBar.addAction(new _Action(getLocalizedWord("Перепоручение",lang),getLocalizedWord("Перепоручение",lang),"compose_task"))
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
		
		publishValue("title",getLocalizedWord("Обращение от", lang) + " " + doc.getValueString("fio"))
		publishEmployer("author",doc.getAuthorID())
		publishValue("vn",doc.getValueString("vn"))
		publishValue("dvn",doc.getValueString("dvn"))
		publishValue("fio",doc.getValueString("fio"))
		publishValue("address",doc.getValueString("address"))
		publishEmployer("recipient",doc.getValueString("recipient"))
	//	publishValue("doctype",doc.getValueGlossary("doctype"))
		publishValue("lang",doc.getValueString("lang"))
		publishGlossaryValue("har", doc.getValueString("har").toInteger())
		publishValue("resultview",doc.getValueString("resultview"))
		publishGlossaryValue("regionview",doc.getValueString("regionview").toInteger())
		publishGlossaryValue("vid",doc.getValueString("vid").toInteger())
		publishValue("ctrldate",doc.getValueString("ctrldate"))
		publishValue("briefcontent",doc.getValueString("briefcontent"))
		publishValue("remark",doc.getValueString("remark"))
		publishValue("phone",doc.getValueString("phone"))
		publishValue("private",doc.getValueString("private"))
		publishValue("otype",doc.getValueString("otype"))
		publishValue("np",doc.getValueString("np"))
		publishValue("np2",doc.getValueString("np2"))
		
		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(_Exception e){

		}		
	}

}