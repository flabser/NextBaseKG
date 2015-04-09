package form.in
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.events._FormPostSave
import kz.nextbase.script.mail._Memo

class PostSave extends _FormPostSave {

    @Override
    public void doPostSave(_Session ses, _Document doc) {
        //def recipient = ses.getStructure().getEmployer(doc.getValueString("recipient"))
        def recipients = doc.getValueList("recipient");
        def xmppmsg = ""
        def recipientsID = []
        doc.addReader(doc.getValueString("recipient"));
        if (doc.getValueString("mailnotification") == '') {

            def mailAgent = ses.getMailAgent();
            def msngAgent = ses.getInstMessengerAgent()

            xmppmsg = "Уведомление о документе на рассмотрение  \n"
            xmppmsg += "Входящий документ: " + doc.getValueString("briefcontent") + "\n"
            xmppmsg += doc.getFullURL() + "\n"
            xmppmsg += "Вы получили данное сообщение как получатель"

            def memo = new _Memo("Уведомление о документе на рассмотрение", "Новый входящий документ", "Входящий", doc, true)
            for (String recipient : recipients) {
                def rec = ses.getStructure().getEmployer(recipient)
                def recipientEmail = ses.getStructure().getEmployer(recipient).getEmail()

                msngAgent.sendMessage([rec.getInstMessengerAddr()], xmppmsg)
                mailAgent.sendMail([recipientEmail], memo)
                def userActivity = ses.getUserActivity();
                userActivity.postActivity(this.getClass().getName(), "Memo has been send to " + recipientEmail)
            }
            doc.addStringField("mailnotification", "sent")
            doc.save("[supervisor]")
        }
    }
}