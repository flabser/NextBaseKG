package page.share_navigator

import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.outline.*;

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		//println(lang)
		def list = []
		def user = session. getCurrentAppUser()
		def outline = new _Outline("", "", "outline")



		def orgdocs_outline = new _Outline(getLocalizedWord("Документы организации",lang), getLocalizedWord("Документы организации",lang), "orgdocs")
		def workdoc = new _OutlineEntry(getLocalizedWord("Внутренние документы",lang), getLocalizedWord("Внутренние документы",lang), "workdoc", "Provider?type=page&id=workdoc&page=0")
        orgdocs_outline.addEntry(addEntryByFinalDocType(session, workdoc, "workdoc"));

        def indocs = new _OutlineEntry(getLocalizedWord("Входящие",lang), getLocalizedWord("Входящие",lang), "in", "Provider?type=page&id=in&page=0");
        orgdocs_outline.addEntry(addEntryByProjects(session, indocs, "IN", "glossary"));

        def outdocs = new _OutlineEntry(getLocalizedWord("Исходящие",lang), getLocalizedWord("Исходящие",lang), "out", "Provider?type=page&id=out&page=0")
        orgdocs_outline.addEntry(addEntryByProjects(session, outdocs, "out", ""));

		orgdocs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Обращения граждан",lang), getLocalizedWord("Обращения граждан",lang), "letters", "Provider?type=page&id=letters&page=0"))
		def taskdocs = new _OutlineEntry(getLocalizedWord("Задания",lang), getLocalizedWord("Задания",lang), "task", "Provider?type=page&id=task&page=0");
        orgdocs_outline.addEntry(taskdocs);

        outline.addOutline(orgdocs_outline)
		list.add(orgdocs_outline)
		def projects_outline = new _Outline(getLocalizedWord("Проекты организации",lang), getLocalizedWord("Проекты организации",lang), "projects")
		def officememoprj = new _OutlineEntry(getLocalizedWord("Внутренние документы",lang), getLocalizedWord("Внутренние документы",lang), "officememoprj", "Provider?type=page&id=officememoprj&page=0")
        projects_outline.addEntry(addEntryByFinalDocType(session, officememoprj, "officememoprj"));

		def outgoingprj = new _OutlineEntry(getLocalizedWord("Исходящие",lang), getLocalizedWord("Исходящие",lang), "outgoingprj", "Provider?type=page&id=outgoingprj&page=0");
        projects_outline.addEntry(addEntryByProjects(session, outgoingprj, "outgoingprj", ""));

		list.add(projects_outline)
		outline.addOutline(projects_outline)

		if (user.hasRole("chancellery")){
			def docstoreg_outline = new _Outline(getLocalizedWord("На регистрацию",lang), getLocalizedWord("На регистрацию",lang), "docstoreg")
			docstoreg_outline.addEntry(new _OutlineEntry(getLocalizedWord("Исходящие",lang), getLocalizedWord("Исходящие",lang), "outdocreg", "Provider?type=page&id=outdocreg&page=0"))
			docstoreg_outline.addEntry(new _OutlineEntry(getLocalizedWord("Входящие",lang), getLocalizedWord("Входящие",lang), "indocreg", "Provider?type=page&id=indocreg&page=0"))
			outline.addOutline(docstoreg_outline)
			list.add(docstoreg_outline)
		}

		def reports_outline = new _Outline(getLocalizedWord("Отчеты",lang), getLocalizedWord("Отчеты",lang), "reports")
		reports_outline.addEntry(new _OutlineEntry(getLocalizedWord("Задания",lang), getLocalizedWord("Задания",lang), "report_tasks", "Provider?type=page&id=report_tasks&page=0"))
		outline.addOutline(reports_outline)
		list.add(reports_outline)
		if (user.hasRole("administrator")){
			def glossary_outline = new _Outline(getLocalizedWord("Справочники",lang), getLocalizedWord("Справочники",lang), "glossary")
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип контроля",lang), getLocalizedWord("Тип контроля",lang), "controltype", "Provider?type=page&id=controltype"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория",lang), getLocalizedWord("Категория",lang), "docscat", "Provider?type=page&id=docscat&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Характер вопроса",lang), getLocalizedWord("Характер вопроса",lang), "har", "Provider?type=page&id=har"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип документа",lang), getLocalizedWord("Тип документа",lang), "typedoc", "Provider?type=page&id=typedoc&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Вид доставки",lang), getLocalizedWord("Вид доставки",lang), "deliverytype", "Provider?type=page&id=deliverytype&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория граждан",lang), getLocalizedWord("Категория граждан",lang), "cat", "Provider?type=page&id=cat"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Номенклатура дел",lang), getLocalizedWord("Номенклатура дел",lang), "nomentypelist", "Provider?type=page&id=nomentypelist&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория корреспондентов",lang), getLocalizedWord("Категория корреспондентов",lang), "corrcatlist", "Provider?type=page&id=corrcatlist&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Корреспонденты",lang), getLocalizedWord("Корреспонденты",lang), "corrlist", "Provider?type=page&id=corrlist&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Адресат",lang), getLocalizedWord("Адресат",lang), "addressee", "Provider?type=page&id=addressee&sortfield=VIEWTEXT1&order=ASC"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Регион/Город",lang), getLocalizedWord("Регион/Город",lang), "city", "Provider?type=page&id=city"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Проекты",lang), getLocalizedWord("Проекты",lang), "projectsprav", "Provider?type=page&id=projectsprav"))
			glossary_outline.addEntry(new _OutlineEntry(getLocalizedWord("Тип конечного документа",lang), getLocalizedWord("Тип конечного документа",lang), "finaldoctype", "Provider?type=page&id=finaldoctype"))
			outline.addOutline(glossary_outline)
			list.add(glossary_outline)
		}
		
		def add_outline = new _Outline(getLocalizedWord("Прочее",lang), getLocalizedWord("Прочее",lang), "add")
		add_outline.addEntry(new _OutlineEntry(getLocalizedWord("Корзина",lang), getLocalizedWord("Корзина",lang), "recyclebin", "Provider?type=page&id=recyclebin"))
		outline.addOutline(add_outline)
		list.add(add_outline)
		
		setContent(list)
	}

    def addEntryByProjects(_Session session, def entry, formid, fieldtype){

        def projects = session.getCurrentDatabase().getGroupedEntries("project#${fieldtype == ""? "number" : fieldtype}", 1, 20);
        def cdb = session.getCurrentDatabase();
        def pageid = "docsbyproject";

        if(formid == 'officememoprj' || formid == 'outgoingprj')
            pageid = "prjbyproject";

        projects.each{
            def name = cdb.getGlossaryDocument(new BigDecimal(it.getViewText()).intValue())?.getName();
            if(name != null && name != ""){
               entry.addEntry(new _OutlineEntry(name, name, formid + it.getViewText(), "Provider?type=page&id=$pageid&projectid=${it.getViewText()}&formid=$formid&page=0"));
            }
        }
        return entry;
    }

    def addEntryByFinalDocType(_Session session, def entry, formid){

        def projects = session.getCurrentDatabase().getGroupedEntries("finaldoctype#number", 1, 20);
        def cdb = session.getCurrentDatabase();
        def pageid = "prjbyfinaldoctype";
        if(formid == "workdoc")
            pageid = "docsbyfinaldoctype";
        for(it in projects){
            try{
                int docid = it.getViewText().toDouble().toInteger()
                def name = cdb.getGlossaryDocument(docid)?.getName();
                if(name != null && name != ""){
                    entry.addEntry(new _OutlineEntry(name, name, formid + it.getViewText(), "Provider?type=page&id=$pageid&finaldoctype=$docid&formid=$formid&page=0"));
                }
            }catch(Exception e){}
        }

        return entry;
    }
}
