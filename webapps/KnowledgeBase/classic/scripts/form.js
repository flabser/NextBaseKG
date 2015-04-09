var lang = "RUS";
var fieldIsValid = true;
var alertmessage = '';
/* переменные для перевода диалогов */
var acquaintcaption = "Уведомить о новой доработке"; 
var remindcaption = "Напомнить"; 
var cancelcaption = "Отмена"; 
var changeviewcaption = "Изменить вид"; 
var receiverslistcaption = "Список получателей напоминания"; 
var correspforacquaintance = "Список корреспондентов для ознакомления"; 
var searchcaption = "Поиск"; 
var commentcaption = "Комментарий";
var pleasewaitdocsave = "Пожалуйста ждите... Идет сохранение документа"; 
var documentsavedcaption = "Документ сохранен"; 
var documentmarkread = "Документ отмечен как прочтенный"; 
var redirectAfterSave = "";
var attention ="Внимание";
var notifyofnewimplement="Уведомить о реализации новой доработки?";
var removedcaption ="Пожалуйста ждите...Идет процесс снятия с контроля";
var removedfromcontrol ="Документ снят с контроля";
var reason_canceldemand="Выберите причину отмены заявки";
var projects="Проекты";
var read ="Прочтен";
var addcommentforattachment ="Добавить комментарий к вложению?";
var showfilename ="Укажите имя файла для вложения";
var addcomment='Добавить комментарий';
var warning ="Внимание";
var delete_file ="Удалить файл";

var quickanswer = null ;
var prevvalanswer = null ;
var preview = null;

function addquickanswer(targetid , val, button){
	if (!$(button).hasClass("inited")){
		$(".inited").removeClass("inited")
		$(button).addClass("inited")
		if (preview == false){
			$("#"+targetid).val($("#"+targetid).val() +" " + val);
		}
		preview = false
	}else{
		$("#"+targetid).val(prevvalanswer)
		$(".inited").removeClass("inited")
	}
}

function previewquickanswer(targetid , val, button){
	if (!$(button).hasClass("inited")){
		if (prevvalanswer == null){
			prevvalanswer = $("#"+targetid).val();
			$("#"+targetid).val($("#"+targetid).val() +" " + val);
		}else{
			$("#"+targetid).val(prevvalanswer +" " + val);
		}
		preview = true
	}
}

function endpreviewquickanswer(targetid , val, button){
	if (!$(button).hasClass("inited")){
		if (prevvalanswer == null){
			$("#"+targetid).val($("#"+targetid).val());
		}else{
			$("#"+targetid).val(prevvalanswer);
		}
	}
}

function resetquickanswerbutton(){
	$(".inited").removeClass("inited");
	quickanswer = null ;
	prevvalanswer = null ;
	preview = null ;
}

function changeCustomField(name,value){
	$("input[name="+name+"]").val(value);
}

$.fn.extend({
    notify : function(options) {
    	var defaults = { 
    		text: "",
    	  	onopen: function(){$("body").hidenotify()},
    	  	loadanimation:true
    	};
    	var opts = $.extend(defaults, options);
    	$(this).append("<div id='notifydiv'><font>"+opts.text+"</font></div>")
    	if (opts.loadanimation){
    		$("#notifydiv").append("<img src='classic/img/26.png' style='position:absolute; top:3px; right:10px'/>")
    	}
    	$("#notifydiv").animate({top: '0px'},'fast',opts.onopen);
    },
    hidenotify : function(options) {
    	var defaults = { 
        	delay: "1500",
        	onclose: function(){}
        };
        var opts = $.extend(defaults, options);
    	setTimeout(function() {
    		$("#notifydiv").animate({top: '-40px'},'fast',opts.onclose);
        }, opts.delay);
    }
});    
    
function resetcontrol(docid, page){
	var hl = "controloff";
	divhtml = "<div id='dialog-control' title='"+attention+"'>";
	divhtml += "<div style='height:40px;width:98%;font-size:14px;'>";
	divhtml += notifyofnewimplement+"</div>";
	divhtml += "</div>";
	$("body").append(divhtml);
	if ($.cookie("lang")=='ENG'){
		$("#dialog-control").dialog({
			modal: true,
			height:140,
			width:400,
			buttons: {
				'Cancel': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					return false;
				},
				'Remove from control': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					controlOff(docid, page);
					return false;
				},
				'Notify': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					acquaint(docid, 896);
					return false;
				}
			
			}
		
		});
	}
	if ($.cookie("lang")=='RUS' || !$.cookie("lang")){
		$("#dialog-control").dialog({
			modal: true,
			height:140,
			width:400,
			buttons: {
				'Отмена': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					return false;
				},
				'Снять с контроля': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					controlOff(docid, page);
					return false;
				},
				'Уведомить': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					acquaint(docid, 896);
					return false;
				}
			
			}
		
		});
	}
	if ($.cookie("lang")=='KAZ'){
		$("#dialog-control").dialog({
			modal: true,
			height:140,
			width:400,
			buttons: {
				'Болдырмау': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					return false;
				},
				'Бақылаудан алу': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					controlOff(docid, page);
					return false;
				},
				'Ескерту': function() {
					$(this).dialog('close');
					$("#dialog-control").remove();
					acquaint(docid, 896);
					return false;
				}
			}
		});
	}
}

function controlOff(docid, page){
	enableblockform()
	$('body').css('cursor','wait');
	$("body").notify({"text":removedcaption,"onopen":function(){}})	
	$.ajax({
		type: "GET",
		datatype:"XML",
		url: "Provider",
		data: "type=page&id=controloff&key=" +docid+"&page="+page,
		success: function (msg){
			if ($(msg).find("response").attr("status") == "ok"){
				$("#notifydiv").html("<font>"+removedfromcontrol+"</font>")
				redirect = $(msg).find("redirect").text();
				 setTimeout(function() {
					 $("body").hidenotify({"delay":200,"onclose":function(){if (redirect == ''){window.history.back()}else{window.location = redirect;}}})
				 },250);
			}
			
		},
		error: function(data,status,xhr) {
			$('body').css('cursor','default');	
			$("body").hidenotify({"delay":800,"onclose":function(){$("#notifydiv").remove()}})
			infoDialog("Произошла ошибка при снятии с контроля")
			disableblockform();
		}
	})
}



function addTopicToForum (el, parentdocid, parentdoctype){
	var time=new Date();
	month=time.getMonth()+1;
	day=time.getDate();
	hours=time.getHours();
	minute=time.getMinutes();
	if (month< 10){month="0"+month;}
	if (day<10){day="0"+ time.getDate();}
	if (hours<10){hours="0"+time.getHours();}
	if (minute<10){minute="0"+time.getMinutes();}
	curdate=day +"."+ month + "." + time.getFullYear()+ " " + hours + ":" + minute ;
	if($("#topicform").length == 0){
		$("<div id='topicform' style='width:90%; height:90px; background:#E6E6E6; border:1px solid #ccc; margin-top:5px; display:none; margin-left:10px'><form id='topicfrm' action='Provider' name='topiccomment' method='post'  enctype='application/x-www-form-urlencoded'><input type='text' name='theme' id='topicvalue' style='margin:10px ; width:600px;'/><br/><button type='button' id='butformadd' onclick='sendtopic()' style='margin-left:10px' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'>Добавить</button><button id='butformcancel'  style='margin-left:10px' type='button' onclick='javascript:closecommentform()' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'>Отмена</button></form></div>").insertAfter($(el)).slideDown("fast");
		$("#topicfrm").append("<input type='hidden' name='type' value='save'/>")
		$("#topicfrm").append("<input type='hidden' name='id' value='topic'/>")
		$("#topicfrm").append("<input type='hidden' name='key' value=''/>")
		$("#topicfrm").append("<input type='hidden' name='formsesid' value='1340212408'/>")
		$("#topicfrm").append("<input type='hidden' name='parentdocid' value='"+ parentdocid +"'/>")
		$("#topicfrm").append("<input type='hidden' name='parentdoctype' value='" + parentdoctype +"'/>")
		$("#topicfrm").append("<input type='hidden' id='topicdate' name='topicdate' value='"+curdate+"'/>")
		$("#butformadd").button()
		$("#butformcancel").button()
	}
}

function sendtopic(){
	var formData = $("#topicfrm").serialize();
	$.ajax({
		type: "POST",
		url: 'Provider',
		data: $("#topicfrm").serialize(),
		success:function (xml){
			$("#topicform").slideUp("fast")
			$("<table style='width:100%'><tr><td><div display='block' style='display:block; width:90%' id='topic'><div id='headerTheme' style='width:100%; padding-left:10px'>"+$("#topicvalue").val()+"</div><div id='infoTheme' style='width:100%; padding-left:10px; padding-top:3px'>Автор: "+$("#username").val()+","+ $("#topicdate").val()+"</div><br/><div id='CountMsgTheme' style='color:#555555; padding:12px; background:#E6E6E6; border:1px solid #D3D3D3; margin-left:10px; border-radius: 5px 5px 0px 0px; height:20px; font-size: 13px; font-weight: 300; overflow: hidden;'></div><div id='msgWrapper' style='border:1px solid #DDE5ED; min-height:150px; margin-left:10px'></div><table id='topicTbl' style=' width:100%'/><br/></div></td></tr></table>").insertAfter($("#bordercomment"));
			$("#CountMsgTheme").append("Комментариев в теме: 0")
			$("#btnnewcomment span").html("<img class='button_img' src='/SharedResources/img/classic/icons/comment.png'><font style='font-size:12px; vertical-align:top'>Написать новый комментарий</font>")
			$("#btnnewcomment").attr("onclick","javascript:addCommentToForum(this,"+$(xml).find("message[id=2]").text()+",904)")
		},
		error:function (xhr, ajaxOptions, thrownError){
			if (xhr.status == 400){
				$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
				$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
				$("li[type='square'] > a").attr("href","javascript:backtocontent()")
			}
		}    
	});
}

