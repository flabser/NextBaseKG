package form.execreport

import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionBar
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session ses, _WebFormData webFormData, String lang) {

		def actionBar = new _ActionBar(ses)
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)

		def user = ses.getCurrentAppUser()
		def dep = user.getDepartmentID()
		if (dep) {
			publishDepartment("department", dep)
		}
		publishValue("title",getLocalizedWord("Исполнение", lang))
		publishEmployer("author", ses.getCurrentAppUser().getUserID())
		publishEmployer("executor",ses.getCurrentAppUser().getUserID())
		publishValue("finishdate", ses.getCurrentDateAsString())
	}


	@Override
	public void doQueryOpen(_Session ses, _Document exec, _WebFormData webFormData, String lang) {
		def user = ses.getCurrentAppUser()

		def pdoc = exec.getParentDocument()
		def pauthor  = pdoc.getValueString('author')
		publishValue("parentdocid",exec.getDocID().toString())
		publishValue("parentdoctype",exec.getDocType().toString())
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)
		def actionBar = new _ActionBar(ses)
		if (user.getUserID() == exec.getAuthorID() ){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		if(user.getUserID() == pauthor){
			actionBar.addAction(new _Action(getLocalizedWord("Новое задание", lang),getLocalizedWord("Новое задание", lang), "NEW_DOCUMENT"))
		}
		if(user.hasRole("supervisor")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
		publishValue("title",getLocalizedWord("Исполнение", lang) + ":" + exec.getValueString("briefcontent"))
		publishEmployer("author",exec.getAuthorID())
		publishEmployer("executor",exec.getValueString("executor"))
		publishValue("finishdate", _Helper.getDateAsString(exec.getValueDate("finishdate")))
		publishValue("report", exec.getValueString("report"))

     	publishGlossaryValue("nomentype", exec.getValueNumber("nomentype"))
		
		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(_Exception e){
			e.printStackTrace()
		}
	}	
		

}