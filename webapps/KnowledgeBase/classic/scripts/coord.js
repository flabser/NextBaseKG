var idtr="";
var count=0; //переменная для подсчета количесива блоков согласования
var contributorscoord='Участники согласования';
var	type='Тип';
var	parcoord='Параллельное';
var	sercoord='Последовательное';
var	waittime='Время ожидания';
var	coordparam='Параметры согласования';
var	hours ='Часов';
var	yescaption ='да';
var	nocaption ='нет';
var	answercommentcaption ='Оставить комментарий ответа?';
var	warning ='Предупреждение';
var redirectAfterSave = "";

 /* кнопка "Сохранить как черновик" */
function savePrjAsDraft(redirecturl){
	$('#coordstatus').val('draft');
	$('#action').val('draft');
    SaveFormJquery('frm', 'frm', redirecturl)		
}

/* кнопка "Отправить" */
function saveAndSend(redirecturl){
	$('#coordstatus').val('signing');
	$('#action').val('send');
	SaveFormJquery('frm', 'frm', redirecturl);	
}

/* кнопка "Согласовать"*/
function saveAndCoord(redirecturl){
	if($("[name=coordBlock]").length==0){ 
		infoDialog("Не указан ответственный участка")
	}else{
		$("#action").val('startcoord') ;
		$("#coordstatus").val('coordinated') ;
		SaveFormJquery('frm', 'frm', redirecturl);
	}
}

var dataArray=new Array;

/* Создание скрытого поля в динамической форме */
function FormData(field, value){
	$("#dynamicform").append("<input type='hidden' name='"+field +"' id='"+field +"' value='"+value +"'>")
}

/* Создание формы для ввода комментариев действий пользователя "Согласен" или "Не согласен" */
function addComment(){
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
	"<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:commentOk()' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" +
	"<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:commentCancel()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>" +
	"</div>" +
	"</div>";
	$("body").append(divhtml);
	$("#commentBox").draggable({handle:"div.headerComment"});
	centring('commentBox',470,250);
	$("#commentBox textarea").focus()
}

/* Закрытие формы для ввода комментария и удаление динамической формы */
function commentCancel(){
	$('#commentBox ,#dynamicform').remove();
	disableblockform()
}

/* Запись комментария пользователя в динамичемкую форму для отправки на сервер */
function commentOk(){
	if($("#commentText").val().length ==0){
		infoDialog("Введите комментарий");
	}else{
		new FormData('comment', $("#commentText").val());
		submitFormDecision();
	}
}

/* кнопка "Остановить документ" */
function stopDocument(key){
	form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
	$("body").append(form);
	new FormData('type', 'handler'); 
    new FormData('id', 'stopcoord'); 
    new FormData('key', key);
    submitFormDecision();
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
	$("body").css("cursor","wait");
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
			$("body").css("cursor","default")
			if(useraction != "remind" && useraction != "acquaint" ){
				redir = $(xml).find('history').find("entry[type=page]:last").text();
				if(redir == ""){
					redir = redirectAfterSave
				}
				window.location = redir;
			}
			
		}
	});
}

function Block(blockNum){  
    this.revTableName ='blockrevtable'+blockNum;  
    this.revTypeRadioName ='block_revtype_'+blockNum;
    this.hiddenFieldName ='block_reviewers_'+blockNum;
}