function addCommentToForum (el, parentdocid, parentdoctype,isresp){
	var time=new Date();
	month=time.getMonth()+1;
	day=time.getDate();
	hours=time.getHours();
	minute=time.getMinutes();
	if (month< 10){month="0"+month;}
	if (day<10){day="0"+ time.getDate();}
	if (hours<10){hours="0"+time.getHours();}
	if (minute<10){minute="0"+time.getMinutes();}
	curdate=day +"."+ month + "." + time.getFullYear()+ " " + hours + ":" + minute ;
	if($("#commentform").length == 0){
		if (isresp){
			$("<div id='commentform' style='width:100%; height:160px; background:#E6E6E6; border:1px solid #ccc; margin-top:5px; display:none; '><form id='commentfrm' action='Provider' name='frmcomment' method='post'  enctype='application/x-www-form-urlencoded'><textarea name='contentsource' id='commentvalue' style='margin:10px ; width:97.5%; height:90px'></textarea><br/><button type='button' id='butformadd' onclick='sendcomment(true,el)' style='margin-left:10px' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'>Добавить</button><button id='butformcancel'  style='margin-left:10px' type='button' onclick='javascript:closecommentform()' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'>Отмена</button></form></div>").insertAfter($(el).parent().parent()).slideDown("fast");
		}else{
			$("<div id='commentform' style='width:90%; height:160px; background:#E6E6E6; border:1px solid #ccc; margin-top:5px; display:none; margin-left:10px'><form id='commentfrm' action='Provider' name='frmcomment' method='post'  enctype='application/x-www-form-urlencoded'><textarea name='contentsource' id='commentvalue' style='margin:10px ; width:97.5%; height:90px'></textarea><br/><button type='button' id='butformadd' onclick='sendcomment()' style='margin-left:10px' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'>Добавить</button><button id='butformcancel'  style='margin-left:10px' type='button' onclick='javascript:closecommentform()' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only'>Отмена</button></form></div>").insertAfter($(el)).slideDown("fast");
		}
		$("#commentfrm").append("<input type='hidden' name='type' value='save'/>")
		$("#commentfrm").append("<input type='hidden' name='id' value='comment'/>")
		$("#commentfrm").append("<input type='hidden' name='key' value=''/>")
		$("#commentfrm").append("<input type='hidden' name='parentdocid' value='"+ parentdocid +"'/>")
		$("#commentfrm").append("<input type='hidden' name='parentdoctype' value='" + parentdoctype +"'/>")
		$("#commentfrm").append("<input type='hidden' id='postdate' name='postdate' value='"+curdate+"'/>")
		$("#butformadd").button()
		$("#butformcancel").button()
	}
}

function closecommentform(){
	$("#commentform").slideUp("fast", function() {
		$("#commentform").remove();
	}); 
}

function sendcomment(resp){
	var formData = $("#commentfrm").serialize();
	$.ajax({
		type: "POST",
		url: 'Provider',
		data: $("#commentfrm").serialize(),
		success:function (xml){
				count = $(".msgEntry").length;
				if(resp){
					$('<div class="msgEntry" id="msgEntry'+ count  +'"/><div style="clear:both"/>').insertAfter($("#commentform"))
					$("#msgEntry"+count).width($("#msgEntry"+count).prev("div").prev("div").width() - 50)
					$("#msgEntry"+count).css("float","right")
				}else{
					$("#msgWrapper").append('<div class="msgEntry" id="msgEntry'+ count  +'"/>')
				}
				$("#msgEntry"+count).append('<div class="headermsg" id="headermsg'+ count +'"/>')
				$("#headermsg"+count).append('<div class="authormsg">'+$("#username").val()+'</div>')
				$("#headermsg"+count).append('<div class="msgdate">отправлено:'+$("#postdate").val()+'</div>')
				$("#msgEntry"+count).append('<div class="bodymsg" id="bodymsg'+ count +'">'+$("#commentvalue").val()+'</div>')
				$("#msgEntry"+count).append('<div class="buttonpanemsg" id="buttonpanemsg'+ count +'"/>')
				if(resp){
					$("#commentform").slideUp("fast", function() {
						i = count+1;
						$("#CountMsgTheme").html("Комментариев в теме:" + i)
						$("#commentform").remove();
						infoDialog("Комментарий успешно добавлен")
					}); 
				}else{
					$("#commentform").slideUp("fast", function() {
						i = count+1;
						$("#CountMsgTheme").html("Комментариев в теме:" + i)
						$("#commentform").remove();
						$("#docwrapper").animate({ scrollTop: $('#msgEntry'+count).position().top}, "slow",function() {
							infoDialog("Комментарий успешно добавлен")
						}); 
					}); 
				}
				
		},
		error:function (xhr, ajaxOptions, thrownError){
			if (xhr.status == 400){
				$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
				$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
				$("li[type='square'] > a").attr("href","javascript:backtocontent()")
			}
		}    
	});
}


function SuggestionContractor(){
	var availableTags = []
	$("#contractor").keyup(function(eventObject){
		if(eventObject.which != 37 && eventObject.which != 38 && eventObject.which != 39 && eventObject.which != 40 && eventObject.which != 13){
			availableTags.length = 0;
			if ($("#contractor").val().length > 3){
				$("#contractor").addClass("ui-autocomplete-loading")
				$("#tiptip_holder").css("display","none")
				$.ajax({
					url: 'Provider?type=query&id=contractor-sugg&page=1&keyword='+encodeURIComponent($("#contractor").val()),
					datatype:'xml',
					success: function(data){
						$(data).find("entry[doctype=894]").each(function(index, element){
							availableTags.push({label:$(element).attr("viewtext"), value:$(element).attr("viewtext"),id:$(element).attr("docid"),isbadperformer:$(element).find("isbadperformer").text()});
						});
					},
					complete:function(){
						$("#contractor").autocomplete({
							source: availableTags,
							select: function(event, ui){ 
								$("#contractorid").val(ui.item.id)
								$("#contractorviewtext").val(ui.item.value)
								if(ui.item.isbadperformer == "true"){
									if($(".notecontractor").html() == null){
										$("#contractor").after("<div class='notecontractor' style='padding:5px 0px 8px 5px; height:12px; display:inline-block'><font style='color:red; font-size:11px; vertical-align:bottom'>Недобросовестный исполнитель</font></div>");
									}
								}else{
									$(".notecontractor").remove()
								}
							}
						});
						$("#contractor").autocomplete("search" , $("#contractor").val())
					}
				});	
			}else{
				$("#tiptip_holder").css("display","block")
			}
		}
	});
}

function contractorFieldUpdate(){
	if ($("#contractor").val().length == 0 ){
		$("#contractorid ,#contractorviewtext").val('')
	}else{
		$("#contractor").val($("#contractorviewtext").val())
	}
}

function setValHiddenFields(el){
	$("[name=parentdocid]").val($(el).val());
}

function addSubCatGloss(el, lang, formId){	
	sp = formId.split("category");
	fieldNumber = sp[1];
	subcat = "#subcategory" + fieldNumber;
	$(subcat + " option").remove();
	if ($(el).val() != ''){	
		$.ajax({
			url: 'Provider?type=query&id=glossresponses&parentdocid='+el+'&parentdoctype=894',
			datatype:'xml',
			success: function(data) {				
				$(data).find("entry[doctype=894]").each(function(index, element){
					// viewtext содержит название на русском и на казахском. Разделенные ' / '
					textbylang = $(element).attr("viewtext").split("/*");	
					responsetext = ""; 
					if(lang == "KAZ")
						responsetext = textbylang[0];
					else
						responsetext = textbylang[1];
					
					$(subcat).append("<option value='"+ $(element).attr("id")+"'>"+ responsetext +"</option>")					  
				});
				if ($(subcat + " > option").length == 0){
					$(subcat).append("<option value=''> </option>")
				}
			}
		});	
	}
}

function openOriginPlaceExtra(){
	if($("#originplaceextra").css("display") == 'none'){
		$("#originplaceextra").slideDown("fast")
		$("#originplaceCaption").text("кратко").attr("title","Скрыть подробности проекта")
	}else{
		$("#originplaceextra").slideUp("fast");
		$("#originplaceCaption").text("подробнее").attr("title","Отобразить подробности проекта")
	}
}

function openProjectExtra(){
	if($("#projectextra").css("display") == 'none'){
		if($("select[name=project]").val() != ' ' && $("select[name=project]").val() != '' ){
			$.ajax({
				url: 'Provider?type=edit&element=glossary&id=projectsprav&key='+ $("select[name=project]").val() +'&onlyxml',
				datatype:'xml',
				success: function(data) {
					$(".tehnadzortr").remove()
					$("#rukproj").val($(data).find("projectmanager").text())
					$("#zamrukproj").val($(data).find("zamprojectmanager").text())
					$(data).find("techsupervision").find("entry").each(function(index, element){
						 if (index == 0){
							$("#projectextratable").append("<tr class='tehnadzortr'>"+
								"<td width='30%' class='fc'>Технический надзор :</td>" +
								"<td><input type='text' id='tehnadzor' size='10' class='td_noteditable' style='width:300px' value='"+ $(element).text()+"'/></td>" +
							"</tr>")
						 }else{
							 $("#projectextratable").append("<tr class='tehnadzortr'>"+
								"<td width='30%' class='fc'></td>" +
								"<td><input type='text' id='tehnadzor' size='10' class='td_noteditable' style='width:300px' value='"+ $(element).text()+"'/></td>" +
							"</tr>") 
						 }
					});
				}
			});	
			$("#projectextra").slideDown("fast")
			$("#projectCaption").text("кратко").attr("title","Скрыть подробности места возникновения замечания")
		}else{
			$("#projectextra").slideDown("fast")
			$("#projectCaption").text("кратко").attr("title","Скрыть подробности места возникновения замечания")
		}
	}else{
		$("#projectextra").slideUp("fast");
		$("#projectCaption").text("подробнее").attr("title","Отобразить подробности места возникновения замечания")
	}
}

function updateProjectExtra(){
	if($("select[name=project]").val() != ' ' && $("select[name=project]").val() != '' ){
		$.ajax({
			url: 'Provider?type=edit&element=glossary&id=projectsprav&key='+ $("select[name=project]").val() +'&onlyxml',
			datatype:'xml',
			success: function(data) {
				$(".tehnadzortr").remove()
				$("#rukproj").val($(data).find("projectmanager").text())
				$("#zamrukproj").val($(data).find("zamprojectmanager").text())
				$(data).find("techsupervision").find("entry").each(function(index, element){
					if (index == 0){
						$("#projectextratable").append("<tr class='tehnadzortr'>"+
								"<td width='30%' class='fc'>Технический надзор :</td>" +
								"<td><input type='text' id='tehnadzor' size='10' class='td_noteditable' style='width:300px' value='"+ $(element).text()+"'/></td>" +
						"</tr>")
					}else{
						$("#projectextratable").append("<tr class='tehnadzortr'>"+
								"<td width='30%' class='fc'></td>" +
								"<td><input type='text' id='tehnadzor' size='10' class='td_noteditable' style='width:300px' value='"+ $(element).text()+"'/></td>" +
						"</tr>") 
					}
				});
			}
		});	
	}else{
		$(".tehnadzortr").remove()
		$("#rukproj , #zamrukproj ").val('')
		//$("#zamrukproj").val('')
	}
}
	
