package page.coord

import kz.nextbase.script.*
import kz.nextbase.script.constants.*
import kz.nextbase.script.coordination._Block
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.coordination._Coordinator
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.mail._Memo

class Sign_no extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {

		def cdb = session.getCurrentDatabase()
		def doc = cdb.getDocumentByID(formData.getNumberValueSilently("key",-1))
		def mailAgent = session.getMailAgent()
		def msngAgent = session.getInstMessengerAgent()
		String msubject = ""
		String body = ""
		String msg = ""
		def struct = session.getStructure()
		def author = struct?.getEmployer(doc.getAuthorID())
        def	blocksCollection  = (_BlockCollection)doc.getValueObject("coordination")
        def block = (_Block)blocksCollection.getSignBlock()
        def doc_blc = (_BlockCollection)doc.getValueObject("coordination")
		block.setBlockStatus(_BlockStatusType.COORDINATED)
		def signerlist = block.getCurrentCoordinators()
		for (signer in signerlist) {
			if(signer.getUserID() == session.getCurrentUserID()){
				signer.setDecision(_DecisionType.DISAGREE, formData.getValue("comment"))
			}
		}
		doc_blc.setCoordStatus(_CoordStatusType.REJECTED)
		doc.setLastUpdate(new Date())
		doc.setValueString("oldversion", "1")
		doc.setValueNumber("isrejected", 1)
		def _doc = new _Document(cdb)
		doc.copyAttachments(_doc)
		doc.replaceViewText(doc_blc.getStatus().name(), 3)
		doc.save("[supervisor]")
		String vtext_old = doc.getViewText()
		String url_old = doc.getURL()
		String ddbid_old = doc.getID()
		/*Формирование новой версии проекта*/
		doc.setNewDoc()
		doc.setValueNumber("isrejected", 0)
		doc_blc.setCoordStatus(_CoordStatusType.NEWVERSION)
		int docversion = doc.getValueNumber("docversion") + 1
		doc.setValueNumber("docversion", docversion)
		String vn = doc.getValueString("vn")
		doc.setValueString("vn", vn.contains(",") ? vn.replaceFirst(",.", ",") + docversion.toString() : vn + "," + docversion.toString())
		def tDate = new Date()
		doc.setValueDate("projectdate", tDate);
		doc.replaceViewText(' № ' + doc.getValueString("vn") + ' ' + _Helper.getDateAsStringShort(doc.getValueDate("projectdate")) + ' ' + session.getStructure().getEmployer(doc.getAuthorID()).shortName + ' ' + doc.getValueString('briefcontent'), 0)
		doc.clearEditors();
		doc.clearReaders();
		doc.addEditor(doc.getAuthorID());
		def blocks = doc_blc.getBlocks();
		blocks.each{
			it.setBlockStatus(_BlockStatusType.AWAITING);
			it.getCoordinators()*.resetCoordinator();
		}
		_doc.copyAttachments(doc);
        def cBlock = blocksCollection.getCurrentBlock()
        if (cBlock)	{
            doc.replaceViewText(cBlock.getCurrentCoordinatorsAsText(), 5)
        }
		doc.replaceViewText(doc_blc.getStatus().name(), 3);
        def link_old = new _CrossLink(session, url_old, vtext_old);
		doc.addField("versionlink", link_old)
		doc.save("[supervisor]");
		def doc_old = cdb.getDocumentByID(ddbid_old);
		def link_new = new _CrossLink(session, doc);
		doc_old.addField("versionlink", link_new)
		doc_old.save("[supervisor]")
        def signerCoord = (_Coordinator)doc_blc.getSignBlock()?.getFirstCoordinator();
		msg = "Отклонен документ: \"" + doc.getValueString("briefcontent") + "\"(" + formData.getValue("comment") + ")";
		msg += "\nСоздана новая версия, для работы с документом перейдите по ссылке " + doc.getFullURL();
		msngAgent.sendMessageAfter([author?.getInstMessengerAddr()], msg);

		msubject = '[СЭД] [Проекты] Отклонен документ: \"' + doc.getValueString("briefcontent") + '\"(' + formData.getValue("comment") + ')';
		body = '<table cellspacing="0" cellpadding="4" border="0" style="padding:10px; font-size:12px; font-family:Arial;">';
		body += '<tr>';
		body += '<td style="border-bottom:1px solid #CCC;" valign="top" colspan="2">';
		body += 'Документ: \"' +  doc.getValueString("briefcontent") + '\" был отклонен. <br>';
		body += 'Комментарий: ' + signerCoord?.getComment();
		body += '</td></tr><tr>';
		body += '<td colspan="2"></td>';
		body += '</tr></table>';
		body += '<p><font size="2" face="Arial">Создана новая версия, для работы с документом перейдите по <a href="' + doc.getFullURL() + '">ссылке...</a></p></font>';

		try{
			//mailAgent.sendMailAfter([author?.getEmail()], msubject, body)
            mailAgent.sendMailAfter([author?.getEmail()], new _Memo(msubject, 'Документ отклонен', body, doc, false));
		}catch(_Exception e){
			println("mail server error")
            log("Sign_no mail server error")
		}
		def returnURL = session.getURLOfLastPage()
		setRedirectURL(returnURL)

	}

}




