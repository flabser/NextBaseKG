package structure.page.orglist

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

/**
 * Created by Bekzat on 2/6/14.
 */
class DoScript extends _DoScript{

    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        def cdb = session.getCurrentDatabase()
        session.getStructure()

    }
}