function enabledChbox (name){
	$("input[name="+name+"]").attr("checked","true");
}

/* ограничение количества ввода символов в поле*/
function maxCountSymbols (el, count, e, warn){
	$(el).keypress(function (e) {
		if ($(el).val().length > count){
			if ((e.which == 8) ||  (e.which > 36 && e.which < 41) ) {
				if (e.which == 8 && $("#warntext").is(":visible")){
					$("#warntext").remove()
				}
			}else{
				if(!$("#warntext").is(":visible") && warn==true){
					$(el).parent().append("<font id='warntext' style='color:red; font-size:11px; margin-left:5px; line-height:20px'>Длина поля не должна превышать "+count+" символов</font>")
				}
				return false
			}
		}
	});
}

/*проверка выбранного формата файла отчета*/
function reportsTypeCheck (el){
	if($(el).val() == 2){
		$("input[type=radio][name=disposition][value=inline]").attr("disabled","disabled")
		$("input[type=radio][name=disposition][value=attachment]").attr("checked","checked")
	} else{
		$("input[type=radio][name=disposition][value=inline]").removeAttr("disabled")
	}
}


function composeReport(id){
	var reportComp = "для формирования отчета. Продолжить?";
	var found = "Найдено ";
	var rep = " записей";
	var bOK = "Да";
	var bNO = "Нет";
	var title = "Уведомление"
	if(lang == "KAZ"){
		found = "Есептемені құрастыру үшін ";
		rep = " жазба табылды.";	
		reportComp = " Жалғастыру керек пе?";
		title = "Ескерту";	
	}
	
	var fields = $('form').serializeArray();
	var formData = $("form").serialize();
	var recursiveEncoded = $.param(fields);
	 
	var count = "";
	// пока проверяем кол. записей отчетов 30 и 31
	if(rid == 'report31' || rid == "report30"){
		$.ajax({
				type: "POST",
				url: 'Provider?type=handler&id=RecordsCount&'+recursiveEncoded,
				datatype:"xml",
				success: function(xml){
					count = $(xml).find("count").text()
					$("<div/>",{id: "dialog-message",title: "Отчет"}).appendTo("body");
					$("<div style='margin:15px 0 0 0px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+found 
							+ "<b>"+count+"</b>" + rep + reportComp+ "</font></div>").appendTo("#dialog-message");
					
					$("#dialog").dialog("destroy");
					$("#dialog-message").dialog({modal: false, height:200, title:title});
					 
					if(count == "0" || count == ""){
						$("#dialog-message").dialog({ 
							buttons: { 							
								"No":function() {
									$("#dialog-message").remove();
									$('#blockWindow').remove(); 
								}
							},
							beforeClose: function() { 
								$("#dialog-message").remove();
								$('#blockWindow').remove(); 
							} 
						});
					}else{
						$("#dialog-message").dialog({ 
							buttons: { 
								"Yes": function() {
									$("#dialog-message").remove();
									$('#blockWindow').remove(); 
									// хендлер для формирования отчетов
									window.location.href = 'Provider?type=handler&id='+id+'&'+recursiveEncoded;
								},
								"No":function() {
									$("#dialog-message").remove();
									$('#blockWindow').remove(); 
								}
							},
							beforeClose: function() { 
								$("#dialog-message").remove();
								$('#blockWindow').remove(); 
							} 
						});
					}
				}
		})
	}else{
		window.location.href = 'Provider?type=handler&id='+id+'&'+recursiveEncoded;
	}
}

/* кнопка "назад"*/
function CancelForm(url) {
	if (url != null && url.length !=0 ){
		window.location.href=url
	}else{
		window.history.back()
	}
}

function fieldOnFocus(field) {
	field.style.backgroundColor = '#FFFFE4';
}

function fieldOnBlur(field) {
	field.style.backgroundColor = '#FFFFFF';
}

function numericfield(el) {
	$(el).keypress(function (e) {
		if ((e.which < 48) || (e.which > 57) ) {
			if( (e.which == 8 || e.which == 13 ) ){
				if ($(el).val().length == 1){
					$("#tiptip_holder").css("display","block")
				}
			}else{
				$("#tiptip_holder").css("display","block")
				return false
			}
		}else{
			$("#tiptip_holder").css("display","none")
		}
	});
}


function addExecutorField(pos,execid){
	if (pos==1){
		$("#frm").append("<input type='hidden' id='controlres"+pos+"' name='executor' value='"+ execid +"`1`0`` '/>");
	}else{
		$("#frm").append("<input type='hidden' id='controlres"+pos+"' name='executor' value='"+ execid +"`0`0`` '/>");
	}
}

/* функция поставить на контроль*/
function controlOn(pos){
	$("#idCorrControlOff"+pos +" ,#controlOffDate"+pos).text(""); 
	$("#switchControl"+pos).html("<a title='Снять с контроля' href='javascript:controlOff("+pos+")'><img  src='/SharedResources/img/classic/icons/eye_delete.png'/></a>");
	$("#controlres"+pos).val($("#idContrExec"+pos).text()+"` ` ");
}

function infoDialog(text){
	if ($.cookie("lang")=="RUS" || !$.cookie("lang"))
		divhtml ="<div id='dialog-message' title='Предупреждение'>";
	else if ( $.cookie("lang")=="KAZ")
		divhtml ="<div id='dialog-message' title='Ескерту'>";
	else if ( $.cookie("lang")=="ENG")
		divhtml ="<div id='dialog-message' title='Warning'>";
	 divhtml+="<span style='height:40px; width:100%; text-align:center;'>"+
	 	"<font style='font-size:13px;'>"+text+"</font>"+"</span>";
	 divhtml += "</div>";
	 $("body").append(divhtml);
	 $("#dialog").dialog("destroy");
	 $("#dialog-message").dialog({
		 modal: true,
		 buttons: {
			 "Ок": function() {
				 $(this).dialog("close").remove();
			 }
		 }
	 });
	 $(".ui-dialog button").focus();
}


function dialogAndFunction(text,func, name, par){
	title = "Предупреждение";
	if ($.cookie("lang")=="ENG")
		title = "Warning";
	else if ($.cookie("lang")=="KAZ")
		title = "Ескерту";
	divhtml ="<div id='dialog-message' title='"+title+"'>";
	divhtml +="<span style='text-align:center;'>"+
		"<font style='font-size:13px;'>"+text+"</font></span></div>";
	$("body").append(divhtml);
	$("#dialog-message").dialog("destroy");
	$("#dialog-message").dialog({
		modal: true,
		buttons: {
			"Ок": function() {
				func && typeof(func) === "function" ? func() : $(this).dialog("close").remove();
			}
		},
		beforeClose: function() { 
			func && typeof(func) === "function" ? func() : $(this).dialog("close").remove();
		}
	});
}
 
function dialogConfirmComment (text,action){
	divhtml ="<div id='dialog-message' title='"+warning+"'>";
	divhtml +="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	"<font style='font-size:13px;'>"+text+"</font>"+"</span>";
	divhtml += "</div>";
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	$("#dialog-message").dialog({
		height:140,
		modal:true,
		buttons:{
			"да": function(){
				$(this).dialog("close").remove();
		    	addComment()
			},
			"нет": function(){
				$(this).dialog("close").remove();
				submitFormDecision()
			}
		}
	});
	if (lang == "KAZ"){
		$("#dialog-message").dialog({ buttons: { 
			"иә": function() { 
					$(this).dialog("close").remove();
					addComment()
				},
			"жоқ": function() { 
					$(this).dialog("close").remove();
					submitFormDecision()
				}
			}
		});
	}
	if (lang == "ENG"){
		$("#dialog-message").dialog({buttons: { 
			"yes": function() { 
				$(this).dialog("close").remove();
				addComment()
			},
			"no": function() { 
				$(this).dialog("close").remove();
				submitFormDecision()
			}
		}
		});
	}
	if (lang == "CHN"){
		$("#dialog-message").dialog({ buttons: { 
			"是否": function(){ 
				$(this).dialog( "close" );
				$(this).remove();
				addComment()
			},
			"無": function() { 
				$(this).dialog( "close" );
				$(this).remove();
				submitFormDecision ()
			}
		}
		});
	}
}

var control_sum_file = null; 

function addCommentToAttach(csf){
	if (csf){
		control_sum_file = csf;
	}
	divhtml="<div class='comment' id='commentBox'>" +
	"<div class='headerComment'><font class='headertext'>"+commentcaption+"</font>" +
		"<div class='closeButton'  onclick='commentCancel(); '>" +
			"<img style='width:15px; height:15px; margin-left:3px; margin-top:2px' src='/SharedResources/img/iconset/cross.png' />" +
		"</div></div>" +
	"<div class='contentComment'>" +
		"<br/><table style=' margin-top:2%; width:100%'>" +
			"<tr>" +
				"<td style='text-align:center'><textarea name='commentText' id='commentText' rows='10' tabindex='1' style='width:97%' />" +
				"</td>" +
			"</tr>" +
		"</table><br/>" +
	"</div>"+
	"<div class='buttonPaneComment button_panel' style='margin-top:1%; text-align:right; width:98%'>" +
	"<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:commentToAttachOk()' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" +
	"<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:commentCancel()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>" +
	"</div>" +
	"</div>";
	$("body").append(divhtml);
	$("#commentBox").draggable({handle:"div.headerComment"});
	centring('commentBox',470,250);
	$("#commentBox textarea").focus()
}

function dialogConfirm (text,el,actionEl){
   divhtml ="<div id='dialog-message' title='Предупреждение'>";
   divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
   "<font style='font-size:13px; '>"+text+"</font>"+"</span>";
   divhtml += "</div>";
   $("body").append(divhtml);
   $("#dialog").dialog("destroy");
   $("#dialog-message").dialog({
	   height:140,
	   modal: true,
	   buttons: {
		   "Ок": function() {
			   $(this).dialog("close").remove();
			   if (el == 'picklist'){
				   $('#blockWindow').css('display',"block")
			   }
			   $("#"+el).css("display", "inline-block");
			   $("."+actionEl).remove();
		   },
		   "Отмена": function() {
			   $(this).dialog("close").remove();
			   if (el == 'picklist'){
				   $('#blockWindow').remove()
			   }
			   $('#'+el).empty().remove();
		   }
	   }
   });
}

