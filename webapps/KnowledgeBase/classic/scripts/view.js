function message(text,elID){
	 if ($.cookie("lang")=="RUS") 
	   divhtml ="<div id='dialog-message' title='Предупреждение'>";
	 else if($.cookie("lang")=="KAZ") 
		   divhtml ="<div id='dialog-message' title='Ескерту'>";
	 else if($.cookie("lang")=="ENG") 
		   divhtml ="<div id='dialog-message' title='Warning'>";
	 
	 divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	 "<font style='font-size:13px;'>"+ text +"</font>"+"</span>";
	 divhtml += "</div>";
	 $("body").append(divhtml);
	 $("#dialog").dialog("destroy");
	 $("#dialog-message").dialog({
		height:140,
		modal: true,
		buttons: {
			"Ок": function(){
				$(this).dialog("close").remove();
				if (elID !=null){
					$("#"+elID).focus()
				}
			}
		}
	});
}