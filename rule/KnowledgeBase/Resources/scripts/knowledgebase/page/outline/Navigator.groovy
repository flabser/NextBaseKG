package knowledgebase.page.outline

/**
 * Created by Bekzat on 2/3/14.
 */

import kz.nextbase.script._Session;
import kz.nextbase.script._WebFormData;
import kz.nextbase.script.events._DoScript;
import kz.nextbase.script.outline.*;
import kz.nextbase.script.*;

class Navigator extends _DoScript{
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def list = []
        def user = session.getCurrentAppUser()
        def cdb = session.getCurrentDatabase();
        def docs_outline = new _Outline(getLocalizedWord("База знаний",lang), getLocalizedWord("База знаний",lang), "docs")
        docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Избранные",lang), getLocalizedWord("Избранные",lang), "favdocs", "Provider?type=page&id=favdocs&page=1"))

        def articles = new _OutlineEntry(getLocalizedWord("Статьи",lang), getLocalizedWord("Статьи",lang), "article", "Provider?type=page&id=article&page=1");

        def col = session.currentDatabase.getGroupedEntries("category",1,100)
        col.each{
            def viewEntry = (_ViewEntry)it;
            try{
                def doc = session.currentDatabase.getGlossaryDocument("category", "ddbid='${viewEntry.getViewText(0)}'");
                def outlineEntry = new _OutlineEntry(doc.getViewText(), doc.getViewText(), viewEntry.getViewText(1), "Provider?type=page&id=articlebycategory&category=" + viewEntry.getViewText(0) + "&page=0")
                outlineEntry.setValue(doc.getViewText())
                articles.addEntry(outlineEntry)
            }catch(_Exception e){

            }
        }
        docs_outline.addEntry(articles)
		docs_outline.addEntry(new _OutlineEntry(getLocalizedWord("Корзина",lang), getLocalizedWord("Корзина",lang), "recyclebin", "Provider?type=page&id=recyclebin"))
        list.add(docs_outline)

        if (user.hasRole("administrator")){
            def docs1_outline = new _Outline(getLocalizedWord("Справочники",lang), getLocalizedWord("Справочники",lang), "docs1")
            docs1_outline.addEntry(new _OutlineEntry(getLocalizedWord("Категория",lang), getLocalizedWord("Категория",lang), "category", "Provider?type=page&id=category&page=0"))
            docs1_outline.addEntry(new _OutlineEntry(getLocalizedWord("Подкатегория",lang), getLocalizedWord("Подкатегория",lang), "subcategory", "Provider?type=page&id=subcategory&page=0"))
            list.add(docs1_outline);
        }
		
        setContent(list)
    }

    def glossList(_Session ses, String gloss_form, def outline_folder, String lang, String pageID){

        def cdb = ses.getCurrentDatabase();
        def glist = cdb.getGlossaryDocs(gloss_form, "form='$gloss_form'");

        for(def gdoc in glist){
            String name = (lang == "RUS" ? gdoc.getName().split("#")[1] : gdoc.getName().split("#")[0]);
            outline_folder.addEntry(new _OutlineEntry(getLocalizedWord(name,lang),
                    getLocalizedWord(name,lang), gdoc.getDocID().toString(), "Provider?type=page&id={$pageID}_by_region&page=1&region="+ gdoc.getDocID().toString()))

        }

        return outline_folder;
    }
}