/* сохранение формы */
function SaveFormJquery(typeForm, formName, redirecturl, docType) {
	enableblockform()
    if($("input[name=id]").val() == "article" && document.getElementsByTagName("iframe")[0]){
        $("textarea[name=briefcontent]").val(document.getElementsByTagName("iframe")[0].contentDocument.getElementsByTagName("body")[0].innerHTML)
    }
	$("body").notify({"text":pleasewaitdocsave,"onopen":function(){}})
	if ($.cookie("lang")=="RUS" || !$.cookie("lang"))
		divhtml ="<div id='dialog-message' title='Сохранение'/>";
	else if ($.cookie("lang")=="ENG")
		divhtml ="<div id='dialog-message' title='Saving'/>";
	else if ($.cookie("lang")=="KAZ")
		divhtml ="<div id='dialog-message' title='Сақталу'/>";
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	$.ajax({
		type: "POST",
		url: 'Provider',
		data: $("form").serialize(),
		success:function (xml){ 
			$(document).unbind("keydown")
			redir = $(xml).find("redirect").text();
			if (redir == ""){ redir = redirecturl;}
			if (redir == ""){ redir = redirectAfterSave}
			$(xml).find('response').each(function(){
				var st=$(this).attr('status');
				msgtext=$(xml).find('message[id=1]').text();
				if (st =="error" || st =="undefined"){
					if (msgtext.length == 0 && ($.cookie("lang")=="RUS" || !$.cookie("lang"))){ msgtext = "Ошибка сохранения"}
					else if (msgtext.length == 0 && $.cookie("lang")=="KAZ"){ msgtext = "Сақталу қателігі"}
					else if (msgtext.length == 0 && $.cookie("lang")=="ENG"){ msgtext = "Error saving"}
					$("#notifydiv").html("<font>"+msgtext+"</font>")
					$("body").hidenotify({"delay":800,"onclose":function(){$("#notifydiv").remove()}})
					$("#dialog-message").dialog({ 
						buttons: { 
							Ok: function() {
								$("#dialog-message").remove();
								disableblockform();
								hotkeysnav() 
							}
						},
						beforeClose: function() { 
							$("#dialog-message").remove();
							disableblockform();
							hotkeysnav() 
						} 
					});
					$("#dialog-message").html("<div style='text-align:center'><font>"+msgtext+"</font></div>");
				}
				if (st == "ok"){
					$("body").css("cursor","wait");
					if (msgtext.length==0){
						$("#notifydiv").html("<font>"+documentsavedcaption+"</font>")
						setTimeout(function() {
							$("body").hidenotify({"delay":200,"onclose":function(){window.location = redir;}})
						},250);
					}else{
						$("#notifydiv").html("<font>"+msgtext+"</font>")
						setTimeout(function() {
							$("body").hidenotify({"delay":300,"onclose":function(){}})
						},800);
						$("#dialog-message").dialog({ 
							buttons: { 
								Ok: function() {
									$("#dialog-message").remove();
									window.location = redir;
									disableblockform();
								}
							},
							beforeClose: function() { 
								$("#dialog-message").remove();
								window.location = redir;
								disableblockform();
							}  
						});
						$("#dialog-message").html("<br/><div style='text-align:center'><font>"+msgtext+"</font></div>");
						$(".ui-dialog button").focus();
					}
				}
			});
		},
		error:function (xhr, ajaxOptions, thrownError){
			if (xhr.status == 400){
				$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
				$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
				$("li[type='square'] > a").attr("href","javascript:backtocontent()")
			}
		}    
	});
}

/*set of upload function*/
function loadingAttch(tableID){
	$("#"+tableID).append("<tr id='loading_attach'><td></td><td><div style='position:absolute; z-index:999'><img src='/SharedResources/img/classic/progress_bar_attach.gif'></div></td></tr>")
	blockWindow = "<div class='blockWindow' id='blockWindow'></div>"; 
	$("body").append(blockWindow).css("cursor","wait");
	$('#blockWindow').css('width',$(document).width()).css('height',$(document).height()).css('display',"block");
}

/* добавление приложений в форму */
function submitFile(form, tableID, fieldName) {
	if ($('input[name='+fieldName+']').val() == '' || $('input[name='+fieldName+']').val() == 'undefined' ) {
		infoDialog(showfilename);
	}else{
		$("#progressbar").progressbar({value:0});
		$("#progressstate").css("display","block")
		form = $('#'+form);
		var frame = createIFrame();
		frame.onSendComplete = function() {
			uploadComplete(tableID, getIFrameXML(frame));
			$("#loading_attach , #loadingpage , #blockWindow").remove();
			$("body").css("cursor","default")
		};
		form.attr('target', frame.id);
		form.submit();
		//$("#upload")[0].reset();
		//form.reset();
	}
}

var req;

function ajaxFunction(){
	var url = "Uploader";
	if (window.XMLHttpRequest){ // Non-IE browsers
		req = new XMLHttpRequest();
		req.onreadystatechange = processStateChange;
		try{
			req.open("GET", url, true);
		} 
		catch(e){
			alert(e);
		}
		req.send(null);
	}else if (window.ActiveXObject){ // IE Browsers
		req = new ActiveXObject("Microsoft.XMLHTTP");
		if (req){
			req.onreadystatechange = processStateChange;
			req.open("GET", url, true);
			req.send();
		}
	}
}

function processStateChange(){
	/**
	 *	State	Description
	 *	0		The request is not initialized
	 *	1		The request has been set up
	 *	2		The request has been sent
	 *	3		The request is in process
	 *	4		The request is complete
	 */
	if (req.readyState == 4){
		if (req.status == 200){ // OK response
			$("#loading_attach_img").css("visibility","visible")
			$("#btnsavedoc").attr("disabled","disabled").addClass("ui-state-disabled")
			var xml = req.responseXML;
			var isNotFinished = $(xml).find("finished")[0];
			var myBytesRead = $(xml).find("bytes_read")[0];
			var myContentLength = $(xml).find("content_length")[0];
			var myPercent = $(xml).find("percent_complete")[0];
			if ((isNotFinished == null) && (myPercent == null)){
				$("#initializing").css("visibility","visible")
				window.setTimeout("ajaxFunction();", 200);
			}else{
				$("#initializing").css("visibility","hidden")
				$("#readybytes").css("visibility","visible")
				$("#percentready").css("visibility","visible")
				myBytesRead = myBytesRead.firstChild.data;
				myContentLength = myContentLength.firstChild.data;
				 
				if (myPercent != null){ // It's started, get the status of the upload
					myPercent = myPercent.firstChild.data;
					$("#progressbar").progressbar( "option", "value",parseInt(myPercent) );
					kbread = parseInt(myBytesRead)/1024;
					kbContentLength = parseInt(myContentLength)/1024;
					$("#readybytes").html(Math.round(kbread * 100 ) / 100  + " из " + Math.round(kbContentLength * 100 ) / 100   + " Кбайт загружено")
					$("#percentready").html(myPercent + "%")
					window.setTimeout("ajaxFunction();", 100);
				}else{
					$("#btnsavedoc").removeAttr("disabled").removeClass("ui-state-disabled")
					kbContentLength = parseInt(myContentLength)/1024;
					$("#readybytes").html(Math.round(kbContentLength * 100 ) / 100   + " из " + Math.round(kbContentLength * 100 ) / 100   + " Кбайт загружено")
					$("#percentready").html("готово")
					$("#loading_attach_img").css("visibility","hidden")
					$("#progressbar").progressbar( "option", "value", 100 );
				}
			}
		}else{
			alert(req.statusText);
		}
	}
}

function createIFrame() {
	var id = 'f' + Math.floor(Math.random() * 99999);
	var divHTML = '<div><iframe style="display:none" src="about:blank" id="' + id
			+ '" name="' + id + '" onload="sendComplete(\'' + id
			+ '\')"></iframe></div>';
	$("body").append(divHTML);
	return document.getElementById(id);
}

function sendComplete(id) {
	var iframe = document.getElementById(id);
	if (iframe.onSendComplete && typeof (iframe.onSendComplete) == 'function')
		iframe.onSendComplete();
}

function getIFrameXML(iframe) {
	var doc = iframe.contentDocument;
	if (!doc && iframe.contentWindow)
		doc = iframe.contentWindow.document;
	if (!doc)
		doc = window.frames[iframe.id].document;
	if (!doc)
		return null;
	if (doc.location == "about:blank")
		return null;
	if (doc.XMLDocument)
		doc = doc.XMLDocument;
	return doc;
}

var cnt = 0;
function uploadComplete(tableID, doc) {
	if (!doc)
		return;
	var xmldoc = doc.documentElement,
		st = xmldoc.getAttribute('status'),
		msg = xmldoc.getElementsByTagName('BODY'),
		fileName= $('input[name=fname]')[0].files[0].name;
	if (st == 'ok'){
		tableid='#'+tableID;
		var table = $(tableid);
		sesid=$(doc).find("message").attr('formsesid');
		csf=$(doc).find("message[id=2]").text();
		var range = 200 - 1 + 1;
		if(fileName.indexOf(".") != -1){
			detectExtAttach(fileName); //определение расширения
			fieldid=Math.floor(Math.random()*range) + 1;
			fileid=$(doc).find("message[id=4]").text();
            filehash=$(doc).find("message[id=2]").text();
            fileNameEcr=fileName.replace(/\%/g, "%25").replace(/\+/g, "%2b");// убираем знак '+' из ссылок
			$(table).append("<tr id='"+ csf + "'>" +
					'<td><input type="hidden" name="filename" value="'+fileName+'"/><input type="hidden" name="fileid" value="'+fileid+'"/><input type="hidden" name="filehash" value="'+filehash+'"/></td>' +
					"<td>" +
					"<img class='newimageatt' onerror='javascript:changeAttIcon(this)' onload='$(this).removeClass()' src='/SharedResources/img/iconset/file_extension_"+ ext +".png' style='margin-right:5px'><a href='Provider?type=getattach&formsesid="+ sesid+"&field=rtfcontent&key="+fileid+"&doctype=896&id=rtfcontent&file="+fileNameEcr+"' style='vertical-align:6px'>"+ fileName +"</a>&#xA0;&#xA0;" +
					"<a href='javascript:addCommentToAttach(&quot;"+ csf +"&quot;)' style='vertical-align:5px; '>"+
			"<img id='commentaddimg"+csf+"' src='/SharedResources/img/classic/icons/comment_add.png' style='width:12px; height:12px' title='"+addcomment+"'/></a>"+
			"<a href='javascript:deleterow(&quot;"+sesid +"&quot;,&quot;"+ fileNameEcr +"&quot;,&quot;"+ csf +"&quot;)'><img src='/SharedResources/img/iconset/cross.png' style='margin-left:5px; width:10px; height:10px; vertical-align:6px'  title='"+delete_file+"'/></a>" +
			"</td><td></td</tr>");
			$("input[name=deletertfcontentname]").each(function(index, element){
				if($(element).val() == d){
					$(element).remove()
				}
			});
			if ($("input[name=deletertfcontentname]").length == 0){
				$("input[name=deletertfcontentsesid], input[name=deletertfcontentfield]").remove()
			}
			$("#progressbar").progressbar("destroy");
			$("#progressstate").css("display","none");
			ConfirmCommentToAttach(addcommentforattachment,csf)
		}else{
			$("#progressbar").progressbar("destroy");
			infoDialog('Произошла ошибка на сервере при выгрузке файла');
		}
	}else{
		infoDialog('Произошла ошибка на сервере при выгрузке файла');
	}
	$("#upload")[0].reset();
}


