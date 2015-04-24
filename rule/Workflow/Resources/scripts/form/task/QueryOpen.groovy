package form.task
import kz.flabs.webrule.constants.RunMode
import kz.nextbase.script.*
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.constants._DocumentModeType
import kz.nextbase.script.events._FormQueryOpen
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._ExecsBlocks

class QueryOpen extends _FormQueryOpen {

	@Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		publishValue("title",getLocalizedWord("Задание", lang))
		def user = session.getCurrentAppUser()

		def nav = session.getPage("outline", webFormData)
		publishElement(nav)

		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		if(session.getGlobalSettings().edsSettings.isOn == RunMode.ON){
			actionBar.addAction(new _Action(getLocalizedWord("Подписать",lang),getLocalizedWord("Подписать с помощью ЭЦП",lang),_ActionType.EDS_SIGN))
		}
		publishElement(actionBar)

		//def control = new _Control(session, new Date(), false, 10)
		//publishValue("control", control)
		publishValue("status", "new")
		publishEmployer("author",session.getCurrentAppUser().getUserID())
		publishEmployer("taskauthor",session.getCurrentAppUser().getUserID())
		publishValue("taskdate", session.getCurrentDateAsString())
		def pDoc
		def parentDoc
		if (webFormData.containsField("parentdocid") && webFormData.containsField("parentdoctype") && webFormData.getValue("parentdocid") != '0') {
			int pdocid = Integer.parseInt(webFormData.getValueSilently("parentdocid"))
			int pdoctype = Integer.parseInt(webFormData.getValueSilently("parentdoctype"))
			parentDoc = session.getCurrentDatabase().getDocumentByComplexID(pdoctype, pdocid);
			if(parentDoc.getField("parentdocid") && parentDoc.getValueNumber("parentdocid") != 0){
				def gpdoc = parentDoc.getGrandParentDocument()
				gpdoc.session = session;
				publishParentDocs(gpdoc, session, 'new')
				def content =  gpdoc.getValueString("content") ?: gpdoc.getValueString("contentsource") ?: gpdoc.getValueString("remark");
				publishValue("pdoccontent",_Helper.getNormalizedRichText(content))
			}else{
				publishParentDocs(parentDoc, session, 'new');
				def content =  parentDoc.getValueString("content") ?: parentDoc.getValueString("contentsource") ?: parentDoc.getValueString("remark");
				publishValue("pdoccontent",_Helper.getNormalizedRichText(content))
				def parentdoc = doc.getParentDocument();
				try{
					publishDocumentAttachment(parentdoc,"parentrtfcontent","rtfcontent");
				}catch(_Exception e){

				}
			}
		}
		def db = session.getCurrentDatabase();
		def maxdate = 10;
		if(parentDoc  && parentDoc.getDocumentForm() == 'task'){
			def	parentcontrol  = (_Control)parentDoc.getValueObject("control")
			maxdate = parentcontrol.getCtrlDate();
			publishValue("maxdate", _Helper.getDateAsString(maxdate))
		}
		def control = new _Control(session, new Date(), false, maxdate)
		try{
			pDoc = db.getDocumentByComplexID(webFormData.getParentDocID())
			if (parentDoc){
				def link = new _CrossLink(session, pDoc.getURL(), pDoc.getViewText())
				publishValue(link)
			}
		}catch(_Exception e){

		}
		publishValue("control", control)
	}

	def getRespProgress(_Document gdoc, _Session session) {
		String progress = "";
		gdoc.getResponses().each {
			progress += "<entry url='" + it.getFullURL().replace("&", "&amp;") + "'>" +"<viewtext>" +it.getViewText().replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;") +"</viewtext>" +"<responses>" + getRespProgress(it, session) + "</responses>" + "</entry>"
		};
		return progress;
	}
	
	def publishParentDocs(_Document mdoc, _Session session, String status) {
		String progress = getRespProgress(mdoc, session);
		progress = "<entry url='" + mdoc.getFullURL().replace("&", "&amp;") + "'>" +"<viewtext>" +mdoc.getViewText().replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;") +"</viewtext>"+ "<responses>" + progress + "</responses></entry>";
		publishValue(true, "progress", progress);
	}
	 
	@Override
	public void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {

		publishValue("title",getLocalizedWord("Задание", lang) + ": " + doc.getValueString("briefcontent"))
		def user = session.getCurrentAppUser()

		def nav = session.getPage("outline", webFormData)
		publishElement(nav)

		def	control  = (_Control)doc.getValueObject("control")
		def actionBar =  session.createActionBar();

		if(doc.getEditMode() == _DocumentModeType.EDIT && control.getAllControl() != 0){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		
		if(doc.getEditMode() == _DocumentModeType.EDIT && (session.getGlobalSettings().edsSettings.isOn == RunMode.ON) && control.getAllControl() != 0){
			actionBar.addAction(new _Action(getLocalizedWord("Подписать",lang),getLocalizedWord("Подписать с помощью ЭЦП",lang),_ActionType.EDS_SIGN))
		}

		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		if(user.hasRole("supervisor")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}



		def execs  = (_ExecsBlocks)doc.getValueObject("execblock")

		if(execs && execs.hasExecutor(user.getUserID()) && control.getAllControl()  != 0){
			actionBar.addAction(new _Action(getLocalizedWord("Перепоручение",lang),getLocalizedWord("Перепоручение",lang),"compose_task"))
			actionBar.addAction(new _Action(getLocalizedWord("Исполнить",lang),getLocalizedWord("Исполнить",lang),"compose_execution"))
			actionBar.addAction(new _Action(getLocalizedWord("Проект исходящего документа",lang),getLocalizedWord("Проект исходящего документа",lang),"compose_outdocprj"))
			actionBar.addAction(new _Action(getLocalizedWord("Проект внутреннего документа",lang),getLocalizedWord("Проект внутреннего документа",lang),"compose_workdocprj"))
		}

		if (user.hasRole("controller") || user.getUserID() == doc.getValueString("taskauthor")){
			if (control.getAllControl() == 1){
				actionBar.addAction(new _Action(getLocalizedWord("Снять с контроля",lang),getLocalizedWord("Снять с контроля",lang),"reset"))
			}else{
				actionBar.addAction(new _Action(getLocalizedWord("Поставить на контроль",lang),getLocalizedWord("Поставить на контроль",lang),"to_control"))
			}
		}

		publishElement(actionBar)

		try{
			def link  = (_CrossLink)doc.getValueObject("parentdoc")
			publishValue("parentdoc", link)
		}catch(_Exception e){

		}
		

		publishEmployer("taskauthor",doc.getAuthorID())
		publishEmployer("author",doc.getValueString("taskauthor"))
		publishValue("taskvn",doc.getValueString("taskvn"))
		publishValue("taskdate", doc.getValueDate("taskdate"))
		publishValue("tasktype", doc.getValueString("tasktype"))
		publishValue("execblock", execs)
		publishValue("control", control)
		publishGlossaryValue("project",doc.getValueNumber("project"))
		publishGlossaryValue("category",doc.getValueNumber("category"))
		publishGlossaryValue("controltype",doc.getValueNumber("controltype"))
		publishValue("briefcontent",_Helper.getNormalizedRichText(doc.getValueString("briefcontent")))
		publishValue("comment",doc.getValueString("comment"))
		publishValue("content",_Helper.getNormalizedRichText(doc.getValueString("content")))

        publishValue("signedfields", doc.getSign());
        

        def taskauthor = session.getStructure().getEmployer(doc.getAuthorID());
        publishValue("taskauthorpk", taskauthor.getPublicKey());

		try{
			publishAttachment("rtfcontent","rtfcontent")
		}catch(_Exception e){

		}
		if(doc.getField("parentdocid") && doc.getValueNumber("parentdocid") != 0){
			def gpdoc = doc.getGrandParentDocument();
			if(gpdoc){
				gpdoc.session = session;
				publishParentDocs(gpdoc, session, "existing")
				def content =  gpdoc.getValueString("content") ?: gpdoc.getValueString("contentsource") ?: gpdoc.getValueString("remark");
				publishValue("pdoccontent",_Helper.getNormalizedRichText(content))
				def parentdoc = doc.getParentDocument();
				try{
					publishDocumentAttachment(parentdoc,"parentrtfcontent","rtfcontent");
				}catch(_Exception e){

				}
				publishValue("pdoccontent",_Helper.getNormalizedRichText(content))
			}
		}else{
			publishParentDocs(doc, session, "existing")
			def content =  doc.getValueString("content") ?: doc.getValueString("contentsource") ?: doc.getValueString("remark");
			publishValue("pdoccontent",_Helper.getNormalizedRichText(content))
		}
		/*
		 def parentDoc = db.getDocumentByComplexID(webFormData.getParentDocID())
		 if (parentDoc){
		 def link = new _CrossLink(session, parentDoc.getURL(), parentDoc.getViewText())	
		 publishValue(link)
		 }
		 */		
	}

}