package form.out

import kz.nextbase.script.*
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
		
		publishValue("title",getLocalizedWord("Исходящий документ", lang))
		publishEmployer("author", ses.getCurrentAppUser().getUserID())
		publishValue("dvn", ses.getCurrentDateAsString())	
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
		
		if(doc.getEditMode() == _DocumentModeType.EDIT && user.hasRole("registrator_outgoing")){
			if(doc.getValueString("vn") != ''){
				actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
			}else{
				actionBar.addAction(new _Action(getLocalizedWord("Зарегистрировать документ",lang),getLocalizedWord("Зарегистрировать документ",lang),_ActionType.SAVE_AND_CLOSE))
			}
		}
		if(user.hasRole("supervisor")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
		publishValue("title",getLocalizedWord("Исходящий документ", lang) + " ")
		publishEmployer("author",doc.authorID)
		publishValue("vn",doc.getValueString("vn"))
		publishValue("dvn",doc.getValueString("dvn"))
		publishGlossaryValue("vid",doc.getValueGlossary("vid"))
        doc.getValueList("corr").each {println Integer.parseInt(it)}
		publishGlossaryValue("corr", doc.getValueList("corr").collect {Integer.parseInt(it)})

		publishEmployer("signedby",doc.getValueString("signedby"))
		publishGlossaryValue("deliverytype",doc.getValueGlossary("deliverytype"))
		publishGlossaryValue("project",doc.getValueGlossary("project"))
		publishGlossaryValue("category",doc.getValueGlossary("category"))	
		publishValue("briefcontent",doc.getValueString("briefcontent"))
		publishValue("contentsource",doc.getValueString("contentsource"))
		publishValue("ctrldate",doc.getValueString("ctrldate"))
		publishValue("vnish",doc.getValueString("vnish"))
		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(_Exception e){

		}
		publishValue("remark",doc.getValueString("remark"))
		publishValue("lang",doc.getValueString("lang"))
		publishValue("np",doc.getValueString("np"))
		publishValue("np2",doc.getValueString("np2"))
		publishValue("blanknumber",doc.getValueString("blanknumber"))
		publishValue("backvnin",doc.getValueString("backvnin"))
		publishGlossaryValue("nomentype",doc.getValueNumber("nomentype"))
		try{
			def link  = (_CrossLink)doc.getValueObject("link")
			publishValue("link", link)
		}catch(_Exception e){
		
		}
	}
	
}