function changeAttIcon(el){
	$(el).attr("src","/SharedResources/img/iconset/file_extension_undefined.png").removeClass();
}

/*определение расширения вложения */
function detectExtAttach(file){
	var fileLen=file.length;
	var symbol;
	while(symbol !='.' || fileLen == 0){
		symbol=(file.substring(fileLen-1,fileLen));
		fileLen = fileLen - 1;
	}
	RegEx=/\s/g;
	ext=file.substring(fileLen +1, file.length).replace(RegEx, "").toLowerCase();
	return ext;
}

var control_sum_file = null; 
function ConfirmCommentToAttach (text,csf){
	control_sum_file = csf;
	divhtml ="<div id='dialog-message' title='"+attention+"'>";
	divhtml +="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	"<font style='font-size:13px;'>"+text+"</font>"+"</span>";
	divhtml += "</div>";
	
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	if ($.cookie("lang") =="RUS" || $.cookie("lang") == null){
		$("#dialog-message").dialog({
			height:140,
			modal: true,
			buttons:{
				"да": function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
					$("#progressbar").progressbar("destroy");
					$("#progressstate").css("display","none");
				},
				"нет": function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
					$("#progressbar").progressbar("destroy");
					$("#progressstate").css("display","none");
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
			} 
		});
	}
	else if($.cookie("lang")=="ENG"){
		$("#dialog-message").dialog({
			height:140,
			modal: true,
			buttons:{
				"yes": function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
					$("#progressbar").progressbar("destroy");
					$("#progressstate").css("display","none");
				},
				"no": function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
					$("#progressbar").progressbar("destroy");
					$("#progressstate").css("display","none");
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
			} 
		});
	}
	else if ($.cookie("lang")=="KAZ"){
		$("#dialog-message").dialog({
			height:140,
			modal: true,
			buttons:{
				"иә": function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
					$("#progressbar").progressbar("destroy");
					$("#progressstate").css("display","none");
				},
				"жоқ": function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
					$("#progressbar").progressbar("destroy");
					$("#progressstate").css("display","none");
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
			} 
		});
	}
}

function addCommentToAttach(csf){
	if (csf){
		control_sum_file = csf;
	}
	divhtml="<div class='comment' id='commentBox'>" +
	"<div class='headerComment'><font class='headertext'>"+commentcaption+"</font>" +
		"<div class='closeButton'  onclick='commentCancel(); '>" +
			"<img style='width:15px; height:15px; margin-left:3px; margin-top:2px' src='/SharedResources/img/iconset/cross.png' />" +
		"</div></div>" +
	"<div class='contentComment'>" +
		"<br/><table style=' margin-top:2%; width:100%'>" +
			"<tr>" +
				"<td style='text-align:center'><textarea  name='commentText' id='commentText' rows='10'  tabindex='1' style='width:97%' />" +
				"</td>" +
			"</tr>" +
		"</table><br/>" +
	"</div>"+
	"<div class='buttonPaneComment button_panel' style='margin-top:1%; text-align:right; width:98%'>" +
	"<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:commentToAttachOk()' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" +
	"<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:commentCancel()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>" +
	"</div>" +
	"</div>";
	$("body").append(divhtml);
	$("#commentBox").draggable({handle:"div.headerComment"});
	centring('commentBox',470,250);
	$("#commentBox textarea").focus()
}

function commentToAttachOk(){
	if ($("#commentText").val().length ==0){
		if($.cookie("lang")=="RUS" || !$.cookie("lang"))
			infoDialog("Введите комментарий");
		else if($.cookie("lang")=="KAZ")
			infoDialog("Түсініктеме қосыңыз");
		else if($.cookie("lang")=="ENG")
			infoDialog("Please add your comment");
		
		
	}else{
		$("#frm").append("<input type='hidden' name='comment"+control_sum_file+"' value='"+ $("#commentText").val() +"'>")
		if($.cookie("lang")=="RUS" || !$.cookie("lang"))
			$("<tr><td></td><td style='color:#777; font-size:12px'>комментарий : "+$("#commentText").val()+"</td><td></td></tr>").insertAfter("#"+control_sum_file)
		else if($.cookie("lang")=="KAZ")
			$("<tr><td></td><td style='color:#777; font-size:12px'>түсініктеме : "+$("#commentText").val()+"</td><td></td></tr>").insertAfter("#"+control_sum_file)
		else if($.cookie("lang")=="ENG")
			$("<tr><td></td><td style='color:#777; font-size:12px'>comments: "+$("#commentText").val()+"</td><td></td></tr>").insertAfter("#"+control_sum_file)
		$("#commentaddimg"+control_sum_file).remove()
		$("#commentBox").remove()
	}
}


/* создание  cookie для сохранения настроек пользователя и сохранение профиля пользователя*/
function saveUserProfile(redirecturl){
	enableblockform()
	$(document).unbind("keydown")
	if ($("#newpwd").val() != $("#newpwd2").val()){
		 infoDialog("Введеные пароли не совпадают")
	}else{
		$.ajax({
			type: "POST",
			url: "Provider?type=save&element=user_profile",
			datatype:"html",
			data: $("form").serialize(),
			success: function(xml){
				redir = $(xml).find('redirect').text();
				if (redir == ""){
					redir = $(xml).find('history').find("entry[type=page]:last").text()
				}
				$.cookie("lang", $("select[name='lang']").val(),{ path:"/", expires:30});	
				$.cookie("refresh", $("select[name='refresh']").val(),{ path:"/", expires:30});		
				if (redir == '' ){
					window.history.back();
				}else{
					window.location = redir;
				}
			},
			error:function (xhr, ajaxOptions, thrownError){
	           if (xhr.status == 400){
	        	  if( xhr.responseText.indexOf("Old password has not match")!=-1){
	        		  infoDialog("Некорректно заполнено поле 'пароль по умолчанию'")
	        	  }else{
	        		  $("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
	        		  $("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
	        		  $("li[type='square'] > a").attr("href","javascript:backtocontent()")
	        	  }
	           }
	        }    
		});
	}
}

function backtocontent(){
	$('#doerrorcontent').css('display','block'); 
	$('#errordata').remove();
}

/*функция о отметке о прочтении документа*/
function markRead(doctype, docid){
	$.ajax({
		type: "GET",
		url: "Provider?type=service&operation=mark_as_read&doctype="+doctype+"&key="+docid+"&nocache="+Math.random(),
		success:function (xml){
			$("#whichreadblock").fadeIn(5000);
			$("#markDocRead").animate({backgroundColor: '#ffff99'}, 500);
			
			$("#markDocRead").html("&#xA0; "+read);
			$("#markDocRead").animate({backgroundColor: '#ffffdd'}, 1000);
		}
	});
}

function deleterow(sesid,filename, fieldid){
	$("#progressbar").progressbar("destroy");
	$("#progressstate").hide();
	$("#"+fieldid).next("tr").remove()
	$("#"+fieldid).remove()
	$("#frm").append("<input type='hidden' name='deletertfcontentsesid' value='"+ sesid +"'/>")
	$("#frm").append("<input type='hidden' name='deletertfcontentname' value='"+ filename +"'/>")
	$("#frm").append("<input type='hidden' name='deletertfcontentfield' value='rtfcontent'/>")
}

var el;
var UrlDecoder = {
		encode : function (string) {
			return escape(this._utf8_encode(string));
		},
		decode : function (string) {
			return this._utf8_decode(unescape(string));
		},
		_utf8_encode : function (string) {
			string = string.replace(/\r\n/g,"\n");
				var utftext = "";
				for (var n = 0; n < string.length; n++) {
					var c = string.charCodeAt(n);
					if (c < 128) {
						utftext += String.fromCharCode(c);
					}
					else if((c > 127) && (c < 2048)) {
					 utftext += String.fromCharCode((c >> 6) | 192);
					 utftext += String.fromCharCode((c & 63) | 128);
					}
					else {
						utftext += String.fromCharCode((c >> 12) | 224);
						utftext += String.fromCharCode(((c >> 6) & 63) | 128);
						utftext += String.fromCharCode((c & 63) | 128);
					}
				}
				return utftext;
			},
			_utf8_decode : function (utftext) {
				var string = "";
				var i = 0;
				var c = c1 = c2 = 0;
				while ( i < utftext.length ) {
					c = utftext.charCodeAt(i);
					if (c < 128) {
						string += String.fromCharCode(c);
						i++;
					}
					else if((c > 191) && (c < 224)) {
						c2 = utftext.charCodeAt(i+1);
						string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
						i += 2;
					}
					else {
						c2 = utftext.charCodeAt(i+1);
						c3 = utftext.charCodeAt(i+2);
						string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
						i += 3;
					}
				}
				string=string.substring(0, string.length )
				return string;
			}
}

/* функция напомнить*/
function remind(key,doctype){
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' class='headertext'></font>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose(); '/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:6%; margin-left:81%'></div>";
	divhtml +="<div id='divSearch' display='block'><div style='font-size:13px; text-align:left; margin-left:2%'>"+receiverslistcaption+":</div></div>" ;
	divhtml +="<div id='contentpane' style='overflow:auto;  border:1px solid  #d3d3d3; padding-top:10px; width:95%; margin:10px; height:250px;' >Загрузка данных...</div>"; 
	divhtml +="<div id='divComment' style='text-align:left; margin:10px; font-size:13px; width:95%'><table width='100%'><tr><td style='font-size:13px;'>"+commentcaption+" : </td></tr><tr><td><textarea id='comment'  rows='6' style='border:1px solid #a6c9e2;width:100%; margin-top:8px'></textarea></td></tr></table></div>"
	divhtml += "<div  id = 'btnpane' class='button_panel' style='margin:2%; text-align:right;'>";
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:remindOk("+key+","+doctype+")' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" 
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='pickListClose()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div  class='ui-widget-overlay' id ='blockWindow'></div>"; 
	$("body").append(blockWindow);
	$("body").css("cursor","wait");
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$('#picklist').css('display', "none");
	$("#headertext").text(remindcaption);
	$("#contentpane").text('');
	$("#contentpane").html($("#executers").html());
	$("#contentpane table").css("text-align","left")
	$('#picklist').css('display', "inline-block");
	$("body").css("cursor","default")
	$('#picklist').focus();
}

/* обработчик нажатия кнопки "ок" a окне "напомнить"*/	
function remindOk(key,doctype){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	if ($("#comment").val().length == 0){
		infoDialog ("Поле 'Комментарий' не заполнено")
	}else{
		for( var i = 0; i < chBoxes.length; i ++ ){
			if (chBoxes[i].checked){ 
				if (k==0){
					form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
					$("body").append(form);
				}
				new FormData('notifyrecipients', chBoxes[i].id); 
				k++		 	
			}
		}
		if (k>0){
			new FormData('type', 'handler'); 
			new FormData('id', "notify_executors"); 
			new FormData('key', key);
			new FormData('doctype', doctype);
			new FormData('comment', $("#comment").val());
			submitFormDecision ()
			pickListClose(); 
		}else{
			infoDialog('Выберите значение');
		}
	}
}

/* функция ознакомить*/
function acquaint(key,doctype){
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' class='headertext'></font>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose();'/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:10px; margin-left:78%'>";
	divhtml +="<a id='btnChangeView' class='actionlink' href='javascript:changeViewAcquaint(1,"+key+","+doctype+")'><font style='font-size:11px'>"+changeviewcaption+"</font></a></div>";
	divhtml +="<div id='divSearch' class='divSearch' display='inline-block'></div>" ;
	divhtml +="<div style='font-size:13px; text-align:left; margin-top:10px;margin-left:8px'>&#xA0;&#xA0;Список корреспондентов для ознакомления:</div>" ;
	divhtml +="<div id='contentpane' style='overflow:auto; border:1px solid  #d3d3d3; height:250px; width:95%; margin:10px;' >Загрузка данных...</div>";    
	divhtml += "<div  id = 'btnpane' class='button_panel' style='margin-top:2%; text-align:right; margin:2%'>";
	divhtml += "<button class='btnFilter' onclick='javascript:acquaintOk("+key+","+doctype+")' style='margin-right:5px'><font style='font-size:12px; vertical-align:top'>ОК</font></button>"; 
	divhtml += "<button class='btnFilter' onclick='pickListClose()'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></button>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow).css("cursor","wait");
	$('#blockWindow').css('width',$(document).width()).css('height',$(document).height()).css('display',"block"); 
	$('#picklist').css('display', "none");
	$("#headertext").text(acquaintcaption);
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=executers',
		success:function (data){
			$("#contentpane").text("").append(data);
			searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font> <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>";
			$("#contentpane div").removeAttr("ondblclick").removeAttr("onmouseover").removeAttr("onmouseout");		
			$("#divSearch").append(searchTbl);
			$("#btnChangeView").attr("href","javascript:changeViewAcquaint(2,"+key+","+doctype+")");
			$('#picklist').css('display', "inline-block");
			$("body").css("cursor","default")
			$('#contentpane').disableSelection();		
			$('#searchCor').focus()
			$(".btnFilter").button();
		}
	});
}

