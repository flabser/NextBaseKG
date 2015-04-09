package handler.reminder_task

import kz.nextbase.script.mail._Memo
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScheduledHandler
import kz.nextbase.script.struct._Employer
import kz.nextbase.script.task._ExecsBlocks
import kz.nextbase.script.task._Executor
import kz.nextbase.script.task._Task

class Trigger extends _DoScheduledHandler {

    @Override
    public int doHandler(_Session session) {

        String body = ""
        def memo
        def recipient = []
        def mAgent = session.getMailAgent()
        def db = session.getCurrentDatabase()
        def structure = session.getStructure()
        def allEmps = structure.getAllEmployers()
        Calendar calendar = Calendar.getInstance()
		
		def formula = "form='task' and viewtext3 = '1'"
		def col = db.getCollectionOfDocuments(formula, false)
		

        if ((calendar.get(Calendar.DAY_OF_WEEK_IN_MONTH) != 6) || (calendar.get(Calendar.DAY_OF_WEEK_IN_MONTH) != 7)) {
            for (def emp:allEmps){
                int in1 = 0
                int in2 = 1
                def needSend = false
                body = "Задания"
                body += "<TABLE style='border-collapse:collapse; margin:1px auto' height = 30px cellpadding = 10px>"
				def entries = col.getEntries() 
				entries.each { _ViewEntry viewEntry ->
                    def doc = viewEntry.getDocument()
					def execs  = (_ExecsBlocks)doc.getValueObject("execblock")
                    def executors = execs.getExecutors().toArray()
                    executors.each { _Executor exec ->
                        if (emp.getUserID().equals(exec.getUserID())) {
                            (in1 == 0 ? (body += "<TR>" + "<td style = 'background-color: #F8F8FF; border:1px solid #cdcdcd' width= 20px padding: 10px>" + "<b>" + "№" + "</b>" + "</TD>" + "<TD style =  'background-color: #F8F8FF; border:1px solid #cdcdcd' width= 800px>" + "<b>" + "Содержание" + "</b>" + "</TD>" + "</TR>") : "")
                            body += "<TR>" + "<td style = 'background-color: #F8F8FF; border:1px solid #cdcdcd' width= 20px padding: 10px>" + in2 + "</TD>" + "<TD style = 'background-color: #F8F8FF; border:1px solid #cdcdcd' width= 800px>" + "<a href=\"" + " " + doc.getFullURL() + "\">" + "  " + doc.getViewText() + "</TD>" + "</TR>" + "</a>"
                            needSend = true
                            in1 = null;
                            in2++;
                        }
                    }
                }
                body += "</TABLE>"
                recipient.clear()
                if (needSend) {
                    recipient.add(emp.getEmail())
                    memo = new _Memo("Уведомление о невыполненных заданиях", "<b>" + "У вас есть невыполненные задания" + "</b>", body, null, true)
                    mAgent.sendMail(recipient, memo)
                }
            }
        }
        return 0;
    }
}
