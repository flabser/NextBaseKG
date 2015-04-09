var idtr="";
var count=0; //переменная для подсчета количесива блоков согласования
var contributorscoord='Участники согласования'
var	type='Тип'
var	parcoord='Параллельное'
var	sercoord='Последовательное'
var	waittime='Время ожидания'
var	coordparam='Параметры согласования'
var	hours ='Часов'
var	answercommentcaption ='Оставить комментарий ответа?'
var	warning ='Предупреждение'
var	docissign ='Документ подписан'
var	docisrejected ='Документ отклонен'
var	dociscoordyou ='Документ согласован вами'
var	docisrejectedyou ='Документ отклонен вами'
var choosemember ="Выберите участников согласования";
var nochosenblocktodelete="Не выбран блок согласования для удаления";
var successfullydeleted ="Успешно удалено"
var hourss = "часа"
var day = "день"
var days = "дней"
var unlimited ="Неограничено";
var newcoord ="Новое согласование";
var choosesigner="Поле 'Кем будет подписан' не заполнено";
var commentcaption = "Комментарий"; 
var entercomment = "Введите комментарий";
var buttonyes="Да";
var buttonno="Нет";
var button_saveandclose="Сохранить и закрыть";
var button_close="Закрыть";
var button_cancel="Отмена";

 /* функция создания формы для блоков согласования */
function hideDialog(){
	$("#coordParam").css("display","none").remove();
	$('#blockWindow').remove();
}

function addCoord(){
	enableblockform()
	el="coordParam";
	divhtml="<div class='picklistCoord' id='coordParam' onkeyUp='keyDown(el);'>" +
	"<div class='headerBoxCoord' style='width:100%'>" +
		"<font class='headertext'>"+coordparam+"</font>" +
		"<div class='closeButton' onclick='hideDialog();'>" +
			"<img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose();'/>" +
		"</div>" +
	"</div>" +
	"<div class='contentCoord'>" +
		"<div style='width:98%; display:inline-block; margin-top:3%'>" +
			"<table width='99%' style='align:left; font-size:13px'>" +
				"<tr>" +
					"<td><b style='font-size:13px'>"+type+":</b></td>" +
					"<td style='text-align:left; font-size:13px'><input type='radio' name='typeCoord' value='par'>"+parcoord+"</input></td>" +
					"<td><b style='font-size:13px'>"+waittime+":</b>" +
						"<select name='waitTime'>" 
							+"<option value='0'>0</option>" 
							+"<option value='3'>3 "+hourss+"</option>" 
							+"<option value='7'>7 "+hours+"</option>" 
							+"<option value='24'>1 "+day+"</option>" 
							+"<option value='48'>2 "+days+"</option>" 
							+"<option value='72'>3 "+days+"</option>" 
							+"<option value='96'>4 "+days+"</option>" 
							+"<option value='120'>5 "+days+"</option>" 
							+"<option value='144'>6 "+days+"</option>"
							+"<option value='168'>7 "+days+"</option>"
							+"</select></div>" +
						"</td>" +
					"</tr>" +
					"<tr>" +
						"<td/>" +
						"<td style='text-align:left; font-size:13px'><input type='radio' name='typeCoord' value='ser' checked='true'>"+sercoord+"</input></td>" +
						"<td/>"+
					"</tr>" +
				"</table>" +
			"</div>" +
			"<table style='margin-top:3%; width:100%'>" +
				"<tr>" +
					"<td style='text-align:left'><b style='font-size:13px'>"+contributorscoord+":</b></td>" +
					"<td/>" +
				"</tr>" +
		"</table>" +
		"<table style='margin-top:5px; width:100%'>" +
			"<tr>" +
				"<td style='text-align:left'><font style='vertical-align:5px;'><b style='font-size:13px'>"+searchcaption+":</b></font> <input type='text' id='searchCor' size='34' onKeyUp='findCorCoord()'/></td>" +
				"<td></td>" +
			"</tr>" +
		"</table>" +
		"<table width='98%' height='65%' style='margin-top:1%'><tr><td width='45%'>" +
			"<div id='contentdiv' style='overflow:auto; border:1px solid #d3d3d3; width:100%; display:inline-block; height:305px;'>" +
			"</div></td>" +
			"<td width='4%'><div style='display:inline-block; height:100%;'>" +
				"<table style='font-size:2em; position:relative; top:35%; left:5%'>" +
					"<tr><td><a style='text-decoration:none' href='javascript:plusCoordinator()'><img src='/SharedResources/img/classic/arrow_right.gif'/></a><td></tr>" +
				"<tr><td><a style='text-decoration:none' href='javascript:minusCoordinator()'><img src='/SharedResources/img/classic/arrow_left.gif'/></a><td></tr>" +
				"</table>" +
		"</div></td>"+
			"<td width='45%'><div id='coorderToBlock' style='overflow:auto; border:1px solid #d3d3d3; width:100%; height:305px; display:inline-block;'>" +
				"<table width='100%' id='coordertbl'/>" +
			"</div></td></tr></table>" +
		"</div><div style='clear:both'/>" +
		"<div class='buttonPane button_panel' id='btnpane' style='width:100%;'>" +
			"<span style='float:right; margin-right:11px; margin-top:3px; margin-bottom:14px'>" +
			"<button onclick='coordOk()' style='margin-right:5px'><font class='button_text'>ОК</font></button>" +
			"<button onclick='hideDialog()'><font class='button_text'>"+cancelcaption+"</font></button>" +
			"</a></span>" +
		"</div>"+
	"</div>";
	$("body").append(divhtml);
	$("#coordParam #btnpane span").children("button").button();
	picklistCoordinators()
	$("#coordParam").draggable({handle:"div.headerBoxCoord"});
	centring('coordParam',500,650); // (id окна, высота окна, ширина окна)
}

