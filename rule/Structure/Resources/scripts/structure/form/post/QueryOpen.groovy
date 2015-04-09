package structure.form.post

import kz.nextbase.script._Document
import kz.nextbase.script._Glossary
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions._Action
import kz.nextbase.script.actions._ActionType
import kz.nextbase.script.events._FormQueryOpen

/**
 * Created by Bekzat on 4/15/14.
 */
class QueryOpen extends _FormQueryOpen {
    @Override
    void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
        def actionBar = session.createActionBar();
        def user = session.getCurrentAppUser()
        if (user.hasRole(["supervisor"])){
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
        }
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
        publishElement(actionBar)
        def nav = session.getPage("outline", webFormData)
        publishElement(nav)
    }

    @Override
    void doQueryOpen(_Session session, _Document doc, _WebFormData webFormData, String lang) {
        def glos = (_Glossary)doc;
        def actionBar = session.createActionBar();
        def user = session.getCurrentAppUser()
        if (user.hasRole(["supervisor"])){
            actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть", lang),getLocalizedWord("Сохранить и закрыть", lang),_ActionType.SAVE_AND_CLOSE))
        }
        actionBar.addAction(new _Action(getLocalizedWord("Закрыть", lang),getLocalizedWord("Закрыть без сохранения",lang), _ActionType.CLOSE))
        publishElement(actionBar)

        publishValue("name", glos.getName());
        publishValue("code", glos.getCode());
        publishValue("ranktext", glos.getRankText());
    }
}
