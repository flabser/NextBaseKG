package form.task

import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.constants._TaskType
import kz.nextbase.script.events._FormPostSave
import kz.nextbase.script.mail._Memo
import kz.nextbase.script.task._ExecsBlocks
import kz.nextbase.script.task._Task
import kz.nextbase.script.task._Control

class PostSave extends _FormPostSave {

	public void doPostSave(_Session ses, _Document doc) {	
	   def recipientsMail = []
	   def recipientsID = []
	   def	control  = (_Control)doc.getValueObject("control")
	   
	   def execs  = (_ExecsBlocks)doc.getValueObject("execblock")
	   def e = execs.getExecutors()
	   e.each{
		   def recipient = ses.getStructure().getEmployer(it.getUserID())
		   recipientsMail.add(recipient?.getEmail())
		   recipientsID.add(recipient?.getInstMessengerAddr())
		   doc.addReader(it.getUserID())
	   }
	   doc.save("[supervisor]")
	   def taskReaders = doc.getReaders()
	   if(doc.getField("parentdocid") && doc.getValueNumber("parentdocid") != 0){
		  def mdoc = doc.getGrandParentDocument()
		  taskReaders.each{ exec ->
			  mdoc.addReader(exec)
		  }
		  mdoc.save("[supervisor]")
		  mdoc.getReaders().each{ exec ->
			  doc.addReader(exec)
		  }
		  def readersList = mdoc.getReaders()
		  def rescol = mdoc.getDescendants()
		  rescol.each{ response ->
			  taskReaders.each{ reader ->
				  response.addReader(reader.getUserID())
			  }
			  response.getReaders().each{ reader ->
				  doc.addReader(reader.getUserID())
			  }
			  response.save("[supervisor]")
		  }
	  }
	   def mailAgent = ses.getMailAgent()
	   String xmppmsg ="";
	   if(control.allControl == 0){
		   xmppmsg = "Уведомление о снятии документа с контроля \n"
		   xmppmsg += "Задание: " + doc.getValueString("briefcontent") + "  снято с контроля \n"
		   xmppmsg += doc.getFullURL() + "\n"
		   xmppmsg += "Вы получили данное сообщение как исполнитель"
		   def memo = new _Memo("Уведомление о снятии документа с контроля", "Задание снято с контроля", "Задание",doc, true)
		   mailAgent.sendMailAfter(recipientsMail, memo)
	   }else{
		   xmppmsg = "Уведомление о документе на исполнение \n"
		   xmppmsg += "Новое задание: " + doc.getValueString("briefcontent") + "  \n"
		   xmppmsg += doc.getFullURL() + "\n"
		   xmppmsg += "Вы получили данное сообщение как исполнитель"
		   def memo = new _Memo("Уведомление о документе на исполнение", "Новое задание", "Задание",doc, true)
		   mailAgent.sendMailAfter(recipientsMail, memo)
	   }
	   def userActivity = ses.getUserActivity();
	   def  msngAgent1 = ses.getInstMessengerAgent()
	   msngAgent1.sendMessageAfter(recipientsID, ses.currentDatabase.getGlossaryCustomFieldValueByDOCID(doc.getValueInt("project"), "name") + ": " + xmppmsg)
	   userActivity.postActivity(this.getClass().getName(),"Memo has been send to " + recipientsMail)
	}
}