/* функция создания блока согласования */
function coordOk(){
	var coorderID="",
		brConstr="",
		nameCoorder = $("#coorderToBlock .chbox").map(function(el){ return this.id; }).get().join("^"),
		waitTimeVal=$("select[name=waitTime]").val(), // время ожидания согласования
		typeCoordVal=$("input[name=typeCoord]:checked").val(); // тип согласования
	/* получение списка id согласователей*/ 
	if ($("#coorderToBlock").text().length == 0){
		infoDialog(choosemember);
	}else{
		$("#coorderToBlock .chbox").each(function(){
			brConstr += "<br/>";
			coorderID+="<input type='hidden' class='"+this.id+"' value='"+this.id+"'/>"
		})
		/* нумерация блоков согласования */	
		countTR=$("#coordTableView tr").length;
		/* построение строки для отображения блоков согласования в форме */
		tdCheckbox="<td style='border-bottom: 1px solid lightgray'><input type='checkbox' name='chbox' id='"+countTR+"'>"+brConstr+"</td>";
		tdNum="<td style='text-align:center; border-bottom: 1px solid lightgray'>"+countTR+""+brConstr+"</td>";
		tdTypeCoord="<td style='text-align:center; border-bottom:1px solid lightgray'>"
		typeCoordVal == "ser" ? tdTypeCoord += sercoord : tdTypeCoord += parcoord+brConstr;
		tdTypeCoord += brConstr+"</td>"
		tdCoorderName="<td style='border-bottom: 1px solid lightgray'>";
		$("#coorderToBlock div").each(function(){
			tdCoorderName+="<font style='margin-top:10%'>"+$(this).text()+"</font><br/>"
		})
		tdCoorderName+="</td>";
		tdWaitTime="<td style='text-align:center; border-bottom:1px solid lightgray'>";
		waitTimeVal==0 ? tdWaitTime += unlimited : tdWaitTime += waitTimeVal+" "+hours;
		tdWaitTime += brConstr+"</td>";
		hiddenField="<input type='hidden' name='coordblock' value='new`"+ typeCoordVal+"`"+ waitTimeVal +"`"+nameCoorder +"'/>"; // построение скрытого поля для отправки параметров блока согласования на сервер
		tdStatus="<td style='text-align:center; border-bottom:1px solid lightgray'>"+newcoord+hiddenField+coorderID+""+brConstr+"</td>";
		trTableViewCoord="<tr id='"+countTR+"' class='trblockCoord'>"+tdCheckbox+tdNum+tdTypeCoord+tdCoorderName+tdWaitTime+tdStatus+"</tr>";
		$("#coordTableView").append(trTableViewCoord);
		hideDialog();
	}
}

