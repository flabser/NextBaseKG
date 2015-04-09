package form.out
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.events._FormPostSave
import kz.nextbase.script.mail._Memo

class PostSave extends _FormPostSave {

    @Override
    public void doPostSave(_Session ses, _Document doc) {
        def recipient = ses.getStructure().getEmployer(doc.getValueString("signedby"));
        def intexecs = doc.getValueList("intexec");
        doc.addReader(doc.getValueString("signedby"));
        def xmppmsg = ""
        def recipientsID = []
        for (String intexec: intexecs) {
            doc.addReader(intexec);
        }
        if( doc.getValueString("mailnotification") == '' ){
            def msngAgent = ses.getInstMessengerAgent();
            def mailAgent = ses.getMailAgent();

            xmppmsg = "Уведомление о новом исходящем документе\n"
            xmppmsg += "Новый исходящий документ: " + doc.getValueString("briefcontent") + "\n"
            xmppmsg += doc.getFullURL() + "\n"
            xmppmsg += "Вы получили данное сообщение как исполнитель"

            def memo = new 	_Memo("Уведомление о новом исходящем документе", "Новый исходящий документ", "Исходящий",doc, true)
            def recipientEmail = recipient.getEmail();
            msngAgent.sendMessage([ses.getStructure().getEmployer(recipient.getUserID()).getInstMessengerAddr()], xmppmsg)
            mailAgent.sendMail([recipientEmail], memo)
            for (String intexec: intexecs) {
                mailAgent.sendMail([ses.getStructure().getEmployer(intexec).getEmail()], memo)
            }
            def userActivity = ses.getUserActivity();
            userActivity.postActivity(this.getClass().getName(),"Memo has been send to " + recipientEmail)
            doc.addStringField("mailnotification", "sent")
            doc.save("[supervisor]")
        }
    }

}