/* обработчик нажатия кнопки "ок" a окне "ознакомить"*/	
function acquaintOk(key,doctype){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	for( var i = 0; i < chBoxes.length; i ++ ){
		if (chBoxes[i].checked){ 
			if (k==0){
				form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
				$("body").append(form);
			}
			new FormData('recipients', chBoxes[i].id); 
			k++		 	
		}
	}
	if (k>0){
		new FormData('type', 'page'); 
		new FormData('id', "new_revision_notification"); 
		new FormData('key', key);
		new FormData('doctype', doctype); 
		enableblockform()
		$('body').css('cursor','wait');
		$("body").notify({"text":removedcaption,"onopen":function(){}})	
		submitFormDecision("new_revision_notification")
		pickListClose(); 
	}else{
		infoDialog('Выберите значение');
	}
}

/* смена вида в окне "ознакомить"*/
function changeViewAcquaint(viewType,key,doctype){
	if (viewType==1){
		$.ajax({
			type: "get",
			url: 'Provider?type=view&id=bossandemppicklist',
			success:function (data){
				$("#contentpane").text("").append(data);
				searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font>";
				searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
				$("#divSearch").append(searchTbl);
				$('#btnChangeView').attr("href","javascript:changeViewAcquaint(2,"+key+","+doctype+")");
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display', "inline-block");
				$('#searchCor').focus()
				$("#contentpane").ajaxSuccess(function(evt, request, settings){
					$("#contentpane div").removeAttr("ondblclick").removeAttr("onmouseover").removeAttr("onmouseout");
				});
			}
		});
	}else{
		$('#btnChangeView').attr("href","javascript:changeViewAcquaint(1,"+key+","+doctype+")");
		$.ajax({
			type: "get",
			url: 'Provider?type=view&id=structure',
			success:function (data){
				if(data.match("html")){
					window.location="Provider?type=static&id=start"
				}
				$("#contentpane").text("").append(data);
				$("#divSearch").empty();
				// запрещаем выделение текста
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display', "inline-block");
				$("#contentpane").ajaxSuccess(function(evt, request, settings){
					$("#contentpane td").removeAttr("ondblclick").removeAttr("onmouseover").removeAttr("onmouseout").removeAttr("onmouseout")
				});
			}
		});
	}
}

/* функция для отображения списка прочитавших текущий документ */
function usersWhichRead(el,doctype, id){
	notEmpty = false;
	var ce = $(el);
	var left_offset_position = ce.offset().left ; 
	var bottom_offset_position = ce.offset().top +35; 
	$.ajax({
		type: "get",
		url: 'Provider?type=service&operation=users_which_read&doctype='+doctype+"&key="+id,
		success:function (xml){
			if (!$("#userWhichRead").length){
				$("body").append("<div id='userWhichRead' class='userwichread'></div>");
			}else{
				return false;
			}
			$(xml).find("entry").each(function(){
				if ($(this).attr('username') != undefined){
					$("#userWhichRead").append("&#xA0;"+$(this).attr('username')+ "&#xA0;&#xA0; "+$(this).attr('eventtime')+ "&#xA0;</br>");
					notEmpty = true; 
				}
			})
			if (notEmpty == true){
				$("#userWhichRead").css("right","20px").css("top",bottom_offset_position).css("display","inline-block");
			}else{
				$("#userWhichRead").remove();
			}
		}
	})
}


function usersWhichReadInTable(el,doctype, id){
	$.ajax({
		type: "get",
		async:true,
		url: 'Provider?type=service&operation=users_which_read&doctype='+doctype+"&key="+id+"&nocache="+Math.random() * 300,
		success:function (xml){
			$(xml).find("entry").each(function(){
				if ($(this).attr('username') != undefined && $("#userswhichreadtbl td:contains('"+ $(this).attr('username') +"')").length == 0 ){
					$("#userswhichreadtbl").append("<tr><td>"+$(this).attr('username')+ "</td><td>"+$(this).attr('eventtime')+ "</td></tr>");
				}
			})
		}
	})
}

function checkImage(el){
	if ($(el).width() > $("#property").width() - $(".fc").first().width()-50 ){
		$(el).css("width",$("#property").width() - $(".fc").first().width()-50 + "px")
		$(el).parent("div").css("width",$("#property").width() - $(".fc").first().width()-10 + "px")
	}
}

function integerwithdot(el){  
	str = $(el).val().substr(0, $(el).val().length-1)
	str1 = $(el).val().substr(0, $(el).val().length);
	$(el).keypress(function (e) {
		if( e.which == 46 && str.indexOf('.') == -1){
			if(str1.indexOf('.') == -1)
				return true;		
		}
		if ((e.which < 48) || (e.which > 57)) {
			if( (e.which != 8) ){
				return false
			}
		}
	});
}

var fieldCounter = 1;
var formsList = "";
var _data ="";

