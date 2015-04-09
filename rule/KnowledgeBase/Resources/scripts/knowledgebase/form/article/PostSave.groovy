package knowledgebase.form.article

import java.util.ArrayList;

import kz.nextbase.script._Document;
import kz.nextbase.script._Session;
import kz.nextbase.script.events._FormPostSave;
import kz.nextbase.script.*;

class PostSave extends _FormPostSave{

	@Override
	public void doPostSave(_Session ses, _Document doc) {
		def struc = ses.getStructure();

		println("PostSave: " + doc.doc.getViewTextList()[3])
		if(doc.doc.getViewTextList()[3] == "0"){
			def ma = ses.getMailAgent();
			def imAgent = ses.getInstMessengerAgent();
			
			def readers = doc.getReaders();
			def editors = doc.getEditors();
			Set recipients = new HashSet<String>();
			Set IMrecipients = new HashSet<String>();

			editors.each{
				if(it!=doc.getAuthorID()){
					def emp = struc.getEmployer(it);
					recipients.add(emp?.getEmail());
                    IMrecipients.add(emp?.getInstMessengerAddr());
				}
			}
			readers.each{
				if(it!=doc.getAuthorID()){
					def emp = struc.getEmployer(it.getUserID());
					recipients.add(emp?.getEmail());
                    IMrecipients.add(emp?.getInstMessengerAddr());
				}
			}
			ArrayList<String> rep = recipients.toArray();
            ArrayList<String> IMrep = IMrecipients.toArray();
			try{
				ma.sendMail(rep, "Уведомление о новой статье в Базе Знаний", getMailContent(struc, doc));
			}catch(Exception e){}
			try{
				imAgent.sendMessage(IMrep,"Уведомление о новой статье в Базе Знаний " +  getIMContent(struc, doc));
			}catch(Exception e){}
		}
	}

	def getMailContent(def struc, _Document doc){
		
		String content = "Автор: " + struc.getEmployer(doc.getAuthorID()).getShortName();
		content += "<br/><br/><b>" +doc.getValueString("topic")+"</b>";
		content += "<br/>" + _Helper.removeHTMLTags(doc.getValueString("briefcontent"));
	 
		String body = '<b><font color="#000080" size="4" face="Default Serif">Уведомление о новой статье в Базе Знаний</font></b><hr>'
		body += '<table cellspacing="0" cellpadding="4" border="0" style="padding:10px; font-size:12px; font-family:Arial;">'
		body += '<tr>'
		 
		body += '<td width="210px">Автор:</td>';
		body += '<td width="500px">'+struc.getEmployer(doc.getAuthorID()).getShortName()+'</td>';
		body += '</tr><tr><td width="210px">Тема:</td>';
		body += '<td width="500px">'+doc.getValueString("topic")+'</td>';
		body += '</tr><tr><td width="210px">Содержание:</td>';
		body += '<td width="500px">'+ _Helper.removeHTMLTags(doc.getValueString("briefcontent"))+'</td>';
		body += '</tr></table>';
		body += '<p><font size="2" face="Arial">Прочитать статью можно по <a href="' + doc.getFullURL() + '">ссылке...</a></p></font>'
		return body;
	}
	
	
	def getIMContent(def struc, _Document doc){
		String content = "Автор: " + struc.getEmployer(doc.getAuthorID()).getShortName();
		content += "\nТема: " +doc.getValueString("topic");
		content += "\nСодержание: " + _Helper.removeHTMLTags(doc.getValueString("briefcontent"));
        content += "\n" + doc.getFullURL();
		return content;
	}
}
