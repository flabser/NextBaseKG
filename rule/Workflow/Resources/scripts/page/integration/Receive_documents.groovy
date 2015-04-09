package page.integration

import kz.nextbase.script._Document
import kz.nextbase.script._Helper
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

import javax.mail.*

class Receive_documents extends _DoScript{
    @Override
    void doProcess(_Session ses, _WebFormData formData, String lang) {
        def trust_email = "4msworkflow@inbox.ru"
        def password = "kf,jhfnjhbz,eleotuj"
        def server = "imap.mail.ru"
        def port = 993
        def props = new Properties()
        props.setProperty("mail.host", server)
        props.setProperty("mail.debug", String.valueOf(true))
        props.setProperty("mail.imap.port", port.toString())
        props.setProperty("mail.imap.ssl.enable", String.valueOf(true))


        def session = Session.getInstance(props)// .getDefaultInstance(props)
        def store = session.getStore("imap")
        store.connect(trust_email, password)
        println "connected to mail ru"

        def folder = store.getFolder("Integration")
        folder.open(Folder.READ_ONLY)
        folder.messages.each { msg ->
            def save = false
            try {
                def content = msg.content
                if (content instanceof Multipart) {
                    def doc = new _Document(ses.getCurrentDatabase());
                    for (i in 0..(content.count - 1)) {
                        BodyPart bodyPart = content.getBodyPart(i)
                        if (Part.ATTACHMENT.equalsIgnoreCase(bodyPart.disposition)) {
                            InputStream is = bodyPart.getInputStream();
                            if ("document.xml".equalsIgnoreCase(bodyPart.getFileName())) {

                                def someXmlRecords = new XmlParser().parse(is);
                                println someXmlRecords.get("Subject")

                                doc.setForm("in");
                                doc.setValueString("in", someXmlRecords.DocumentNumber.text())
                                doc.setValueString("vn", "")
                                doc.setValueNumber("vnnumber", 0)
                                doc.setValueString("briefcontent", someXmlRecords.Subject.text())
                                doc.setValueString("np", someXmlRecords.SheetCount.text())
                                doc.setViewText(someXmlRecords.Subject.text())
                                doc.addViewText(someXmlRecords.Subject.text())

                                //String execFIO = someXmlRecords.ExecutorFIO.text();
                                String deltypeXML = someXmlRecords.FormSentDictionaryId?.text();
                                def deltypeglos = ses.getCurrentDatabase().getCollectionOfGlossaries("form = 'deliverytype' and viewtext ~ '${deltypeXML}'", 1, 1)
                                if (deltypeglos && deltypeglos.count > 0) {
                                    deltypeglos.entries.each {
                                        doc.addGlossaryField("deliverytype", it.document.getDocID())
                                    }
                                }

                                String doctypeXML = someXmlRecords.DocumentTypeId?.text()
                                def doctype = ses.getCurrentDatabase().getCollectionOfGlossaries("form = 'vid' and viewtext ~ '${doctypeXML}'", 1, 1)
                                if (doctype && doctype.count > 0 ) {
                                    doctype.entries.each {
                                        doc.addGlossaryField("vid", it.document.getDocID())
                                    }
                                }

                                def corr = ses.getCurrentDatabase().getGlossaryDocument("form = 'corr'", "viewtext ~ 'общество'")
                                if (corr) {
                                    doc.addGlossaryField("corr", corr.getDocID())
                                }

                                def project = ses.getCurrentDatabase().getGlossaryDocument("form = 'project'", "viewtext ~ 'Вне проекта'")
                                if (project) {
                                    doc.addGlossaryField("project", project.getDocID())
                                }

                                def category = ses.getCurrentDatabase().getGlossaryDocument("form = 'category'", "viewtext ~ 'Общие вопросы'")
                                if (category) {
                                    doc.addGlossaryField("category", category.getDocID())
                                }

                                String din = someXmlRecords.Date.text()
                                doc.setValueDate("din", _Helper.convertStringToDate(din.replace("T", " ")))
                                doc.setViewDate(new Date())
                                String execFIO = someXmlRecords.ExecutorFIO.text();
                                String[] abb = execFIO.split(" ")
                                def exec = ses.getStructure().getUserByCondition("fullname like '%" + abb.max{it.length()} + "%'")
                                if (exec) {
                                    doc.addValueToList("recipient", exec.getUserID());
                                }
                                save = true
                            } else {
                                File f = new File(bodyPart.getFileName());
                                FileOutputStream fos = new FileOutputStream(f);
                                byte[] buf = new byte[4096];
                                int bytesRead;
                                while((bytesRead = is.read(buf))!=-1) {
                                    fos.write(buf, 0, bytesRead);
                                }
                                fos.close();
                                doc.addAttachment("rtfcontent",f)
                            }
                        }
                    }
                    if (save) {
                        doc.setAuthor("wish")
                        doc.addEditor("wish")
                        doc.addEditor("[wish]")
                        doc.addEditor("[supervisor]")
                        doc.addEditor("supervisor")
                        doc.addReader("[wish]")
                        doc.addReader("wish")
                        doc.addReader("observer")
                        doc.addReader("[observer]")
                        doc.save("[supervisor]")
                    }
                }

            } catch (Exception ignore) {
                ignore.printStackTrace()
                println "error processing message, no big deal, moving on"
            }
            println "-----------done------------"
        }

    }
}
