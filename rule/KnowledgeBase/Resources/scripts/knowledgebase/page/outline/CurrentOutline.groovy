package knowledgebase.page.outline

/**
 * Created by Bekzat on 2/3/14.
 */
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScript

class CurrentOutline extends _DoScript {

    @Override
    public void doProcess(_Session session, _WebFormData formData, String lang) {

        def rootTag = new _Tag()

        def entryTag = new _Tag("entry",formData.getEncodedValueSilently("title"))

        entryTag.setAttr("pageid",formData.getValueSilently("id"))
        entryTag.setAttr("entryid",formData.getValueSilently("entryid"))
        rootTag.addTag(entryTag)

        def xml = new _XMLDocument(rootTag)
        setContent(xml);

    }
}