/* удаление блоков согласования*/
function delCoord(){
	$("input[name='chbox']:checked").each(function(){
		$(this).closest("tr").remove();
		infoDialog(successfullydeleted);
	})
	$("#allchbox").removeAttr("checked");
	if($("input[name='chbox']:checked").length == 0){
		infoDialog(nochosenblocktodelete);
	} 
}

 /* функция закрытия формы создания блоков согласования */
function coordParamClose(){
	$('#coordParam, #blockWindow').remove();
}

 /* кнопка "Сохранить как черновик" */
function savePrjAsDraft(redirecturl){
	$('#coordstatus, #action').val('draft');
    SaveFormJquery()		
}

/* кнопка "Отправить" */
function saveAndSend(redirecturl){
	if($("#coordBlockSign").val()==null || $("#coordBlockSign").val()==0 ){
		infoDialog(choosesigner)
	}else{
		$("#coordstatus").val("coordinated");
		$("#action").val("send");
		SaveFormJquery();	
	}
}

/* кнопка "Согласовать"*/
function saveAndCoord(redirecturl){
	if($("[name=coordBlock]").length==0){ 
		infoDialog(noblockcoord)
	}else{
		$("#action").val('startcoord') ;
		$("#coordstatus").val('coordinated') ;
		SaveFormJquery();
	}
}

var dataArray=new Array;

/* Создание скрытого поля в динамической форме */
function FormData(field, value){
	$("#dynamicform").append("<input type='hidden' name='"+field +"' id='"+field +"' value='"+value +"'>")
}

/* Создание формы для ввода комментариев действий пользователя "Согласен" или "Не согласен" */
function addComment(action){
	enableblockform()
	divhtml ="<div id='dialog-message-comment' title='"+commentcaption+"'>";
	divhtml +="<textarea name='commentText' id='commentText' rows='10' tabindex='1' style='width:97%'/>";
	divhtml+="</div>";
	$("body").append(divhtml);
	$("#dialog-message-comment").dialog({ 
		width: 400,
		buttons: [{
			text: "Ok",
			click: function() { 
				commentOk(action);
				$("#dialog-message-comment").remove();
			}
		},
		{
			text: button_cancel,
			click: function() { 
				$("#dialog-message-comment").remove();
				disableblockform();
				commentCancel();
			}
		}],
		beforeClose: function() { 
			$("#dialog-message-comment").remove();
			disableblockform();
			hotkeysnav();
			commentCancel();
		} 
	});
	$("#commentBox textarea").focus()
}

function commentCancel(){
	$('#commentBox, #dynamicform').remove();
}

/* Запись комментария пользователя в динамичемкую форму для отправки на сервер */
function commentOk(action){
	if ($("#commentText").val().length ==0){
		func = function(){
			$(this).dialog("close").remove();
			addComment(par)
		};
		dialogAndFunction (entercomment,func, "name",action)
	}else{
		new FormData('comment', $("#commentText").val());
		submitFormDecision(action);
	}
}

/* кнопка "Остановить документ" */
function stopdocument(docid){
	$(document).unbind("keydown")
	if ($.cookie("lang")=="RUS" || !$.cookie("lang")){
		title ="Остановить документ";
		text ="Выберите действие";
		create_new_version ="Новая версия";
		stop_coord ="Остановить согласование";
	}else{
		if( $.cookie("lang")=="KAZ"){
			title ="Құжатты тоқтату ";
			text ="Iс-әрекеттi таңдаңыз";
			create_new_version ="Жаңа болжам";
			stop_coord ="Келiсудi тоқтату";
		}else{
			if($.cookie("lang")=="ENG"){
				title ="Stop document";
				text ="Choose action";
				create_new_version ="New version";
				stop_coord ="Stop coordination";
			}
		}
	}
	divhtml ="<div id='infodialog' title='"+title+"'>";
	divhtml +="<div style='height:30px; width:100%; margin-top:5px; font-size:13px'>"+text+"</div></div>";
	$("body").append(divhtml);
	$("#infodialog").dialog({
		modal: true,
		width:"auto",
		buttons:[{
			text: create_new_version,
			click: function(){ 
				$(this).dialog("close").remove();
				form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
				$("body").append(form);
				actionTime= moment().format('DD.MM.YYYY HH:mm:ss');
				new FormData('actionDate',actionTime);
				new FormData('type', 'page'); 
				new FormData('id', "coord_stop");
				new FormData('newversion', "true"); 
				new FormData('key', docid);
				submitFormDecision("newversion")
			}
		},
		{
			text: stop_coord,
			click: function(){ 
				$(this).dialog("close").remove();
				hotkeysnav() 
				$("#dialog-message").dialog("close").remove();
				form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
				$("body").append(form);
				actionTime= moment().format('DD.MM.YYYY HH:mm:ss');
				new FormData('actionDate',actionTime);
				new FormData('type', 'page'); 
				new FormData('newversion', "false"); 
				new FormData('id', "coord_stop");
				new FormData('key', docid);
				submitFormDecision("stopcoord")
			}
		}],
		beforeClose: function() { 
			 $("#infodialog, .hotnav-accesskey").remove();
			 hotkeysnav()  
		} 
	});
	if($("body .ui-dialog").length > 1){
		$("body .ui-dialog :first").parent().css("z-index","1");
	}
	$("#infodialog button").focus();
}

