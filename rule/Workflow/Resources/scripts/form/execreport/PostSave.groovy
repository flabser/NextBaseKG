package form.execreport
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.constants._DocumentType
import kz.nextbase.script.events._FormPostSave
import kz.nextbase.script.mail._Memo
import kz.nextbase.script.task._Task

class PostSave extends _FormPostSave {

    public void doPostSave(_Session ses, _Document exec) {
        def executionReaders = exec.getReaders()
        def mdoc = exec.getGrandParentDocument()
        mdoc.addReader((HashSet<String>) executionReaders.collect { it.userID })


        executionReaders.each{
            mdoc.addReader(it.getUserID());
        }

        mdoc.save("[supervisor]")
        def readersList = mdoc.getReaders();
        def rescol = mdoc.getDescendants();
        mdoc.setSession(ses);
        rescol.each{ response ->
            readersList.each{ reader ->
                response.addReader(reader.getUserID());
            }
            response.save("[supervisor]");
        }

        String xmppmsg = ""
        def pdoc = exec.getParentDocument();
		exec.addReader(pdoc.getAuthorID())
		exec.save("[supervisor]");
        if (pdoc) {
            if (pdoc.getDocumentType() == _DocumentType.TASK) {
                def task = (_Task) pdoc;
                def execs = task.getExecutorsList();
                for (def e : execs) {
                    if (e.getUserID() == exec.getValueString("author") && e.getResponsible() != 1) {
                        e.setResetDate(new Date());
                        e.setResetAuthorID("auto");
                        task.save("[supervisor]");
                        break;
                    }
                }
            }
        }

        if (exec.getAuthorID() != pdoc.getAuthorID()) {
            println("Уведомление отправлено")
            def msngAgent1 = ses.getInstMessengerAgent()
            def mailAgent = ses.getMailAgent();
            println(pdoc.getAuthorID())

            xmppmsg = "Уведомление о Исполнении задания \n"
            xmppmsg += "Документ снят с контроля" + "\n"
            xmppmsg += exec.getFullURL() + "\n"
            xmppmsg += "Вы получили данное сообщение как автор"

            def memo = new _Memo("Уведомление о исполнении задания", "Исполнение", "Исполнение", exec, true)
            def recipient = ses.getStructure().getEmployer(pdoc.getAuthorID())
            def recipientEmail = recipient.getEmail();
            msngAgent1.sendMessage([recipient.getInstMessengerAddr()], exec.getGrandParentDocument().getValueString("project_name") + ": " + xmppmsg)
            mailAgent.sendMail([recipientEmail], memo)
            def userActivity = ses.getUserActivity();
            userActivity.postActivity(this.getClass().getName(), "Memo has been send to " + recipientEmail)
        }
    }
}