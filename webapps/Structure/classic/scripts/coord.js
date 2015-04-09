var idtr="";
var	type='Тип'
var	waittime='Время ожидания'
var	hours ='Часов'
var	yescaption ='да'
var	nocaption ='нет'
var	answercommentcaption ='Оставить комментарий ответа?'
var	warning ='Предупреждение';
var button_cancel="Отмена";

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

/* Закрытие формы для ввода комментария и удаление динамической формы */
function commentCancel(){
	$('#commentBox, #dynamicform').remove();
	disableblockform()
}

/* Запись комментария пользователя в динамичемкую форму для отправки на сервер */
function commentOk(action){
	if ($("#commentText").val().length ==0){
		func = function(){
			$(this).dialog("close").remove();
			addComment(par)
		};
		dialogAndFunction ("Введите комментарий",func, "name",action)
	}else{
		new FormData('comment', $("#commentText").val());
		submitFormDecision(action);
	}
}

/* кнопка "Остановить документ" */
function stopDocument(key){
	form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
	$("body").append(form);
	new FormData('type', 'handler'); 
    new FormData('id', 'stopcoord'); 
    new FormData('key', key);
    submitFormDecision();
}

/* обработка действий пользователя при согласовании и подписании. Кнопки "Согласен" и "Не согласен" */
function decision(yesno, key, action){
	enableblockform()
	$("body").append("<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>");
	var time=new Date();
	month=time.getMonth()+1;
	day=time.getDate();
	hours=time.getHours();
	minute=time.getMinutes();
	if (month< 10){ month="0"+month;}
	if (day<10){ day="0"+ time.getDate();}
	if (hours<10){ hours="0"+time.getHours();}
	if (minute<10){ minute="0"+time.getMinutes();}
	actionTime=day +"."+ month + "." + time.getFullYear()+ " " + hours + ":" + minute +":00";
	new FormData ('actionDate',actionTime );
	new FormData('type', 'handler'); 
    new FormData('id', action); 
    new FormData('key', key);
    if (yesno == "no"){
    	addComment(action)
    }else{
    	dialogConfirmComment (answercommentcaption,action)
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
			$("body").css("cursor","default")
			redir = $(xml).find('history').find("entry[type=view]:last").text() || redirectAfterSave;
			if(useraction == "sign_yes"){
				setTimeout(function() {
					$("body").notify({"text":docissign,"onopen":function(){},"loadanimation":false})
				}, 600);
				setTimeout(function() {
					$("body").hidenotify({"delay":400,"onclose":function(){if (redir == ''){window.history.back()}else{window.location = redir;}}})
				},1000);
			}
			if(useraction == "sign_no"){
				setTimeout(function() {
					$("body").notify({"text":docisrejected,"onopen":function(){},"loadanimation":false})
				}, 600);
				setTimeout(function() {
					$("body").hidenotify({"delay":400,"onclose":function(){if (redir == ''){window.history.back()}else{window.location = redir;}}})
				},1000);
			}
			if(useraction == "coord_yes"){
				setTimeout(function() {
					$("body").notify({"text":dociscoordyou,"onopen":function(){},"loadanimation":false})
				}, 600);
				setTimeout(function() {
					$("body").hidenotify({"delay":400,"onclose":function(){if (redir == ''){window.history.back()}else{window.location = redir;}}})
				},1000);
			}
			if(useraction == "coord_no"){
				setTimeout(function() {
					$("body").notify({"text":docisrejectedyou,"onopen":function(){},"loadanimation":false})
				}, 600);
				setTimeout(function() {
					$("body").hidenotify({"delay":400,"onclose":function(){if (redir == ''){window.history.back()}else{window.location = redir;}}})
				},1000);
			}
			if(useraction == ""){	
				window.location = redir;
			}
			if(useraction == "remind"){	
				$(document).unbind("keydown")
				divhtml ="<div id='dialog-message' title='Предупреждение'>";
				divhtml+="<div style='height:40px; width:100%; text-align:center; padding-top:25px'>"+
					"<font style='font-size:13px;'>Напоминание отправлено</font></div>";
				divhtml += "</div>";
				$("body").append(divhtml)
				$("#dialog-message").dialog("destroy");
				$("#dialog-message").dialog({
					modal: true,
					width:330,
					buttons: {
						"Ok": function() {
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
	});
}

function Block(blockNum){  
    this.revTableName = 'blockrevtable'+blockNum;  
    this.revTypeRadioName = 'block_revtype_'+blockNum;
    this.hiddenFieldName = 'block_reviewers_'+blockNum;
}