function AddFields(formname, parent_doctype, parent_docid, newdivid){	
	remove_text = "";
	if(lang == 'KAZ')
		remove_text = "Алып тастау"
	else
		remove_text = "Убрать";
		
	if(formname == 'animals' || formname == 'farmSownArea'){
		$.ajax({
			url: 'Provider?type=document&id='+formname+'&key=&parentdocid='+parent_docid+'&parentdoctype='+parent_doctype+'&page=0',
			datatype:"html",
			success: function(data){
				$("#"+newdivid).append("<form action='Provider' enctype='application/x-www-form-urlencoded' method ='post' name='frm" 
						+ fieldCounter+"' id='frm" +fieldCounter+"'></form>");
				$("#frm" + fieldCounter).append(data);	
				$("#frm" + fieldCounter + " #category").attr("id", "category" + fieldCounter);
				$("#frm" + fieldCounter + " #subcategory").attr("id", "subcategory" + fieldCounter);
				$("#"+newdivid).append('<div id ="extradiv' +fieldCounter +'" style="margin: -98px 0 0 1050px"><button title="'+remove_text+'" onclick="RemoveField('+fieldCounter+')" id="removefield' + fieldCounter +'"> <span><img src="/SharedResources/img/classic/icons/delete.png" height="15px" /></span></button><div style="margin-top: 90px" /></div>');
				$("#"+newdivid).append('');
				formsList += fieldCounter + "*";
				fieldCounter ++;
			},
			error:function (xhr, ajaxOptions, thrownError){
	          
	        }    
		});
	}
	else if(formname == 'familyMember'){	
		$.ajax({
			url: 'Provider?type=document&id='+formname+'&key=&parentdocid='+parent_docid+'&parentdoctype='+parent_doctype+'&page=0',
			datatype:"html",
			success: function(data){
				$("#"+newdivid).append("<form action='Provider' enctype='application/x-www-form-urlencoded' method ='post' name='frm" 
						+ fieldCounter+"' id='frm" +fieldCounter+"'></form>");
				$("#frm" + fieldCounter).append(data);					
				$("#frm" + fieldCounter + " #membertable").attr("id", "membertablefrm" + fieldCounter);
				$("#frm" + fieldCounter + " #member").attr("id", "memberfrm" + fieldCounter);
				$("#frm" + fieldCounter + " #memberid").attr("id", "memberidfrm" + fieldCounter);
				$("#"+newdivid).append('<div id ="extradiv' +fieldCounter +'" style="margin: -65px 0 0 1100px"><button title="'+remove_text+'" onclick="RemoveField('+fieldCounter+')" id="removefield' + fieldCounter +'"> <span><img src="/SharedResources/img/classic/icons/delete.png" height="15px" /></span></button><div style="margin-top: 90px" /></div>');
				$("#"+newdivid).append('');
				$("#frm" + fieldCounter + " #memberChoose").attr("href", "javascript:dialogBoxStructure('indivpersonlist','false','member','frm"+fieldCounter+"', 'membertablefrm"+fieldCounter+"')");
				formsList += fieldCounter + "*";
				fieldCounter ++;
			},
			error:function (xhr, ajaxOptions, thrownError){
	          
	        }    
		});
	}
	else if(formname == 'militaryJob' || formname == 'militaryTraining'){
		$.ajax({
			url: 'Provider?type=document&id='+formname+'&key=&parentdocid='+parent_docid+'&parentdoctype='+parent_doctype+'&page=0',
			datatype:"html",
			success: function(data){
				$("#"+newdivid).append("<form action='Provider' enctype='application/x-www-form-urlencoded' method ='post' name='frm" 
						+ fieldCounter+"' id='frm" +fieldCounter+"'></form>");
				$("#frm" + fieldCounter).append(data);	
				$("#"+newdivid).append('<div id ="extradiv' +fieldCounter +'" style="margin: -98px 0 0 1050px"><button title="'+remove_text+'" onclick="RemoveField('+fieldCounter+')" id="removefield' + fieldCounter +'"> <span><img src="/SharedResources/img/classic/icons/delete.png" height="15px" /></span></button><div style="margin-top: 90px" /></div>');
				$("#"+newdivid).append('');
				formsList += fieldCounter + "*";
				fieldCounter ++;
			},
			error:function (xhr, ajaxOptions, thrownError){
	          
	        }    
		});
	}
	else if(formname == 'farmland' || formname == 'farmtech'){
		$.ajax({ 
			url: 'Provider?type=document&id='+formname+'&key=&parentdocid='+parent_docid+'&parentdoctype='+parent_doctype+'&page=0',
			datatype:"html",
			success: function(data){
				$("#"+newdivid).append("<form action='Provider' enctype='application/x-www-form-urlencoded' method ='post' name='frm" 
						+ fieldCounter+"' id='frm" +fieldCounter+"'></form>");
				$("#frm" + fieldCounter).append(data);	
				$("#"+newdivid).append('<div id ="extradiv' +fieldCounter +'" style="margin: -98px 0 0 1050px"><button title="'+remove_text+'" onclick="RemoveField('+fieldCounter+')" id="removefield' + fieldCounter +'"> <span><img src="/SharedResources/img/classic/icons/delete.png" height="15px" /></span></button><div style="margin-top: 90px" /></div>');
				$("#"+newdivid).append('');
				formsList += fieldCounter + "*";
				fieldCounter ++;
			},
			error:function (xhr, ajaxOptions, thrownError){
	          
	        }    
		});
	}else{
		$.ajax({ 
			url: 'Provider?type=document&id='+formname+'&key=&parentdocid='+parent_docid+'&parentdoctype='+parent_doctype+'&page=0',
			datatype:"html",
			success: function(data){
				$("#"+newdivid).append("<form action='Provider' enctype='application/x-www-form-urlencoded' method ='post' name='frm" 
						+ fieldCounter+"' id='frm" +fieldCounter+"'></form>");
				$("#frm" + fieldCounter).append(data);	
				$("#"+newdivid).append('<div id ="extradiv' +fieldCounter +'" style="margin: -98px 0 0 1050px"><button title="'+remove_text+'" onclick="RemoveField('+fieldCounter+')" id="removefield' + fieldCounter +'"> <span><img src="/SharedResources/img/classic/icons/delete.png" height="15px" /></span></button><div style="margin-top: 90px" /></div>');
				$("#"+newdivid).append('');
				formsList += fieldCounter + "*";
				fieldCounter ++;
			},
			error:function (xhr, ajaxOptions, thrownError){
	          
	        }    
		});
		
	}
}

