/* author John - Lab of the future */
function sorting(pageid,column, direction){
	$.ajax({
		type: "POST",
		datatype:"XML",
		url: "Provider?type=service&operation=tune_session&element=page&id="+pageid+"&param=sorting_mode~on&param=sorting_column~"+column.toLowerCase() +"&param=sorting_direction~"+direction.toLowerCase()+"&nocache="+Math.random() * 300,
		success: function (msg){
			window.location.reload()
		},
		error: function(data,status,xhr) {
		}
	})
}

function delDocument(dbID,typedel){
	var checkboxes = $("input[name^='chbox']:checked");
	if(checkboxes.length != 0){
		loadingOutline()
		var paramfields="";
		checkboxes.each(function(index, element){
			 var ck={
				doctype : $(element).val(),
				docid : $(element).attr("id")
			 };
			paramfields += $.param(ck)
			if (index+1 != checkboxes.length){
				paramfields +="&";
			}
		});
		$.ajax({
			type: "POST",
			datatype:"XML",
			url: "Provider?type=page&id=delete_document&nocache="+Math.random() * 300,
			data: paramfields,
			success: function (msg){
				endLoadingOutline()
				deleted = $(msg).find("deleted").attr("count");
				undeleted = $(msg).find("undeleted").attr("count");
				divhtml ="<div id='dialog-message'"
				if($.cookie("lang")=="RUS" || !$.cookie("lang"))
					 divhtml +="title='Удаление'>";	
				else if($.cookie("lang")=="KAZ")
					 divhtml +="title='Жою'>";	
				else if($.cookie("lang")=="ENG")
					 divhtml +="title='Deleting'>";
					
				if($(msg).find("response").find("error").text().length != 0 || deleted == 0){
					divhtml += "<font style='font-weight:bold'>";
					if($.cookie("lang")=="RUS" || !$.cookie("lang"))
						  divhtml += "Ошибка удаления";
					else if($.cookie("lang")=="KAZ")
						  divhtml += "Жою қателігі";
					else if($.cookie("lang")=="ENG")
						  divhtml += "Error deleting";
								
					divhtml += "</font><br/>";
					divhtml += "<div style='width:100%; max-height:65px; overflow:hidden; word-wrap:break-word; font-size:12px; margin-top:5px'>"+$(msg).find("response").find("error").text()+"</div>";
				}else{
					divhtml += "<font style='font-weight:bold'>";
					if($.cookie("lang")=="RUS" || !$.cookie("lang"))
						divhtml += "Удаление завершено успешно";
					else if($.cookie("lang")=="KAZ")
						divhtml += "Жою сәтті аяқталды";
					else if( $.cookie("lang")=="ENG")
						divhtml += "Successfully deleted"; 
						 
					divhtml += "</font><br/>";
				}
				divhtml += "<div style='width:100%; font-size:13px; margin-top:5px'>";
				if($.cookie("lang")=="RUS" || !$.cookie("lang"))
					divhtml += "Не удалено : ";
				else if($.cookie("lang")=="KAZ")
					divhtml += "Жойылмады : ";
				else if($.cookie("lang")=="ENG")
					divhtml += "Not deleted : ";
					  
				divhtml +=undeleted + "</div>";
				$(msg).find("undeleted").find("entry").not(":contains('undefined')").each(function(){
					divhtml += "<div style='width:360px; margin-left:20px; font-size:12px; overflow:hidden'>"+$(this).text()+"</div>";
				})
				divhtml += "<div style='width:100%; font-size:13px'>";
				if($.cookie("lang")=="RUS" || !$.cookie("lang"))
					divhtml += "Удалено : ";
				else if($.cookie("lang")=="KAZ")
					divhtml += "Жойылды : ";
				else if($.cookie("lang")=="ENG")
					divhtml += "Deleted : ";
					  
				divhtml += deleted +"</div>";
				$(msg).find("deleted").find("entry").not(":contains('undefined')").each(function(){
					divhtml += "<div style='width:360px; margin-left:20px; font-size:12px; overflow:hidden'>"+$(this).text()+"</div>";
				})
				divhtml += "</div>";
				$("body").append(divhtml);
				$("#dialog").dialog("destroy");
				$("#dialog-message").dialog({
					modal: true,
					width: 400,
					buttons: {
						"Ок": function() {
							window.location.reload();
						}
					},
					beforeClose: function() {
						window.location.reload();
					}
				});
			},
			error: function(data,status,xhr){
				if($.cookie("lang")=="RUS" || !$.cookie("lang"))
					infoDialog("Ошибка удаления")
				else if($.cookie("lang")=="KAZ")
					infoDialog("Жою қателігі")
				else if($.cookie("lang")=="ENG")
					infoDialog("Error deleting")
				}
			})
	}else{
		if($.cookie("lang")=="RUS" || !$.cookie("lang"))
			infoDialog("Не выбран документ для удаления")
		else if($.cookie("lang")=="KAZ")
			infoDialog("Жойылатын құжат таңдалмады")
		else if($.cookie("lang")=="ENG")
			infoDialog("Document is not selected")
	}
}

function removeFromFavs(){
	 if($("input[name='chbox']:checked").length != 0){
		$("input[name='chbox']:checked").each(function(index, el){
				//$(this).closest("span").children("td :last").children("img").click();
			//alert(el.id)
				removeDocFromFav(el, el.id, $(el).val())
				$(this).closest("span").remove();
			}
		)
		$("#allchbox").removeAttr("checked");
	}else{
		if($.cookie("lang")=="RUS" || !$.cookie("lang"))
			infoDialog("Выберите документ для удаления")
		else if( $.cookie("lang")=="KAZ")
			infoDialog("Жоятын құжатты таңдаңыз")
		else if( $.cookie("lang")=="ENG")
			infoDialog("Please select the document to delete")
	}
}
