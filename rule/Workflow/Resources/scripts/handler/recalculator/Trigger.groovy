package handler.recalculator

import kz.nextbase.script._Session
import kz.nextbase.script._ViewEntry
import kz.nextbase.script.events._DoScheduledHandler
import kz.nextbase.script.task._Control

class Trigger extends _DoScheduledHandler {

	@Override
	public int doHandler(_Session session) {

		def db = session.getCurrentDatabase()
		def col = db.getCollectionOfDocuments("form='task' and viewtext3 = '1'", true).getEntries()
		col.each { _ViewEntry entry ->
			def doc = entry.getDocument()
            def control = (_Control) doc.getValueObject("control")
            if (control) {
                doc.setValueNumber("duedatedif", control.getDiffBetweenDays())
                doc.setViewNumber(control.getDiffBetweenDays())
                doc.setViewDate(control.getCtrlDate())
                doc.save("[supervisor]")
            }
		}

		return 0;
	}
}