function SaveMultipleForms(typeForm, formName, redirecturl, docType){
	arr = formsList.split("*");
	_msgtext1 = "";
	_msqtext2 = "";
	if(lang == 'KAZ')
	{
		_msgtext1 = "Өтінеміз күте тұрыңыз";
		_msgtext2 = "құжат сақталу үстінде";
	}else{
		_msgtext1 = "Пожалуйста ждите...";
		_msgtext2 = "идет сохранение документа";
	}
	enableblockform()
	divhtml ="<div id='dialog-message' title='Сохранение'>";
	divhtml+="<div style='margin-top:8px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+_msgtext1+"</font></div>";
	divhtml+="<div style='margin-top:5px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+_msgtext2+"</font></div>";
	divhtml+="<br/><div style='margin-top:5px; text-align:center;'><font style='font-size:14px; font-family:arial; padding-left:10px;'><img src='/SharedResources/img/classic/loading.gif'/></font></div>";
	divhtml+="</div>";
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	if(lang == 'KAZ'){
		$("#dialog-message").dialog({
			modal: false,
			height:200,
			title:"Ескерту"
		});
	}else{
		$("#dialog-message").dialog({
			modal: false,
			height:200,
			title:"Уведомление"
		});
	}
	var findex = 0;
	for(var i=0; i<arr.length; i++){				
		var formData = $("#frm" + findex).serialize();		
		$.ajax({
			type: "POST",
			url: 'Provider',
			data: $("#frm" + findex).serialize(),
			success:function (xml){ 
				redir = $(xml).find('history').find("entry[type=view]:last").text();
				if (redir == ''){
					redir = redirecturl;
				}
				if (redir == ""){
					redir = redirectAfterSave
				}
				$(xml).find('response').each(function(){
					var st=$(this).attr('status');
					msgtext=$(xml).find('message').text();
					if (st =="error" || st =="undefined"){
						$("#dialog-message").dialog({ 
							buttons: { 
								Ok: function() {
									$("#dialog-message").remove();
									disableblockform();
								}
							},
							beforeClose: function() { 
								$("#dialog-message").remove();
								disableblockform();
							} 
						});
						msgtext = msgtext || "Ошибка сохранения"								
						$("#dialog-message").html("<br/><div style='text-align:center'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+msgtext+"</font></div>");
					}
					if (st == "ok"){
						$("#dialog-message").dialog({ 
							buttons: { 
								Ok: function() {
									$("#dialog-message").remove();
									if (redir == ''){
										window.history.back();
									}else{
										window.location = redir;
									}
									disableblockform();
								}
							},
							beforeClose: function() { 
								$("#dialog-message").remove();
								if (redir == ''){
									window.history.back();
								}else{
									window.location = redir;
								}
								disableblockform();
							}  
						});
						if(lang == 'KAZ'){
							msgtext = msgtext || "Құжат сақталды";
						}else{
							msgtext = msgtext || "Документ сохранен";
						}
						$("#dialog-message").html("<br/><div style='text-align:center'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+msgtext+"</font></div>");
						
					}
					$(".ui-dialog button").focus();
				});
			},
			error:function (xhr, ajaxOptions, thrownError){
				if (xhr.status == 400){
					
					$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
					$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
					$("li[type='square'] > a").attr("href","javascript:backtocontent()")
				}
			}    
		});
		findex = arr[i];
	}
}

function beforeSaveMultipleForms(){
	arr = formsList.split("*");
	for(var i = 0; i < arr.length-1; i++)
	{
		$("#frm"+arr[i] + " #parentdocid").val($("#frm0 #key").val());	
		$("#frm"+arr[i] + " #parentdoctype").val($("#frm0 #doctype").val());	
		alert($("#frm"+arr[i] + " #parentdocid").val())
		alert(arr[i])
	}
}

function RemoveField(fieldNumber){
	$("#frm"+fieldNumber).remove();
	$("#extradiv" + fieldNumber).remove();
	arr = formsList.split("*");
	var index = arr.indexOf(fieldNumber.toString());
	arr.splice(index, 1);
	formsList= "";
	for(var i = 0; i < arr.length; i++)
		if(arr[i] != "")
			formsList += arr[i] + "*";
}


function importData(){
	var filePath = $("#filePath").val()	 
	$("#process").append("<span id='importProcess' style='position:absolute; z-index:999'>"+processInfo+"<br/><img  src='/SharedResources/img/classic/progress_bar_attach.gif'></span>")
	blockWindow = "<div  class = 'blockWindow' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$("body").css("cursor","wait")
	if(filePath != ""){
		$.ajax({
			type: "GET",
			datatype:"XML",
			url: "Provider",
			data: "type=handler&id=import_from_vm&filePath="+filePath,
			success: function (msg){			  
				$('#blockWindow').remove()
				$("#importProcess").remove();
				$("body").css("cursor","pointer")
				var region = $(msg).find("region").text().split("/*");	
				var sv = "";
				if(lang == "KAZ")
					sv = region[0]
				else
					sv = region[1]
				var result = $(msg).find('entry[type=result]').text();
				 
				if(result == "wrongFile"){
					infoDialog(wrongFileSelected);
				}else
					infoDialog(successImport + "<br/>"+ region_text + ": "+ sv);
			},
			error: function(data,status,xhr) {
				infoDialog(errorInFileRead);
				$('#blockWindow').remove()
				$("#importProcess").remove();
				$("body").css("cursor","pointer")
			}
		});	
	}else{
		infoDialog(selectFile);	
		$('#blockWindow').remove()
		$("#importProcess").remove();
		$("body").css("cursor","pointer")
	}
}

function AddSubFormFields(formname, parent_doctype, parent_docid, newdivid, ddbid){
	remove_text = "";
	if(lang == 'KAZ')
		remove_text = "Алып тастау"
	else
		remove_text = "Убрать";
	var arr_name = [];
	var arr_id = [];
	if(lang == "KAZ")
		t = "namekaz";
	else
		t = "name"
	// вызываем хендлер
	$.ajax({
		type: "GET",
		datatype: "xml",
		url: "Provider",
		data: "type=handler&id=subAnimals&ddbid="+ddbid+"&docid=" + parent_docid,
		success: function(msg){
			$(msg).find("document").each(function(index, el){	
				arr_name[index] = $(el).find(t).text()				
				arr_id[index] = $(el).attr("id")				 
			})
			$.ajax({ 
				url: 'Provider?type=document&id='+formname+'&key=&parentdocid='+parent_docid+'&parentdoctype='+parent_doctype+'&page=0',
				datatype:"html",
				success: function(data){			
					$("#"+newdivid).append("<form action='Provider' enctype='application/x-www-form-urlencoded' method ='post' name='frm" 
							+ fieldCounter+"' id='frm" +fieldCounter+"'></form>");
					//n = $(data).find("select [name='subcategory']").html()
					s = ""
					for(i=0; i <arr_name.length; i++){
						s+= "<option value='"+arr_id[i]+"'>"+ arr_name[i] +"</option>"	
					}
					//$("#frm" + fieldCounter).append(s);	
					$("#frm" + fieldCounter).append(data);	
					//$("#subcategory").id = "subcategory" + fieldCounter;
					//if(($("select[name=subcategory]")).id == 'subcategory')
						($("#subcategory")).attr("id", "subcategory" + fieldCounter)
					$("#subcategory" + fieldCounter).append(s)
					$("#"+newdivid).append('<div id ="extradiv' +fieldCounter +'" style="margin: -98px 0 0 1050px"><button title="'+remove_text+'" onclick="RemoveField('+fieldCounter+')" id="removefield' + fieldCounter +'"> <span><img src="/SharedResources/img/classic/icons/delete.png" height="15px" /></span></button><div style="margin-top: 90px" /></div>');
					$("#"+newdivid).append('');
					formsList += fieldCounter + "*";
					fieldCounter ++;					
				},
				error:function (xhr, ajaxOptions, thrownError){
		          
		        }    
			});
			
		},error: function(data,status,xhr){
			
		}
	});
}


/* функция для вычисления срока исполнения */
function changeCtrlDate(priority, complication){
	$.ajax({
		type: "GET",
		url: "Provider?type=page&id=getctrldate&priority=" + priority + "&complication=" + complication,
		success:function (xml){			  
			 $('#ctrldate').val($(xml).find("ctrldate").text())
			 $('#remained_days').val($(xml).find("daydiff").text())
		}
	});
}

/*  загрузка хода исполнения  КР*/ 
function showExecution(parentid,parentdoctype,id){
	if(id == '') return;
	$.ajax({
		url: 'Provider?type=view&id=docthread&parentdocid='+parentid+'&parentdoctype='+parentdoctype,
		success: function(data) { 			
			data = data.replace(/--&gt;/g, "<img src='/SharedResources/img/classic/arrow_blue.gif'/>");
			$("#executionTbl").append("<tr"+data.split('<tr')[1]);
		}
	});
}

function showProgressBlock(){
	$("#executionTbl").css('display','block');
	$("#executionTbl").fadeIn(5000)
	$("#progress").attr("onclick","javascript:hideProgressBlock()")
}

function hideProgressBlock(){
	$("#executionTbl").css('display','none');
	$("#progress").attr("onclick","javascript:showProgressBlock()")
}

function checkURL(_url){ 
	$.ajax({
		type: "get",
		url: "Provider?type=page&id=checkURL&url=" + _url,
		datatype: "xml",
		success: function(data){ 
			_valid = $(data).find("text").text()			 
			if(_valid == 'false'){
				$("#load-img").html('<img src="/SharedResources/img/classic/red.gif" width="10px"  />');
			}else if(_valid == 'true')
				$("#load-img").html('<a target="blank" title="Перейти" href="'+_url+'"><img src="/SharedResources/img/classic/icons/world_go.png" /></a>');
		}
	})
}

function CheckingURL(){
	$("#load-img").html('<img src="/SharedResources/img/classic/ajax-loader.gif" width="16px" />')
}

function revokeDemand(docid, doctype){	 
	var hl = "revokeDemand";
	if ($.cookie("lang") == "RUS" || !$.cookie("lang")){
		divhtml = "<div id='dialog-revoke' title='Отменить заявку'>";
		divhtml += "<div style='height:200px; width:98%; font-size:14px;'>";
		divhtml += "Причина:<div style='height:10px'/>"; 
	}
	else if($.cookie("lang")=="ENG"){
		divhtml = "<div id='dialog-revoke' title='Cancel demand'>";
		divhtml += "<div style='height:200px;width:98%; font-size:14px;'>";
		divhtml += "Reason:"; 
		}
	else if ($.cookie("lang")=="KAZ"){
		divhtml = "<div id='dialog-revoke' title='Тапсырысты болдырмау'>";
		divhtml += "<div style='height:200px;width:98%; font-size:14px;'>";
		divhtml += "Себебі:"; 
		}
	$.ajax({
		type: "GET",
		datatype:"xml",
		url: "Provider",
		data: "type=page&id=getDocsList&form=demand_revoke_reason&doctype=894",
		success: function (msg){
			// alert($(msg).text())
			$(msg).find('text').each(function(i, el){
				var id = $(el).text().split("#`")[0]
				var vt = $(el).text().split("#`")[1]
				divhtml += '<div style="margin-left:10px"><label for="'+id+'"><input type="radio" name="revoke_reason" value="'+id+'" id="'+id+'"';
				if(i == 0)
					divhtml += 'checked = "checked"'
				divhtml += '>'+vt+'</radio></label></div>'				 
			})
			divhtml += "</div>";
			$("body").append(divhtml);
		
		if ($.cookie("lang") == "RUS" || !$.cookie("lang")){
			$("#dialog-revoke").dialog({
				modal: true, 
				width:450,
				buttons: {			
					'Ок': function() {
						$(this).dialog('close');
						revokeDemandOK(docid, doctype, $("input[name='revoke_reason']:checked").val());
						return false;
					},'Отмена': function() {
						$(this).dialog('close');
						$("#dialog-revoke").remove();
						return false;
					}
				}
			});
		}
		else if ($.cookie("lang")=="ENG"){
			$("#dialog-revoke").dialog({
				modal: true, 
				width:400,
				buttons: {			
					'OK': function() {
						$(this).dialog('close');
						revokeDemandOK(docid, doctype, $("input[name='revoke_reason']:checked").val());
						return false;
					},'Cancel': function() {
						$(this).dialog('close');
						$("#dialog-revoke").remove();
						return false;
					}
				}
			});
		}
		else if ($.cookie("lang")=="KAZ"){
			$("#dialog-revoke").dialog({
				modal: true, 
				width:400,
				buttons: {			
					'Ок': function() {
						$(this).dialog('close');
						revokeDemandOK(docid, doctype, $("input[name='revoke_reason']:checked").val());
						return false;
					},'Болдырмау': function() {
						$(this).dialog('close');
						$("#dialog-revoke").remove();
						return false;
					}
				}
			});
		}

		},
		error: function(data,status,xhr) {
		}
	});
}

function revokeDemandOK(docid, doctype, reasonID){
	if(reasonID == "" || reasonID == "undefined"){
		alert(reason_canceldemand)	
	}
	$("#dialog-revoke").remove();
	changeCustomField("status","notActual");
	changeCustomField("revoke_demand_reason_id",reasonID);
	SaveFormJquery('frm','frm','')
}


function extendDemand(docid, doctype){	 
	var hl = "extendDemand";
	if ($.cookie("lang") == "RUS" || !$.cookie("lang")){
		divhtml = "<div id='dialog-extend' title='Продлить заявку'>";
		divhtml += "<div style='height:200px; width:98%; font-size:14px;'>";
		divhtml += "Причина:<div style='height:10px'/>"; 
	}
	else if($.cookie("lang")=="ENG"){
		divhtml = "<div id='dialog-extend' title='Extend demand'>";
		divhtml += "<div style='height:200px;width:98%; font-size:14px;'>";
		divhtml += "Reason:"; 
		}
	else if ($.cookie("lang")=="KAZ"){
		divhtml = "<div id='dialog-extend' title='Тапсырыстың мерзімін ұзарту'>";
		divhtml += "<div style='height:200px;width:98%; font-size:14px;'>";
		divhtml += "Себебі:"; 
		}
	$.ajax({
		type: "GET",
		datatype:"xml",
		url: "Provider",
		data: "type=page&id=getDocsList&form=demand_extend_reason&doctype=894",
		success: function (msg){
			// alert($(msg).text())
			$(msg).find('text').each(function(i, el){
				var id = $(el).text().split("#`")[0]
				var vt = $(el).text().split("#`")[1]
				divhtml += '<div style="margin-left:10px"><label for="'+id+'"><input type="radio" name="extend_reason" value="'+id+'" id="'+id+'"';
				if(i == 0)
					divhtml += 'checked = "checked"'
				divhtml += '>'+vt+'</radio></label></div>'				 
			})
			
			divhtml+="</br>";
			if ($.cookie("lang") == "RUS" || !$.cookie("lang"))
				divhtml+="Количество дней: ";
			else if($.cookie("lang")=="ENG")
				divhtml+="Number of days: ";
			else if ($.cookie("lang")=="KAZ")
				divhtml+="Күндер саны: ";
			divhtml += "<select id='test' name='numofdays'>" +
						"<option value='1'>1</option>" +
						"<option value='2'>2</option>" +
						"<option value='3'>3</option>" +
						"<option value='4'>4</option>" +
						"<option value='5'>5</option>" +
						"</select></div>";
			$("body").append(divhtml);
		
		if ($.cookie("lang") == "RUS" || !$.cookie("lang")){
			$("#dialog-extend").dialog({
				modal: true, 
				width:450,
				buttons: {			
					'Ок': function() {
						$(this).dialog('close');
						extendDemandOK(docid, doctype, $("input[name='extend_reason']:checked").val());
						return false;
					},'Отмена': function() {
						$(this).dialog('close');
						$("#dialog-extend").remove();
						return false;
					}
				}
			});
		}
		else if ($.cookie("lang")=="ENG"){
			$("#dialog-extend").dialog({
				modal: true, 
				width:400,
				buttons: {			
					'OK': function() {
						$(this).dialog('close');
						extendDemandOK(docid, doctype, $("input[name='extend_reason']:checked").val());
						return false;
					},'Cancel': function() {
						$(this).dialog('close');
						$("#dialog-extend").remove();
						return false;
					}
				}
			});
		}
		else if ($.cookie("lang")=="KAZ"){
			$("#dialog-extend").dialog({
				modal: true, 
				width:400,
				buttons: {			
					'Ок': function() {
						$(this).dialog('close');
						extendDemandOK(docid, doctype, $("input[name='extend_reason']:checked").val());
						return false;
					},'Болдырмау': function() {
						$(this).dialog('close');
						$("#dialog-extend").remove();
						return false;
					}
				}
			});
		}

		},
		error: function(data,status,xhr) {
		}
	});
}


function extendDemandOK(docid, doctype, reasonID){
	n=$("select[name=numofdays] option:selected").val();
	$("#frm").append("<input type='hidden' name='extend_demand_days' value='"+n+"'/>")
	$("#frm").append("<input type='hidden' name='extend_demand_reason_id' value='"+reasonID+"'/>")
	$("#dialog-extend").remove();
	SaveFormJquery('frm','frm','')
}
