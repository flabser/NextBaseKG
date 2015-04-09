package form.outgoingprj
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script.constants._BlockType
import kz.nextbase.script.constants._CoordStatusType
import kz.nextbase.script.coordination._BlockCollection
import kz.nextbase.script.events._FormPostSave

class PostSave extends _FormPostSave {

	@Override
	public void doPostSave(_Session session, _Document doc) {
        println("PostSave")
		def mailAgent = session.getMailAgent();
		def msngAgent = session.getInstMessengerAgent();
		def status;
		def	blocksCollection  = (_BlockCollection)doc.getValueObject("coordination")
        def struct = session.getStructure()
		if(blocksCollection == null){
			blocksCollection = new _BlockCollection(session)
		}
		
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
					String msg = "Вам проект исходящего документа на согласование: \"" + doc.getValueString("briefcontent") + "\" \nДля работы с документом перейдите по ссылке " + doc.getFullURL();
					msngAgent.sendMessage(recipientsID, doc.getValueString("project_name") + ": " + msg);
					String msubject = 'Прошу согласовать документ \"' + doc.getValueString("briefcontent") + '\"';
					String body = '<b><font color="#000080" size="4" face="Default Serif">Проект исходящего документа на согласование</font></b><hr>';
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
		
		/*status = blocksCollection.getStatus();
		if (status != _CoordStatusType.DRAFT) {
            def coordBlocks = blocksCollection.getCoordBlocks()
            if (!coordBlocks.empty){
                def blockNum = 0
                def block = coordBlocks.get(blockNum)
                def recipientsMail = []
                def recipientsIM = []
                //Присваиваем первому согласовательному блоку статус "На согласовании"
                if (block && block.getBlockType() != _BlockType.TO_SIGN){
                    block.setBlockStatus(_BlockStatusType.COORDINATING)
                    if (block.getBlockType() == _BlockType.SERIAL_COORDINATION){
                        def coord = block.getFirstCoordinator()
                        if (coord){
                            def emp = struct.getEmployer(coord.getUserID())
                            recipientsMail.add(emp.getEmail())
                            recipientsIM.add(emp.getInstMessengerAddr())
                        }
                    }else if (block.getBlockType() == _BlockType.PARALLEL_COORDINATION){
                        def coords = block.getCoordinators()
                        coords.each{coord ->

                            def emp = struct.getEmployer(coord.getUserID())
                            recipientsMail.add(emp.getEmail())
                            recipientsIM.add(emp.getInstMessengerAddr())
                        }
                    }

                    def mailAgent = session.getMailAgent()
                    def msngAgent = session.getInstMessengerAgent()
                    // notification
                    if (recipientsIM) {
                        String msg = "Вам документ на согласование: \"" + doc.getValueString("briefcontent") + "\" \nДля работы с документом перейдите по ссылке " + doc.getFullURL();
                        msngAgent.sendMessage(recipientsIM, doc.getValueString("project_name") + ": " + msg);
                    }


                    String msubject = 'Прошу согласовать документ \"' + doc.getValueString("briefcontent") + '\"';
                    String body = '<b><font color="#000080" size="4" face="Default Serif">Документ на согласование</font></b><hr>';
                    body += '<table cellspacing="0" cellpadding="4" border="0" style="padding:10px; font-size:12px; font-family:Arial;">';
                    body += '<tr>';
                    body += '<td style="border-bottom:1px solid #CCC;" valign="top" colspan="2">';
                    body += 'Вам документ на согласование \"' + doc.getValueString("briefcontent") + '\"' + '<br>';
                    body += '</td></tr><tr>';
                    body += '<td colspan="2"></td>';
                    body += '</tr></table>';
                    body += '<p><font size="2" face="Arial">Для работы с документом перейдите по <a href="' + doc.getFullURL() + '">ссылке...</a></p></font>';

                    if (recipientsMail) {
                        mailAgent.sendMailAfter(recipientsMail, msubject, body);
                    }
                }
            }
		}
		
		*/
	}
}