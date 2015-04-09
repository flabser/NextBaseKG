package page.json_constructor

import com.google.gson.Gson
import kz.nextbase.script.*
import kz.nextbase.script.concurrency._AJAXHandler
import kz.nextbase.script.constants._JSONTemplate;
import kz.nextbase.script.constants._PeriodType
import kz.nextbase.script.events._DoScript

class TestAjax extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		publishElement("button1","somediv","somebutton", new ggg(),true, _JSONTemplate.ALERT)
		publishElement("somediv2","somebutton2", new ggg1(formData),true, _JSONTemplate.POPULATE_SPOT)
	}
	
	class ggg extends _AJAXHandler{		
		public void doProcess() {
			List<String> list = new ArrayList<String>()
			list.add("item1")
			list.add("item2")
			list.add("item3")
			def json = new Gson().toJson(list)
			publishJSON(json)	
		}
		
	}
	
	class ggg1 extends _AJAXHandler{
		def formData;
		
		ggg1(_WebFormData fd){
			formData = fd
		}
		
		
		public void doProcess() {
			sleep(1000)
			List<String> list = new ArrayList<String>()
			for(def v:formData.getFormData().values()){
				sleep(500)
				list.add(v)
			}
			
			def json = new Gson().toJson(list)
			publishJSON(json)
		}
		
	}
}




