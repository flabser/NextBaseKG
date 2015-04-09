package page.actionbar

import java.util.ArrayList;
import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript { 

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		if(formData.get("id")[0] == 'in'){
			if (user.hasRole(["registrator_incoming"])){
				def newDocAction = new _Action(getLocalizedWord("Новый входящий документ",lang), getLocalizedWord("Создать новый входящий документ", lang), "new_document")
				newDocAction.setURL("Provider?type=edit&element=document&id=in&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang), getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'taskforme'){
			if (user.hasRole(["registrator_tasks"])){
				def newDocAction = new _Action(getLocalizedWord("Новое задание", lang),getLocalizedWord("Создать новое задание",lang), "new_document")
				newDocAction.setURL("Provider?type=edit&id=task&key=")
				actionBar.addAction(newDocAction);
			}
		}
		if(formData.get("id")[0] == 'mytasks'){
			if (user.hasRole(["registrator_tasks","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новое задание",lang), getLocalizedWord("Создать новое задание",lang), "new_document")
				newDocAction.setURL("Provider?type=edit&id=task&key=")
				actionBar.addAction(newDocAction);
				actionBar.addAction(new _Action(getLocalizedWord("Удалить задание", lang),getLocalizedWord("Удалить задание", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'sz'){
			if (user.hasRole(["administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'out'){
			if (user.hasRole(["registrator_outgoing", "administrator"])){
				def newDocAction = new _Action(getLocalizedWord("Новый исходящий документ", lang),getLocalizedWord("Новый исходящий документ", lang),"new_document")
				newDocAction.setURL("Provider?type=edit&amp;id=ish&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["administrator", "chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'letters'){
			if (user.hasRole(["registrator_letter", "administrator"])){
				def newDocAction = new _Action(getLocalizedWord("Новое обращение", lang),getLocalizedWord("Новое обращение граждан",lang), "new_document")
				newDocAction.setURL("Provider?type=edit&id=l&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["administrator", "chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ",lang), _ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'task'){
			if (user.hasRole(["registrator_tasks","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новое задание", lang),getLocalizedWord("Создать новое задание", lang),"new_document")
				newDocAction.setURL("Provider?type=edit&id=task&key=")
				actionBar.addAction(newDocAction);
				actionBar.addAction(new _Action(getLocalizedWord("Удалить задание", lang),getLocalizedWord("Удалить задание", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'workdocprj'){
			if (user.hasRole(["registrator_projects" ,"administrator"])){
				def newDocAction = new _Action(getLocalizedWord("Проект служебной записки", lang),getLocalizedWord("Проект служебной записки", lang),"new_document")
				newDocAction.setURL("Provider?type=edit&id=workdocprj&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["administrator", "chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'outdocprj'){
			if (user.hasRole(["registrator_projects", "administrator"])){
				def newDocAction = new _Action(getLocalizedWord("Проект исходящего документа", lang),getLocalizedWord("Проект исходящего документа",lang), "new_document")
				newDocAction.setURL("Provider?type=edit&id=outdocprj&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["administrator", "chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ",lang), getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'outdocreg'){
			if (user.hasRole(["administrator", "chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'controltype'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый тип контроля", lang),getLocalizedWord("Новый тип контроля", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=controltype&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'docscat'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новая категория", lang),getLocalizedWord("Новая категория",lang), "new_glossary")
				newDocAction.setURL("Provider?type=edit&id=docscat&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ",lang), _ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'har'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый характер вопроса", lang),getLocalizedWord("Новый характер вопроса",lang), "new_glossary")
				newDocAction.setURL("Provider?type=edit&id=har&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'typedoc'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый тип документа", lang),getLocalizedWord("Новый тип документа", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=har&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'deliverytype'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый вид доставки",lang), getLocalizedWord("Новый вид доставки",lang), "new_glossary")
				newDocAction.setURL("Provider?type=edit&id=deliverytype&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'cat'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новая категория граждан", lang),getLocalizedWord("Новая категория граждан", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=cat&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'nomentypelist'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новая номенклатура дел", lang),getLocalizedWord("Новая номенклатура дел",lang), "new_glossary")
				newDocAction.setURL("Provider?type=edit&id=nomentypelist&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'corrlist'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый корреспондент", lang),getLocalizedWord("Новый корреспондент", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=corrlist&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'corrcatlist'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новая категория корреспондентов", lang),getLocalizedWord("Новая категория корреспондентов", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=corrcat&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ",lang), _ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'city'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый город", lang),getLocalizedWord("Новый город", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=city&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		if(formData.get("id")[0] == 'projectsprav'){
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				def newDocAction = new _Action(getLocalizedWord("Новый проект", lang),getLocalizedWord("Новый проект", lang),"new_glossary")
				newDocAction.setURL("Provider?type=edit&id=projectsprav&key=")
				actionBar.addAction(newDocAction);
			}
			if (user.hasRole(["supervisor","administrator","chancellery"])){
				actionBar.addAction(new _Action(getLocalizedWord("Удалить документ", lang),getLocalizedWord("Удалить документ", lang),_ActionType.DELETE_DOCUMENT));
			}
		}
		setContent(actionBar);
	}
}

