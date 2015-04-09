package form.l

import java.util.Map
import kz.nextbase.script.*
import kz.nextbase.script.events.*;
import kz.nextbase.script.mail._Memo

class PostSave extends _FormPostSave {

    @Override
    public void doPostSave(_Session ses, _Document doc) {
        def xmppmsg = ""
        def msngAgent = ses.getInstMessengerAgent()

        xmppmsg = "Уведомление о документе на рассмотрение \n"
        xmppmsg += "Новое обращение граждан: " + doc.getValueString("briefcontent") + "\n"
        xmppmsg += doc.getFullURL() + "\n"
        xmppmsg += "Вы получили данное сообщение как получатель"

        def mailAgent = ses.getMailAgent();
        def memo = new _Memo("Уведомление о документе на рассмотрение", "Новое обращение от граждан", "Обращение граждан", doc, true)
        def recipient = ses.getStructure().getEmployer(doc.getValueString("recipient"))
        def recipientEmail = recipient.getEmail();
        msngAgent.sendMessage([recipient.getInstMessengerAddr()],xmppmsg)
        mailAgent.sendMail([recipientEmail], memo)
        def userActivity = ses.getUserActivity();
        userActivity.postActivity(this.getClass().getName(), "Memo has been send to " + recipientEmail)
    }
}