/* обработка действий пользователя при согласовании и подписании. Кнопки "Согласен" и "Не согласен" */
function decision(yesno, key, action){
	form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
	$("body").append(form);
	actionTime= moment().format('DD.MM.YYYY HH:mm:ss');
	new FormData('actionDate',actionTime);
	new FormData('type', 'page'); 
    new FormData('id', action); 
    new FormData('key', key);
    if (yesno == "no"){
    	addComment(action)
    }else{
    	var dialog_title = "Оставить комментарий ответа?";
    	if ($.cookie("lang")=="KAZ")
    		dialog_title = "Жауаптың түсiнiктемесін қалдырасыз ма?";
        else if ($.cookie("lang")=="ENG")
        	dialog_title = "To leave the answer comment?";
        	
       dialogConfirmComment(dialog_title,action)
    }
    
}

/* Отправка динамической формы на сервер*/
function submitFormDecision (useraction){
	enableblockform()
	data = $("#dynamicform").serialize();
	$.ajax({
		type: "POST",
		url: "Provider",
		data: data,
		success: function(xml){
			if(useraction == "acquaint"){
				infoDialog("Документ отправлен на ознакомление")
			}
			if(useraction == "remind"){
				infoDialog("Напоминание отправлено")
			}
			redir = $(xml).find('redirect').text() || redirectAfterSave;
			if(useraction != "acquaint" ){
				switch (useraction) {
				   case "sign_yes":
					  notify_text=docissign;
				      break;
				   case "sign_no":
					  notify_text=docisrejected;
				      break;
				   case "coord_yes":
					   notify_text=dociscoordyou;
					   break;
				   case "coord_no":
					   notify_text=docisrejectedyou
					   break;
				   case "stopcoord":
					   notify_text="Согласование остановлено"
					   break;
				   case "newversion":
					   notify_text="Создана новая версия документа"
						   break;
				}
				setTimeout(function() {
					$("body").notify({"text":notify_text,"onopen":function(){},"loadanimation":false})
				}, 600);
				setTimeout(function() {
					$("body").hidenotify({"delay":400,"onclose":function(){if (redir == ''){window.history.back()}else{window.location = redir;}}})
				},1000);
				if (useraction == ""){	
					window.location = redir;
				}
				if (useraction == "remind"){
					disableblockform();
					$(document).unbind("keydown")
					divhtml ="<div id='dialog-message' title='Предупреждение'>";
					divhtml+="<div style='height:40px; width:100%; text-align:center; padding-top:25px; font-size:13px'>"+
					"Напоминание отправлено</div></div>";
					$("body").append(divhtml);
					$("#dialog-message").dialog({
						modal: true,
						width:330,
						buttons: {
							"Ok": function(){
								 $("#dialog-message").dialog("close").remove();
								 hotkeysnav() 
							},
							"Закрыть окно": function() {
								 $("#dialog-message").dialog("close").remove();
								 $("#canceldoc").click() 
							}
						},
						 beforeClose: function() { 
							 $("#dialog-message").remove();
							 hotkeysnav()  
						} 
					});
				}
			}
		}
	});
}

function Block(blockNum){  
    this.revTableName = 'blockrevtable'+blockNum;  
    this.revTypeRadioName = 'block_revtype_'+blockNum;
    this.hiddenFieldName = 'block_reviewers_'+blockNum;
}