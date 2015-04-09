package form.task
import kz.nextbase.script.*
import kz.nextbase.script.constants._AllControlType
import kz.nextbase.script.events._FormQuerySave
import kz.nextbase.script.task._Control
import kz.nextbase.script.task._ExecsBlocks

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {

		println(webFormData)

		boolean v = validate(webFormData);
		if(v == false){
			stopSave()
			return;
		}

		doc.setForm("task")
		doc.addStringField("taskauthor", webFormData.getValueSilently("taskauthor"))
		doc.addStringField("comment", webFormData.getValue("comment"))
		doc.addStringField("briefcontent", webFormData.getValue("briefcontent"))
        doc.setRichText("content", webFormData.getValue("content"));
		doc.addNumberField("controltype", webFormData.getNumberValueSilently("controltype",-1))
		doc.addNumberField("project", webFormData.getNumberValueSilently("project",-1))
		doc.addNumberField("category", webFormData.getNumberValueSilently("category",-1))
		doc.addFile("rtfcontent", webFormData)
		doc.addFile("eds_cert", webFormData);

		def pdoc = doc.getParentDocument()
		if (pdoc){
			if (pdoc.getDocumentForm() == "task"){
				doc.addStringField("tasktype", "consign")
			}else{
				doc.addStringField("tasktype", "resolution")
			}
            doc.addNumberField("parentdocid", pdoc.getDocID())
            doc.addNumberField("parentdoctype", pdoc.docType)
			def link = new _CrossLink(session, pdoc.getURL(), pdoc.getViewText())
			doc.addField("parentdoc", link)
		}else{
			doc.addStringField("tasktype", "task")
		}

		def execs = new _ExecsBlocks(session)
		for(int i = 0; i < webFormData.getSizeOfField("executor"); i++ ){
			execs.addExecutor(webFormData.getListOfValues("executor")[i])
		}
        for(int i = 0; i < webFormData.getSizeOfField("extexecutor"); i++ ){
            execs.addExecutor(webFormData.getListOfValues("extexecutor")[i])
        }
		def returnURL = session.getURLOfLastPage()
		def control
		if (doc.isNewDoc){
			returnURL.changeParameter("page", "0")
			String pcd = webFormData.getValue("primaryctrldate")
			if(pcd != ""){
				control = new _Control(session, new Date(), false, _Helper.convertStringToDate(pcd))
			}else{
				control = new _Control(session)
			}
		}else{
			control  = (_Control)doc.getValueObject("control")
		}

		control.setCycle(webFormData.getNumberValueSilently("cyclecontrol",1))

		
		def struct = session.getStructure();
		def u = struct.getEmployer(doc.getValueString("taskauthor"));
		String sh = u.getShortName();

		doc.addEditor(doc.getValueString("taskauthor"))

		String rusExecName = ""
		execs.getExecutors().each{
			rusExecName += it.getShortName() + ","
		}

		if (execs.getResetedExecutorsCount() >= execs.getExecutorsCount()){
			control.setAllControl(_AllControlType.RESET);
			def descendants = doc.getDescendants();
			descendants.each{
				def relatedDoc = (_Document)it
				if(relatedDoc.getDocumentForm() == "task"){
					def	c  = (_Control)relatedDoc.getValueObject("control")
					c.setAllControl(_AllControlType.RESET);
					relatedDoc.save("[supervisor]");
				}
			}
		}

		doc.addField("control", control)
		doc.addField("execblock", execs)

		if (rusExecName){
			rusExecName = rusExecName.substring(0, rusExecName.length()-1);
		}

		String rview = "";
		if (doc.getValueString("tasktype") == "resolution" || doc.getValueString("tasktype") == "consign"){
			doc.addStringField("taskvn", "")
			doc.addDateField("taskdate", new Date())
		} else {
			if (!doc.getValueString("taskvn").trim()) {
				def db = session.getCurrentDatabase();
                int num = db.getRegNumber("task_" + webFormData.getValueSilently("project"))
				String vnAsText = Integer.toString(num);
				doc.addStringField("taskvn", vnAsText)
				doc.addDateField("taskdate", new Date())
			}
		}

		doc.setViewText(_Helper.getDateAsStringShort(doc.getValueDate("taskdate")) + ":" +  sh + "  (" +  rusExecName + "),  " + doc.getValueString("briefcontent") + ", " + _Helper.getDateAsStringShort(control.getCtrlDate())) //0
		doc.addViewText(doc.getValueString("briefcontent"))//1
		doc.addViewText(doc.getGlossaryValue("docscat", "docid#number=" + doc.getValueString("category"), "name"))//2
		doc.addViewText(control.getAllControl())//3
		doc.addViewText(execs.getExecutorsAsText())//4
		doc.setViewNumber(control.getDiffBetweenDays())//5
		doc.setViewDate(doc.getValueDate("taskdate"))
        doc.setSign(webFormData.getValueSilently("signedfields"));
		setRedirectURL(returnURL)
	}



	def validate(_WebFormData webFormData){

		if (webFormData.getSizeOfField("executor") == 0){
			localizedMsgBox("Не выбраны исполнители задания")
			return false
		}else if (webFormData.getValueSilently("project") == ""){
			localizedMsgBox("Поле \"Связан с проектом\" не указано")
			return false
		}else if (webFormData.getValueSilently("category") == ""){
			localizedMsgBox("Поле \"Категория\" не указано")
			return false
		}else if (webFormData.getValueSilently("briefcontent") == ""){
			localizedMsgBox("Поле \"Краткое содержание\" не заполнено")
			return false
		}else if (webFormData.getValueSilently("primaryctrldate") == ""){
			localizedMsgBox("Поле \"Срок исполнения\" не заполнено")
			return false
		}else if (!_Validator.checkDate(webFormData.getValueSilently("primaryctrldate"))){
			localizedMsgBox("Поле \"Срок исполнения\" заполнено неверно")
			return false
		}else if (webFormData.getValueSilently("controltype") == ""){
			localizedMsgBox("Поле \"Тип контроля\" не заполнено")
			return false
		}else if (webFormData.getValueSilently('briefcontent').length() > 2046){
			localizedMsgBox('Поле \'Краткое содержание\' содержит значение превышающее 2046 символов');
			return false;
		}else if (webFormData.getValueSilently('comment').length() > 2046){
			localizedMsgBox('Поле \'Примечание\' содержит значение превышающее 2046 символов');
			return false;
		}
        if (webFormData.getValueSilently("project") == "" || !webFormData.containsField("project")){
            localizedMsgBox("Поле \"Связан с проектом\" не выбрано.")
            return false
        }
		return true;
	}

}
