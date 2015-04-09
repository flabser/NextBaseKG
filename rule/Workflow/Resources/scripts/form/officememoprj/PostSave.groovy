package form.officememoprj
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.constants._BlockType
import kz.nextbase.script.constants._CoordStatusType
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.events._FormPostSave

class PostSave extends _FormPostSave {

	@Override
	public void doPostSave(_Session session, _Document doc) {
		def struct = session.getStructure();
		def status;
		def mailAgent = session.getMailAgent()
		def msngAgent = session.getInstMessengerAgent()
		def	blocksCollection  = (_BlockCollection)doc.getValueObject("coordination")

		if(blocksCollection == null){
			blocksCollection = new _BlockCollection(session)
		}
		status = blocksCollection.getStatus();
		if (status != _CoordStatusType.DRAFT) {
			doc.clearEditors();
		}
		doc.save("[supervisor]");
		def coordBlocks = blocksCollection.getCoordBlocks();
		if(status != _CoordStatusType.DRAFT){
			if(!coordBlocks.empty){
				def blockNum = 0;
				def block = coordBlocks.get(blockNum);
				def recipientsMail = []
				def recipientsID = []
				
				if (block.getBlockType() == _BlockType.SERIAL_COORDINATION){
					def coord = block.getFirstCoordinator()
					if (coord){
						def emp = struct.getEmployer(coord.getUserID())
						recipientsMail.add(emp.getEmail())
						recipientsID.add(emp.getInstMessengerAddr())
					}
				}else if (block.getBlockType() == _BlockType.PARALLEL_COORDINATION){
					def coords = block.getCoordinators()
					coords.each{coord ->
						def emp = struct.getEmployer(coord.getUserID())
						recipientsMail.add(emp.getEmail())
						recipientsID.add(emp.getInstMessengerAddr())
					}
				}
				
				
				if (recipientsID && recipientsMail) {
					String msg = "Вам проект внутреннего документа на согласование: \"" + doc.getValueString("briefcontent") + "\" \nДля работы с документом перейдите по ссылке " + doc.getFullURL();
					msngAgent.sendMessage(recipientsID, doc.getValueString("project_name") + ": " + msg);
					String msubject = 'Прошу согласовать документ \"' + doc.getValueString("briefcontent") + '\"';
					String body = '<b><font color="#000080" size="4" face="Default Serif">Проект внутреннего документа на согласование</font></b><hr>';
					body += '<table cellspacing="0" cellpadding="4" border="0" style="padding:10px; font-size:12px; font-family:Arial;">';
					body += '<tr>';
					body += '<td style="border-bottom:1px solid #CCC;" valign="top" colspan="2">';
					body += 'Вам документ на согласование \"' + doc.getValueString("briefcontent") + '\"' + '<br>';
					body += '</td></tr><tr>';
					body += '<td colspan="2"></td>';
					body += '</tr></table>';
					body += '<p><font size="2" face="Arial">Для работы с документом перейдите по <a href="' + doc.getFullURL() + '">ссылке...</a></p></font>';
					mailAgent.sendMailAfter(recipientsMail, msubject, body);
				}
			}else{
				def signBlock = blocksCollection.getSignBlock()
				def signer = signBlock.getFirstCoordinator();
				if (signer){
					def recipientsMail = []
					def recipientsID = []
					def emp = struct.getEmployer(signer.getUserID())
					recipientsMail.add(emp.getEmail())
					recipientsID.add(emp.getInstMessengerAddr())
					def signerID = [signer.getUserID()];
					String msg = "Вам документ на подпись: \"" + doc.getValueString("briefcontent") + "\" \nДля работы с документом перейдите по ссылке " + doc.getFullURL();
					msngAgent.sendMessage(recipientsID, doc.getValueString("project_name") + ": " + msg);
					String msubject = 'Прошу подписать документ \"' + doc.getValueString("briefcontent") + '\"';
					
					String body = '<b><font color="#000080" size="4" face="Default Serif">Документ на подпись</font></b><hr>';
					body += '<table cellspacing="0" cellpadding="4" border="0" style="padding:10px; font-size:12px; font-family:Arial;">';
					body += '<tr>';
					body += '<td style="border-bottom:1px solid #CCC;" valign="top" colspan="2">';
					body += 'Вам документ на подпись \"' + doc.getValueString("briefcontent") + '\"' + '<br>';
					body += '</td></tr><tr>';
					body += '<td colspan="2"></td>';
					body += '</tr></table>';
					body += '<p><font size="2" face="Arial">Для работы с документом перейдите по <a href="' + doc.getFullURL() + '">ссылке...</a></p></font>';
					mailAgent.sendMailAfter(recipientsMail, msubject, body);
				}
			}
		}
	}
}