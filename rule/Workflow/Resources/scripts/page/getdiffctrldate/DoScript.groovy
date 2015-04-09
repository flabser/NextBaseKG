package page.getdiffctrldate

import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.task._Control

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
        def endDate = _Helper.convertStringToDate(formData.getValue("enddate"));
		def	control = new _Control(session, new Date(), false, endDate)
		def diff =  control.getDiffBetweenDays()
		def rootTag = new _Tag(formData.getValue("id"),"")
		rootTag.addTag(new _Tag("daydiff",diff))
		def xml = new _XMLDocument(rootTag)
		setContent(xml);
	}
}




