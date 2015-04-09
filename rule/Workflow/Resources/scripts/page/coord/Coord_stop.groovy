package page.coord

import kz.nextbase.script._CrossLink
import kz.nextbase.script._Document
import kz.nextbase.script._Helper
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.constants._BlockStatusType
import kz.nextbase.script.constants._CoordStatusType
import kz.nextbase.script.coordination._Block
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.coordination._Coordinator
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.mail._Memo

class Coord_stop extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {

		def cdb = session.getCurrentDatabase()
		def mailAgent = session.getMailAgent()
		def msngAgent = session.getInstMessengerAgent()
		def recipientsMail = []
		def recipientsID = []
		String msubject = ""
		String body = ""
		String msg = ""
		def doc = cdb.getDocumentByID(formData.getNumberValueSilently("key",-1))
		def struct = session.getStructure()
		def author = struct?.getEmployer(doc.getAuthorID())
		//def block = prj.getCurrentBlock();
		def	blocksCollection  = (_BlockCollection)doc.getValueObject("coordination")
		def block = (_Block)blocksCollection.getCurrentBlock()
		def coordlist = block.getCurrentCoordinators()
		boolean finalblock = false
		def doc_blc = (_BlockCollection)doc.getValueObject("coordination")
		def rejectProject = { boolean new_version, _Document document->
			doc_blc.setCoordStatus(_CoordStatusType.REJECTED);
			document.replaceViewText(blocksCollection.getStatus().name(), 3)
			document.setLastUpdate(new Date());
			document.setValueString("oldversion", "1")
			document.setValueNumber("isrejected",1)
			document.save("[supervisor]")
			String vtext_old = document.getViewText()
			String url_old = document.getURL()
			String ddbid_old = document.getID()
			/*Формирование новой версии проекта*/
			if(new_version) {
                document.setNewDoc();
                document.setValueNumber("isrejected", 0)
                doc_blc.setCoordStatus(_CoordStatusType.NEWVERSION)

                int docversion = document.getValueNumber("docversion") + 1
                document.setValueNumber("docversion", docversion)
                String vn = document.getValueString("vn")
                document.setValueString("vn", vn.contains(",") ? vn.replaceFirst(",.", ",") + docversion.toString() : vn + "," + docversion.toString())
                document.setValueDate("projectdate", new Date())
                document.replaceViewText(' № ' + document.getValueString("vn") + ' ' + _Helper.getDateAsStringShort(document.getValueDate("projectdate")) + ' ' + session.getStructure().getEmployer(document.getAuthorID()).shortName + ' ' + document.getValueString('briefcontent'), 0)
                def link_old = new _CrossLink(session, url_old, vtext_old)
                document.addField("versionlink", link_old)
                document.save("[supervisor]");

                document.clearEditors()
                document.clearReaders()
                document.addEditor(document.getAuthorID())
                def blocks = doc_blc.getBlocks()
                blocks.each{
                    it.setBlockStatus(_BlockStatusType.AWAITING)
                    it.getCoordinators()*.resetCoordinator()
                }
                document.replaceViewText(doc_blc.getStatus().name(), 3)
                document.save("[supervisor]")
                def doc_old = cdb.getDocumentByID(ddbid_old)
                def link_new = new _CrossLink(session, document)
                doc_old.addField("versionlink", link_new)
                doc_old.save("[supervisor]")

                sendNewDocNotification(session, doc_blc, document);
            }

		}
        boolean new_version = Boolean.parseBoolean(formData.getValue("newversion"));
        rejectProject(new_version, doc);
		def cBlock = blocksCollection.getCurrentBlock()
		if (cBlock)	{
			doc.replaceViewText(cBlock.getCurrentCoordinatorsAsText(), 5)
		}
		doc.replaceViewText(doc_blc.getStatus().name(), 3)

    	doc.setLastUpdate(new Date())
		doc.save("[supervisor]")
		def returnURL = session.getURLOfLastPage()
		setRedirectURL(returnURL)

	}

    def sendNewDocNotification(_Session session, def doc_blc, def doc){
        String msg ="", msubject = "", body = "";
        def mailAgent = session.getMailAgent()
        def msngAgent = session.getInstMessengerAgent()
        def recipientsMail = []
        def recipientsID = []
        def struct = session.getStructure()
        def author = struct?.getEmployer(doc.getAuthorID());

        def signerCoord = (_Coordinator)doc_blc.getCurrentBlock()?.getFirstCoordinator();
        msg = "Отклонен документ: \"" + doc.getValueString("briefcontent");
        msg += "\nСоздана новая версия, для работы с документом перейдите по ссылке " + doc.getFullURL();
        msngAgent.sendMessageAfter([author?.getInstMessengerAddr()], msg);

        msubject = '[СЭД] [Проекты] Отклонен документ: \"' + doc.getValueString("briefcontent");
        body = '<table cellspacing="0" cellpadding="4" border="0" style="padding:10px; font-size:12px; font-family:Arial;">';
        body += '<tr>';
        body += '<td style="border-bottom:1px solid #CCC;" valign="top" colspan="2">';
        body += 'Документ: \"' +  doc.getValueString("briefcontent") + '\" был отклонен. <br>';
        body += '</td></tr><tr>';
        body += '<td colspan="2"></td>';
        body += '</tr></table>';
        body += '<p><font size="2" face="Arial">Создана новая версия, для работы с документом перейдите по <a href="' + doc.getFullURL() + '">ссылке...</a></p></font>';

        mailAgent.sendMailAfter([author?.getEmail()], new _Memo(msubject, 'Документ отклонен', body, doc, false));
    }
}