package structure.form.department

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.struct.*
import kz.nextbase.script.actions.*
import kz.nextbase.script.constants.*;

class QueryOpen extends _FormQueryOpen {


	@Override
	public void doQueryOpen(_Session ses, _WebFormData webFormData, String lang) {
		def db = ses.getCurrentDatabase()
		def pdoc = db.getDocumentByComplexID(webFormData.getValue("parentdoctype"),webFormData.getValue("parentdocid"))
		if (pdoc != null){
			if (pdoc.getDocumentType() == _DocumentType.ORGANIZATION){
				publishValue("organization", pdoc.getViewText())
			}else{
				publishValue("parent", pdoc.getViewText())
				def org = pdoc.getGrandParentDocument()
				publishValue("organization", org.getViewText())
			}			
		}
		
		def user = ses.getCurrentAppUser()
		def actionBar = ses.createActionBar();

        if (user.hasRole(["struct_keeper", "supervisor"])){
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
        }

        actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
        publishElement(actionBar)
	}

	@Override
	public void doQueryOpen(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
		def dep  = (_Department)doc;
		publishValue("title",getLocalizedWord("Подразделение", lang) + " " + dep.getFullName())
		publishValue("fullname", dep.getFullName())
		publishValue("shortname", dep.getShortName())
		def subKey = (dep.getParentDocument()?.docType + "~" + dep.getParentDocument()?.getDocID())?:""
		publishValue("parentsubkey", subKey)
		publishValue("comment", dep.getComment())
		publishValue("rank", dep.getRank())
		publishValue("index", dep.getIndex())		
		publishValue("bin", dep.getValueString("bin"))		
		publishGlossaryValue("subdivision", dep.getType())
		def pdoc = doc.getParentDocument();
		if (pdoc != null){
			publishValue("organization", pdoc.getViewText())
		}
		def user = ses.getCurrentAppUser()
		def actionBar = ses.createActionBar();
		
		if (user.hasRole(["struct_keeper", "supervisor"])){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
			actionBar.addAction(new _Action("Новый сотрудник","Новый сотрудник", "NEW_EMPLOYER"))
			actionBar.addAction(new _Action("Новый департамент","Новый департамент", "NEW_DEPARTMENT"))
		}
		
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
	}
}