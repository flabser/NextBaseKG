var lang = "RUS";
var fieldIsValid = true;
var alertmessage = '';
var statusInfo = null;
var storeType = 17;
var fileOrDevice = null;
var password = null;
var showPassFrame = true;
var str = null;
var key = null;
var alias = null;
var P12_STORE_TYPE = 17;
/* переменные для перевода диалогов */
var acquaintcaption = "Ознакомить";
var remindcaption = "Напомнить";
var cancelcaption = "Отмена";
var changeviewcaption = "Изменить вид";
var receiverslistcaption = "Список получателей напоминания";
var correspforacquaintance = "Список корреспондентов для ознакомления";
var searchcaption = "Поиск";
var commentcaption = "Комментарий";
var documentsavedcaption = "Документ сохранен";
var documentmarkread = "Документ отмечен как прочтенный";
var pleasewaitdocsave = "Пожалуйста ждите... Идет сохранение документа";
var showauthor ="Укажите кто будет подписывать проект служебной записки";
var showrecipient ="Укажите получателя";
var noblockcoord ="Вы не создали ни одного блока согласования";
var choosevalue ="Выберите значение";
var alreadychosen ="Данный корреспондент уже выбран для согласования";
var isrecieverofsz="Выбранный вами сотрудник является получателем служебной записки";
var issignerofsz="Выбранный вами сотрудник является подписывающим служебной записки";
var saving ="Сохранение"
var showfilename ="Укажите имя файла для вложения"
var addcommentforattachment ="Добавить комментарий к вложению?";
var removedfromcontrol = "Документ снят с контроля";
var warning ="Предупреждение";
var attention ="Внимание";
var addcomment= "Добавить комментарий";
var delete_file="Удалить файл";
var onlynumber="Поле может содержать только числовые значения";
var buttonyes="Да";
var buttonno="Нет";
var button_saveandclose="Сохранить и закрыть";
var button_close="Закрыть";
button_cancel="Отмена";
	
var calendarStrings = {
	"RUS": {},
	"KAZ": {
		monthNames: ['Қаңтар','Ақпан','Наурыз','Сәуір','Мамыр','Маусым', 'Шілде','Тамыз','Қыркүйек','Қазан','Қараша','Желтоқсан'],
		monthNamesShort: ['Қаңтар','Ақпан','Наурыз','Сәуір','Мамыр','Маусым', 'Шілде','Тамыз','Қыркүйек','Қазан','Қараша','Желтоқсан'],
		dayNames: ['жексебі','дүйсенбі','сейсенбі','сәрсенбі','бейсенбі','жұма','сенбі'],
		dayNamesShort: ['жек','дүй','сей','сәр','бей','жұм','сен'],
		dayNamesMin: ['Жс','Дс','Сс','Ср','Бс','Жм','Сн']
	},
	"ENG": {
		monthNames: ['January','February','March','April','May','June', 'July','August','September','October','November','December'],
		monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
		dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
		dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
		weekHeader: 'Wk'
	},
	"CHN": {
		closeText: '关闭',
		prevText: '&#x3c;上月',
		nextText: '下月&#x3e;',
		currentText: '今天',
		monthNames: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
		monthNamesShort: ['一','二','三','四','五','六','七','八','九','十','十一','十二'],
		dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
		dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
		dayNamesMin: ['日','一','二','三','四','五','六'],
		weekHeader: '周',
		yearSuffix: '年'
	}
};

function setPassword(password) {
    document.getElementById('SignApplet').setPassword(password);
}

function checkPassword(storeType, fullPath){
    var ret = false;
    try{
        ret = document.getElementById('SignApplet').checkPassword(storeType ,fullPath);
    } catch(ex){
        alert(ex);
    }
    return ret;
}

function getAlias(storeType) {
    var keys = null,
    	key = null;

    if (storeType == P12_STORE_TYPE) {
        keys = document.getElementById('SignApplet').getKeyStoreUsableKeys(storeType, fileOrDevice, document.getElementById('SignApplet').getPassword()).split("\n");
        key = keys[0].split("|");
    } else {
        var control = document.getElementById('keyList');
        for (var i = 0; i < control.options.length; i++) {
            if(control.options[i].selected == true){
                key = control.options[i].text.split("|");
            }
        }
        return key[1];
    }
    if (keys == null || keys == "") {
        alert("No usable keys found");
    }
    return key[1];
}

function signPlainData() {
    statusInfo = "";
    var signature = null;
    sign="";
    var items =$("#frm input[name][name!=signedfields][name!=key][name!=dbd][name != formsesid][name != taskvn]");
    items.sort(function(a, b) {
       return $(a).attr('name').toUpperCase().localeCompare($(b).attr('name').toUpperCase());
    })
    items.each(function(){
        sign+=$(this).val()
    })
    var data = sign;
    if(data == null){
        alert('Данных для подписи нет.');
        return;
    }
    if(checkPassword(storeType, fileOrDevice)) {
        alias = getAlias(storeType);
        signature = document.getElementById('SignApplet').createPKCS7(data, false, storeType, fileOrDevice, alias);
        //window.alert(signature);
        //window.alert(document.getElementById('SignApplet').signPlainData(data, storeType, fileOrDevice, alias));
        if (signature == null){
            statusInfo = 'Ошибка при постановке подписи!';
            alert(statusInfo);
        }else{
            $("#frm").append("<input type='hidden' name='signedfields' value='"+signature+"'/>")
            statusInfo = 'Данные успешно подписаны!';
            //alert(statusInfo);
        }
        //updateStatusSpan('', statusInfo);
    }
    //unBlockScreen();
}

function selectP12File() {
    if(document.getElementById('SignApplet') != null){
        document.getElementById('SignApplet').showFileChooser("setSelectedPath");
    }else{
        infoDialog("Апплет подписи не найден")
    }
}

function getFileName(path) {
    var m = path.match(/(.*)[\/\\]([^\/\\]+)\.\w+$/);
    return m[2];
}

function getFileExtesion(path){
    return path.substr(path.lastIndexOf('.') + 1);
}

function setSelectedPath(path) {
    document.getElementById('p12Path').value = path;
    filePath = path;
    if(storeType == P12_STORE_TYPE && getFileExtesion(path).toLowerCase() =='bin'){
        fileOrDevice = path;
        updateStatusSpan('', "Для использования файлов БИН Тумар выбирите соответствующую категорию хранилища");
        return;
    } else if(getFileExtesion(path).toLowerCase() == 'p12' || getFileExtesion(path).toLowerCase() == 'pfx'){
        fileOrDevice = path;
        return storeType;
    } else {
        statusInfo = '';
        updateStatusSpan('Файл не выбран!', statusInfo);
        return; // при отмене ничего не делать
    }
    statusInfo = getFileName(path) + '.' + getFileExtesion(path).toLowerCase();
    updateStatusSpan('Выбран файл: ', statusInfo);
}

function showCommentText(text){
	divhtml ="<div id='dialog-message' title='Комментарий ответа'>";
	divhtml+="<div style='text-align:center; white-space:pre-wrap;  white-space:-moz-pre-wrap;  white-space:-pre-wrap; white-space:-o-pre-wrap; word-wrap:break-word;'>"+
		"<font style='font-size:13px; width:100px'>"+text+"</font></div></div>";
	$("body").append(divhtml);
	$("#dialog-message").dialog({
		modal: true,
		buttons:{
			"Ок":function() {
				$(this).dialog("close").remove();
			}
		}
	});
	$(".ui-dialog button").focus();
}

function changeCustomField(name,value){
	$("input[name="+name+"]").val(value);
}

function setValHiddenFields(el){
	$("[name=parentdocid]").val($(el).val());
}

function addquickanswer(targetid , val, button){
	if ($(button).hasClass("inited")){
		$(button).removeClass("inited")
		$("#"+targetid).val(prevvalanswer)
		$(".inited").removeClass("inited")
	}else{
		$(".inited").removeClass("inited")
		$(button).addClass("inited");
		$("#"+targetid).val(prevvalanswer +" "+ val);
	}
}

function previewquickanswer(targetid, val, button){
	if(!$(button).hasClass("inited")){
		prevvalanswer = $("#"+targetid).val();
		$("#"+targetid).val($("#"+targetid).val() +" " + val);
	}
}

function endpreviewquickanswer(targetid , val, button){
	if (!$(button).hasClass("inited")){
		$("#"+targetid).val(prevvalanswer);
	}
}

function resetquickanswerbutton(){
	$(".inited").removeClass("inited");
	quickanswer = null;
	prevvalanswer = null;
	preview = null;
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

function fillingReport(){
	var fields = $('form').serializeArray();
	var recursiveEncoded = $.param(fields);
	window.location.href = 'Provider?type=handler&id=filling_report&'+recursiveEncoded;
}

/* кнопка "назад"*/
function CancelForm(url) {
	url != null && url.length !=0 ?	window.location.href=url : window.history.back();
}

function fieldOnFocus(field) {
	field.style.backgroundColor = '#FFFFE4';
}

function fieldOnBlur(field) {
	field.style.backgroundColor = '#FFFFFF';
}

function Numeric(el) {
	$(el).keypress(function (e){
		if ((e.which < 48) || (e.which > 57) ) {
			if( (e.which != 8) ){
				return false
			}
		}
	});
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

/* функция снятия с контроля документ*/
function resetcontrol(){
	changeCustomField("allcontrol","0")
	var count_executors = $("input[type=hidden][name=executor]").length + $("input[type=hidden][name=extexecutor]").length;
	$("#tabs .ui-state-default:nth-child(3) a").click()
	$(".switchControl img[src *='eye.png']").click();
	setTimeout(function() {
		$(document).unbind("keydown")
		divhtml ="<div id='dialog-message' title="+warning+">";
		divhtml+="<div style='height:40px; width:100%; text-align:center; padding-top:25px'>"+
		"<font style='font-size:13px;'>"+removedfromcontrol+"</font></div></div>";
		$("body").append(divhtml);
		$("#dialog-message").dialog({
			modal: true,
			width:330,
			buttons: [{
				text: button_saveandclose,
				click: function() { 
					$("#dialog-message").dialog("close").remove();
					$("#btnsavedoc").click() 
				}
			},
			{
				text: button_close,
				click: function() { 
					$("#dialog-message").dialog("close").remove();
					 hotkeysnav() 
				}
			}],
			 beforeClose: function() { 
				 $("#dialog-message").remove();
				 hotkeysnav()  
			} 
		});
	},count_executors * 50 );
}

/* функция снять с контроля пользователя*/
function controlOff(obj){
	parent_tr=$(obj).closest("tr");
	type=$(parent_tr).attr("class");
	$(parent_tr).children(".idCorrControlOff").html($("#localusername").val());
	actionTime= moment().format('DD.MM.YYYY HH:mm:ss');
	responsible = $(parent_tr).find(".responsible").val()
	$(parent_tr).children(".controlOffDate").text(actionTime);
	$(parent_tr).children(".switchControl").html("<img style='cursor:pointer' title='Поставить на контроль' onclick='javascript:controlOn(this,\""+type+"\")' src='/SharedResources/img/classic/icons/accept.png'/>");
	type=='INTERNAL' ? type='1' : type='2';
	execid=$(parent_tr).find(".idContrExec").val();
	idCorrControlOff=$("#currentuserid").val();
	$(parent_tr).find(".controlres").val(type+"`"+execid +"`"+responsible+"`" +actionTime+"`"+idCorrControlOff);
}

/* функция поставить на контроль*/
function controlOn(obj){
	parent_tr=$(obj).closest("tr");
	type=$(parent_tr).attr("class");
	$(parent_tr).find(".idCorrControlOff").text(""); 
	$(parent_tr).find(".controlOffDate").text("");
	$(parent_tr).find(".switchControl").html("<img style='cursor:pointer' title='Снять с контроля' onclick='javascript:controlOff(this,\""+type+"\")' src='/SharedResources/img/classic/icons/eye.png'/>");
	type=='INTERNAL' ? type='1' : type='2';
	$(parent_tr).find(".controlres").val(type+"`"+$(parent_tr).find(".idContrExec").val()+"` ` ");
}

function infoDialog(text, type){
	$(document).unbind("keydown")
	if(!type){
		title = warning;
	}else{
		if(type == 'information'){
			title ="Информация";
			if( $.cookie("lang")=="KAZ")
				title ="Ақпарат";
			else if( $.cookie("lang")=="ENG")
				title ="Information";
		}
	}
	divhtml ="<div id='infodialog' title='"+title+"'>";
	divhtml +="<span style='height:40px; width:100%; text-align:center;'><font style='font-size:13px;'>"+text+"</font></span></div>";
	$("body").append(divhtml);
	$("#infodialog").dialog({
		modal: true,
		buttons: {
			"Ок": function() {
				if($("body .ui-dialog").length > 1){
					$("body .ui-dialog :first").parent().css("z-index","1002");
				}
				$(this).dialog("close").remove();
				$(".hotnav-accesskey").remove()
				hotkeysnav() 
			}
		},
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
 
function dialogConfirmComment(text,action){
	enableblockform()
	$("body").css("cursor","wait");
	divhtml ="<div id='dialog-message' title='"+warning+"'>";
	divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	"<font style='font-size:13px; '>"+text+"</font>"+"</span></div>";
	$("body").append(divhtml);
	$("#dialog-message").dialog("destroy");
	$("#dialog-message").dialog({
		height:140,
		modal: false,
		buttons: [
		{
			text: buttonyes,
			click: function() { 
				$(this).dialog("close").remove();
				addComment(action) }
		},
		{
			text: buttonno,
			click: function() { 
				$(this).dialog("close").remove();
				submitFormDecision(action) }
		}
		],
		beforeClose: function() {
			disableblockform();
			$("body").css("cursor","default");
			$("#dialog-message").remove();
			hotkeysnav() 
		} 
	});
}

function dialogConfirm(text,el,actionEl){
	 divhtml ="<div id='dialog-message' title='"+warning+"'>";
	 divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	 "<font style='font-size:13px;'>"+text+"</font></span></div>";
	 $("body").append(divhtml);
	 $("#dialog-message").dialog("destroy");
	 $("#dialog-message").dialog({
		 height:140,
		 modal: true,
		 buttons: [{
			 text: 'Ok',
			 click: function() { 
				 $(this).dialog("close").remove();
				 if (el == 'picklist'){
					 $('#blockWindow').css('display',"block")
				 }
				 $('#'+el).css('display', "inline-block");
				 $("."+actionEl).remove();
			 }
		 },
		 {
			 text: button_cancel,
			 click: function() { 
				 $(this).dialog("close").remove();
				 if (el == 'picklist'){
					 $('#blockWindow').remove()
				 }
				 $('#'+el).empty().remove();
			 }
		 }]
	 });
}

/*Вложение сертификата для цифровой подписи*/
function eds_attach_dialog(){
	$(document).unbind("keydown");
	$("input[name=eds_pass]").remove();
	if ( $.cookie("lang")=="RUS" || !$.cookie("lang"))
	divhtml ="<div id='dialog-message-attach' title='Выбор хранилища закрытого ключа'>";
	else if ($.cookie("lang")=="KAZ")
		divhtml ="<div id='dialog-message-attach' title='Выбор хранилища закрытого ключа'>";
	else if ( $.cookie("lang")=="ENG")
		divhtml ="<div id='dialog-message-attach' title='Выбор хранилища закрытого ключа'>";
	divhtml +="<span style='height:250px; width:100%;'><br/>"+
		"<form action='Uploader' name='upload' id='upload_eds' method='post' enctype='multipart/form-data' style='min-width:100px'>"+
		"<input type='hidden' name='type' value='eds_cert'/>"+
		"<input type='hidden' name='formsesid' value='"+$("input[name=formsesid]").val()+"'/>"+
		//"<input type='file' size='60' border='#CCC' style='margin-top:5px' name='fname_eds' onchange='submitFile(\"upload_eds\", \"upltable_eds\", \"fname_eds\");'></input>&#xA0;"+
		"<input id='selectP12Files' type='button' onclick=\"javascript: selectP12File();\" style='width:95px; padding: 0.25em 1em; !important' value='Обзор' title='Выбрать хранилище закрытого ключа' name='selectP12Files'/>"+
		"<input id='p12Path' type='text' readonly='readonly' style='margin-left:5px; width: 250px; padding: 0.3em 0em;' autocomplete='off' name='p12Path'/>"+
		"<div style='margin-top:5px'><div style='width:97px; display:inline-block; text-align:right; padding-right:0px; color: #444444; font-size: 98%;'>Пароль :</div> <input type='password' id='eds_pass_temp' value='' style='width: 250px; padding: 0.3em 0em;'/></div>"+
		"<style>.ui-progressbar .ui-progressbar-value { background-image: url(/SharedResources/jquery/css/base/images/pbar-ani.gif); }</style>"+
		"<table id='upltable_eds' style='margin-top:5px'></table>"+
		"</div></form>"
	+"</span>";
	divhtml += "</div>";
	$("body").append(divhtml);
	$("#selectP12Files").button()
	$("#dialog-message-attach").dialog({
		width:385,
		height:210,
		modal: true,
		buttons: [{
			text: 'Ok',
			click: function() {
                if(filePath.length != 0){
                    if($("#eds_pass_temp").val().length != 0){
                    	setPassword($("#eds_pass_temp").val());
                    	if(checkPassword(storeType, fileOrDevice)){
                    		alias = getAlias(storeType);
                        	cert = document.getElementById('SignApplet').getCertificateFromKeyStore(storeType, fileOrDevice, alias)
                        	$.ajax({
                    			type: "POST",
                    			url: 'SignProvider?type=service&operation=check_cert&id=check_cert&cert='+cert,
                    			success:function(xml){
                    				state=$(xml).find("eds_stat").attr("stat");
                    				if(state == "ok"){
    	                				$("body").append("<input type='hidden' id='eds_pass' value='"+$("#eds_pass_temp").val()+"'/>")
    	                                signPlainData();
    	                                $(this).dialog("close").remove();
    	                                $("#btnsavedoc").click()
                    				}else{
                    					infoDialog($(xml).find("eds_stat").text())
                    				}
                    			},
                    			error:function (xhr, ajaxOptions, thrownError){
                    			}    
                    		});
                    	}else{
                    		infoDialog("Пароль введен неверно")
                    	}
                    }else{
                        infoDialog("Необходимо заполнить поле пароль")
                    }
                }else{
                    infoDialog("Необходимо выбрать файл сертификата")
                }
			}
		},
		{
			text: button_cancel,
			click: function() { 
				$(this).dialog("close").remove();
			}
		}],
		beforeClose: function() { 
			 $("#dialog-message-attach ,.hotnav-accesskey").remove();
			 hotkeysnav()  
		} 
	});
	$(".ui-dialog button").focus();
}

/* сохранение формы */
function SaveFormJquery() {
	enableblockform()
	if($("#MyTextarea").length != 0){
		$("#MyTextarea").val(document.getElementsByTagName("iframe")[0].contentDocument.getElementsByTagName("body")[0].innerHTML)
	}
	$("body").notify({"text":pleasewaitdocsave,"onopen":function(){}})
	divhtml ="<div id='dialog-message' title="+saving+">";
	divhtml+="<div style='margin-top:8px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>Пожалуйста ждите...</font></div>";
	divhtml+="<div style='margin-top:5px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>идет сохранение документа</font></div>";
	divhtml+="<br/><div style='margin-top:5px; text-align:center;'><font style='font-size:14px; font-family:arial; padding-left:10px;'></font></div>";
	divhtml+="</div>";
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	var formData = $("form").serialize();
	if($("#SignApplet").length !=0 ){
		sign="";
		$("#frm input[name][name!=signedfields]").each(function(){
			sign+=$(this).val()
		})
		$("#frm").append("<input type='hidden' name='applettype' value='sign'/>")
		//$("#frm").append("<input type='hidden' name='srctext' value=''/><input type='hidden' name='applettype' value='sign'/>")
        //$("input[name=srctext]").val(sign)
		taskauthor=$("input[name=taskauthor]").val()
		app=document.getElementById('SignApplet');
		fullpath = $("#fullpath").val();
		pass=$("#eds_pass").val();
		//$("#frm").append("<input type='hidden' name='signedfields' value='"+app.getSign(sign,fullpath,pass)+"'/>")
		//$("#frm").append("<input type='hidden' name='signedfields' value='"+app.getSign(sign)+"'/>")
	}
	/*
	if($("input[name=id]").val() && $("#SIgnApplet").length !=0 ){
		$("#frm").append("<input type='hidden' name='srctext' value="+sign+"/><input type='hidden' name='applettype' value='sign'/>")
		taskauthor=$("input[name=taskauthor]").val()
		app=document.getElementById('SignApplet');
		$("#frm").append("<input type='hidden' name='signedfields' value='"+app.getSign(sign,taskauthor)+"'/>")
	}*/
	$.ajax({
		type: "POST",
		url: 'Provider',
		data: $("form").serialize(),
		success:function (xml){ 
			$(document).unbind("keydown")
			redir = $(xml).find('redirect').text();
			$(xml).find('response').each(function(){
				var st=$(this).attr('status');
				msgtext=$(xml).find('message[id=1]').text();
				if (st =="error" || st =="undefined"){
					if (msgtext.length==0){
						msgtext = "Ошибка сохранения"
					}
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
					$("#dialog-message").html("<div style='text-align:center'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+msgtext+"</font></div>");
				}
				if (st == "ok"){
					if (msgtext.length==0){
						$("#notifydiv").html("<font>"+documentsavedcaption+"</font>")
						setTimeout(function() {
							$("body").hidenotify({"delay":200,"onclose":function(){ redir == '' ? window.history.back() : window.location = redir; }})
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
									redir == '' ? window.history.back() : window.location = redir;
									disableblockform();
								}
							},
							beforeClose: function() { 
								$("#dialog-message").remove();
								redir == '' ? window.history.back() : window.location = redir;
								disableblockform();
							}  
						});
						$("#dialog-message").html("<br/><div style='text-align:center'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>"+msgtext+"</font></div>");
						$(".ui-dialog button").focus();
					}
				}
				
			});
		},
		error:function (xhr, ajaxOptions, thrownError){
			if (xhr.status == 400){
				$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'/>")
				$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
				$("li[type='square'] > a").attr("href","javascript:backtocontent()")
			}
		}    
	});
}

/*set of upload function*/
function loadingAttch(tableID){
	$("#"+tableID).append("<tr id='loading_attach'><td></td><td><div style='position:absolute; z-index:999'><img src='/SharedResources/img/classic/progress_bar_attach.gif'/></div></td></tr>")
	blockWindow = "<div class='blockWindow' id='blockWindow'/>"; 
	$("body").append(blockWindow).css("cursor","wait");
	$('#blockWindow').css('width',$(document).width()).css('height',$(document).height()).css('display',"block"); 
}

/* добавление вложений в форму */
function submitFile(formid, tableID, fieldName) {
	if ($('input[name='+fieldName+']').val() == '' || $('input[name='+fieldName+']').val() == 'undefined') {
		infoDialog(showfilename);
	}else{
		form = $('#'+formid);
		$(form).find("#progressbar").progressbar({value:0});
		$(form).find("#progressstate").css("display","block")
		var frame = createIFrame();
		frame.onSendComplete = function() {
			uploadComplete(tableID, getIFrameXML(frame));
			$("#loading_attach, #loadingpage, #blockWindow ").remove();
			$("body").css("cursor","default")
		};
		form.attr('target',frame.id);
		form.submit();
	}
}

var req;
function ajaxFunction(){
	req = $.get("Uploader",processStateChange);
}

var cancel_button_action;
function processStateChange(){
	if (req.readyState == 4){
		if (req.status == 200){ 
			$("#loading_attach_img").css("visibility","visible")
			$(".button_panel").find("button:not(#canceldoc)").attr("disabled","disabled").addClass("ui-state-disabled")
			if($("#canceldoc").attr("onclick") != "javascript:confirmCancelAttach()"){
				cancel_button_action= $("#canceldoc").attr("onclick");
				$("#canceldoc").attr("onclick","javascript:confirmCancelAttach()")
			}
			var xml = req.responseXML,
				isNotFinished = $(xml).find("finished")[0],
				myBytesRead = $(xml).find("bytes_read")[0],
				myContentLength = $(xml).find("content_length")[0],
				myPercent = $(xml).find("percent_complete")[0];
			if ((isNotFinished == null) && (myPercent == null)){
				$("#initializing").css("visibility","visible")
				window.setTimeout("ajaxFunction();", 150);
			}else{
				$("#readybytes, #percentready").css("visibility","visible")
				$("#initializing").css("visibility","hidden");
				kbContentLength = parseInt($(myContentLength).text())/1024;
				mbContentLength = parseInt(kbContentLength)/1024;
				if (myPercent != null){
					$("#progressbar").progressbar( "option", "value",parseInt($(myPercent).text()));
					kbread = parseInt($(myBytesRead).text())/1024;
					mbread = parseInt(kbread)/1024
					$("#readybytes").html(Math.round(mbread * 10 ) / 10  + " из " + Math.round(mbContentLength * 10) / 10   + " мбайт загружено")
					$("#percentready").html($(myPercent).text() + "%")
					window.setTimeout("ajaxFunction();", 100);
				}else{
					$(".button_panel").find("button:not(#canceldoc)").removeAttr("disabled").removeClass("ui-state-disabled")
					$("#dialog-message-cancel-attach").dialog('close').remove();
					$("#readybytes").html(Math.round(mbContentLength * 10)/10   + " из " + Math.round(mbContentLength * 10) / 10   + " мбайт загружено")
					$("#percentready").html("готово")
					$("#loading_attach_img").css("visibility","hidden")
					$("#canceldoc").attr("onclick",cancel_button_action)
					$("#progressbar").progressbar("option", "value", 100);
				}
			}
		}else{
			alert(req.statusText);
		}
	}
}

function confirmCancelAttach(){
	divhtml ="<div id='dialog-message-cancel-attach' title='Предупреждение'>";
	divhtml+="<span style='height:40px'><p><font style='font-size:13px'>Процесс прикрепления файла к документу не закончен. Все несохраненные данные будут утеряны. Закрыть документ?</font></p></span>";
	divhtml += "</div>";
	$("body").append(divhtml);
	$("#dialog-message-cancel-attach").dialog({
		modal: true,
		height:200,
		width:460,
		buttons: {
			"Да": function(){
				$("#canceldoc").attr("onclick",cancel_button_action).click();
				$(this).dialog('close').remove();
			},
			"Нет": function(){
				$(this).dialog('close').remove();
			}
		}
	});
}

function createIFrame() {
	var id = 'f' + Math.floor(Math.random() * 99999),
		divHTML = '<iframe style="display:none" src="about:blank" id="' + id
			+ '" name="' + id + '" onload="sendComplete(\'' + id
			+ '\')"></iframe>';
	$("body").append("<div>"+divHTML +"</div>")
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
				if($(element).val() == fileName){
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
		$("#progressbar").progressbar("destroy");
		infoDialog('Произошла ошибка на сервере при выгрузке файла');
	}
	$("#upload")[0].reset();
}

function changeAttIcon(el){
	$(el).attr("src","/SharedResources/img/iconset/file_extension_undefined.png");
	$(el).removeClass()
}

/*определение расширения вложения */
function detectExtAttach(file){
	var fileLen=file.length,
		symbol;
	while(symbol !='.' || fileLen == 0){
		symbol=(file.substring(fileLen-1,fileLen));
		fileLen = fileLen - 1;
	}
	RegEx=/\s/g;
	ext=file.substring(fileLen +1, file.length).replace(RegEx, "").toLowerCase();
	return ext;
}

var control_sum_file = null; 
function ConfirmCommentToAttach(text,csf){
	control_sum_file = csf;
	divhtml ="<div id='dialog-message' title='"+attention+"'>";
	divhtml +="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	"<font style='font-size:13px;'>"+text+"</font>"+"</span>";
	divhtml += "</div>";
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	if ($.cookie("lang")=="RUS" || !$.cookie("lang")){
		$("#dialog-message").dialog({
			height:140,
			modal: true,
			buttons:{
				"да": function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
				},
				"нет": function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'/></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
				$("#readybytes, #percentready, initializing").text('')
			} 
		});
	}
	else if  ($.cookie("lang")=="ENG"){
		$("#dialog-message").dialog({
			height:140,
			modal: true,
			buttons:{
				"yes": function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
				},
				"no": function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
				$("#readybytes, #percentready , initializing").text('')
			} 
		});
		}
	else if  ($.cookie("lang")=="KAZ"){
		$( "#dialog-message" ).dialog({
			height:140,
			modal: true,
			buttons:{
				"иә": function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
				},
				"жоқ": function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
				$("#readybytes, #percentready , initializing").text('')
			} 
		});
	}
	else if  ($.cookie("lang")=="CHN"){
		$( "#dialog-message" ).dialog({
			height:140,
			modal: true,
			buttons:{
				是: function() {
					$(this).dialog("close").remove();
					addCommentToAttach()
				},
				不: function() {
					$(this).dialog("close").remove();
					$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				}
			},
			beforeClose: function() { 
				$("<tr><td colspan='3'></td></tr>").insertAfter("#"+control_sum_file);
				$("#progressbar").progressbar("destroy");
				$("#progressstate").css("display","none");
				$("#readybytes, #percentready , initializing").text('')
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
			"<img style='width:15px; height:15px; margin-left:3px; margin-top:2px' src='/SharedResources/img/iconset/cross.png'/>" +
		"</div></div>" +
	"<div class='contentComment'>" +
		"<br/><table style=' margin-top:2%; width:100%'>" +
			"<tr>" +
				"<td style='text-align:center'><textarea  name='commentText' id='commentText' rows='10'  tabindex='1' style='width:97%'/>" +
				"</td>" +
			"</tr>" +
		"</table><br/>" +
	"</div>"+
	"<div class='buttonPaneComment button_panel' style='margin-top:1%; text-align:right; width:98%'>" +
	"<button onclick='javascript:commentToAttachOk()' style='margin-right:5px'><font class='button_text'>ОК</font></button>" +
	"<button onclick='javascript:commentCancel()'><font class='button_text'>"+cancelcaption+"</font></button>" +
	"</div>" +
	"</div>";
	$("body").append(divhtml);
	$("#commentBox #button_panel").children("button").button()
	$("#commentBox").draggable({handle:"div.headerComment"});
	centring('commentBox',470,250);
	$("#commentBox textarea").focus()
}

function commentToAttachOk(){
	if ($("#commentText").val().length ==0){
		if ($.cookie("lang")=="RUS" || !$.cookie("lang"))
			infoDialog("Введите комментарий");
		else if ($.cookie("lang")=="ENG")
			infoDialog("Add comments");
		else if ($.cookie("lang")=="KAZ")
			infoDialog("Түсініктеме жазыңыз");
	}else{
		$("#frm").append("<input type='hidden' name='comment"+control_sum_file+"' value='"+ $("#commentText").val() +"'>")
		if ($.cookie("lang")=="RUS" || !$.cookie("lang"))
			$("<tr><td></td><td style='color:#777; font-size:12px'>комментарий : "+$("#commentText").val()+"</td><td></td></tr>").insertAfter("#"+control_sum_file)
		else if ($.cookie("lang")=="ENG")
			$("<tr><td></td><td style='color:#777; font-size:12px'>comments : "+$("#commentText").val()+"</td><td></td></tr>").insertAfter("#"+control_sum_file)
		else if ($.cookie("lang")=="KAZ")
			$("<tr><td></td><td style='color:#777; font-size:12px'>түсініктеме : "+$("#commentText").val()+"</td><td></td></tr>").insertAfter("#"+control_sum_file)
		$("#commentaddimg"+control_sum_file).remove()
		$("#commentBox").remove()
	}
}

/* создание  cookie для сохранения настроек пользователя и сохранение профиля пользователя*/
function saveUserProfile(){
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
				var redir = $(xml).find('redirect').text() || $(xml).find('history').find("entry[type=page]:last").text();
				$.cookie("lang", $("select[name='lang']").val(),{ path:"/", expires:30});	
				$.cookie("refresh", $("select[name='refresh']").val(),{ path:"/", expires:30});		
				redir == '' ? window.history.back() : window.location = redir;
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
		url: "Provider?type=service&operation=mark_as_read&id=mark_as_read&doctype="+doctype+"&key="+docid,
		cache:false,
		success:function (xml){
			$("body").notify({"text":documentmarkread,"onopen":function(){$("body").hidenotify({"delay":1200,"onclose":function(){$("#notifydiv").remove()}})},"loadanimation":false})
		}
	});
}

function deleterow(sesid,filename, fieldid){
	$("#progressbar").progressbar("destroy");
	$("#progressstate").hide();
	$("#"+fieldid).next("tr").remove()
	$("#"+fieldid).remove()
	$("#frm").append("<input type='hidden' name='deletertfcontentsesid' value='"+ sesid +"'/><input type='hidden' name='deletertfcontentname' value='"+ filename +"'/><input type='hidden' name='deletertfcontentfield' value='rtfcontent'/>")
}

var el;
var UrlDecoder = {
	encode : function (string){
		return escape(this._utf8_encode(string));
	},
	decode : function (string){
		return this._utf8_decode(unescape(string));
	},
	_utf8_encode : function(string){
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}else{
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
		}
		return utftext;
	},
	_utf8_decode : function(utftext){
		var string = "",
			i = 0,
			c = c1 = c2 = 0;
		while (i < utftext.length) {
			c = utftext.charCodeAt(i);
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			}else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}else{
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
	divhtml +="<div class='header'><font id='headertext' class='headertext'></font>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose();'/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:6%; margin-left:81%'></div>";
	divhtml +="<div id='divSearch' display='block'><div style='font-size:13px; text-align:left; margin-left:2%'>"+receiverslistcaption+":</div></div>" ;
	divhtml +="<div id='contentpane' style='overflow:auto;  border:1px solid  #d3d3d3; padding-top:10px; width:95%; margin:10px; height:250px;'>Загрузка данных...</div>"; 
	divhtml +="<div id='divComment' style='text-align:left; margin:10px; font-size:13px; width:95%'><table width='100%'><tr><td style='font-size:13px;'>"+commentcaption+" : </td></tr><tr><td><textarea id='comment'  rows='6' style='border:1px solid #d3d3d3;width:100%; margin-top:8px'></textarea>" +
	"<br/><br/><a id='quickbutton' href='javascript:$.noop()'  title='Исполнено' class='button-auto-value'>Напоминаю вам о задании...</a>"+
	"</td></tr></table></div>";
	divhtml += "<div id='btnpane' class='button_panel' style='margin:2%; text-align:right;'>";
	divhtml += "<button onclick='javascript:remindOk("+key+","+doctype+")' style='margin-right:5px'><font class='button_text'>ОК</font></button>" 
	divhtml += "<button onclick='pickListClose()'><font class='button_text'>"+cancelcaption+"</font></button>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist #btnpane").children("button").button();
	$("#quickbutton").attr("onclick","javasript:addquickanswer('comment','Напоминаю вам о задании...',this)")
			.attr("onmouseover","javasript:previewquickanswer('comment','Напоминаю вам о задании...',this)")
			.attr("onmouseout","javasript:endpreviewquickanswer('comment','Напоминаю вам о задании...',this)")
	$("#comment").attr("onkeydown","javasript:resetquickanswerbutton()")
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div class='ui-widget-overlay blockWindow' id='blockWindow'/>"; 
	$("body").append(blockWindow).css("cursor","wait");
	$('#blockWindow').css({"width":$(document).width(), "height":$(document).height(), "display":"block"}); 
	$('#picklist').css('display',"none");
	$("#headertext").text(remindcaption);
	$("#contentpane").html($("#executers").html());
	$("#contentpane table").css("text-align","left").css('display', "inline")
	$('#picklist').css('display', "inline-block");
	$("body").css("cursor","default")
	$('#picklist').focus();
}

/* обработчик нажатия кнопки "ок" a окне "напомнить"*/	
function remindOk(key,doctype){
	var k=0,
		chBoxes = $('input[name=chbox]'); 
	if ($("#comment").val().length == 0){
		infoDialog ("Поле 'Комментарий' не заполнено")
	}else{
		for( var i = 0; i < chBoxes.length; i ++ ){
			if (chBoxes[i].checked){ 
				if (k==0){
					form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
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
			submitFormDecision ("remind")
			pickListClose(); 
		}else{
			infoDialog(choosevalue);
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
	divhtml +="<div style='font-size:13px; text-align:left; margin-top:10px'>&#xA0;&#xA0;"+correspforacquaintance+":</div>" ;
	divhtml +="<div id='contentpane' style='overflow:auto; border:1px solid #d3d3d3; height:250px; width:95%; margin:10px;'>Загрузка данных...</div>";    
	divhtml +="<div id='divComment' style='text-align:left; font-size:13px; width:97.5%; margin:10px'>";
	divhtml +="<table width='98%'><tr><td style='font-size:13px'>"+commentcaption+": </td></tr><tr><td><textarea id='comment' rows='6' style='width:100%; border:1px solid #d3d3d3; margin-top:8px'></textarea></td></tr></table></div>"
	divhtml += "<div id='btnpane' class='button_panel' style='margin-top:2%; text-align:right; margin:2%'>";
	divhtml += "<button onclick='javascript:acquaintOk("+key+","+doctype+")' style='margin-right:5px'><font class='button_text'>ОК</font></button>" 
	divhtml += "<button onclick='pickListClose()'><font class='button_text'>"+cancelcaption+"</font></button>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist #btnpane").children("button").button();
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div  class='ui-widget-overlay blockWindow' id='blockWindow'></div>"; 
	$("body").append(blockWindow).css("cursor","wait");
	$('#blockWindow').css('width',$(document).width()).css('height',$(document).height()).css('display',"block"); 
	$('#picklist').css('display', "none");
	$("#headertext").text(acquaintcaption);
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=bossandemppicklist',
		success:function (data){
			$("#contentpane").html(data);
			searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font> <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>" 
				$("#contentpane div").removeAttr("ondblclick").removeAttr("onmouseover").removeAttr("onmouseout")		
				$("#divSearch").append(searchTbl);
			$('#btnChangeView').attr("href","javascript:changeViewAcquaint(2,"+key+","+doctype+")");
			$('#picklist').css('display', "inline-block");
			$("body").css("cursor","default")
			$('#contentpane').disableSelection();		
			$('#searchCor').focus()
		}
	});
}

/* обработчик нажатия кнопки "ок" a окне "ознакомить"*/	
function acquaintOk(key,doctype){
	var k=0,
		chBoxes = $('input[name=chbox]'); 
	if ($("#comment").val().length == 0){
		infoDialog ("Поле 'Комментарий' не заполнено")
	}else{
		for( var i = 0; i < chBoxes.length; i ++){
			if (chBoxes[i].checked){ 
				if (k==0){
					form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
					$("body").append(form);
				}
				new FormData('grantusers', chBoxes[i].id); 
				k++		 	
			}
		}
		if (k>0){
			new FormData('type','handler'); 
			new FormData('id',"grant_access"); 
			new FormData('key',key);
			new FormData('doctype',doctype);
			new FormData('comment',$("#comment").val());
			submitFormDecision("acquaint")
			pickListClose(); 
		}else{
			infoDialog(choosevalue);
		}
	}
}

/* смена вида в окне "ознакомить"*/
function changeViewAcquaint(viewType,key,doctype){
	if (viewType==1){
		$.ajax({
			type: "get",
			url: 'Provider?type=view&id=bossandemppicklist',
			success:function (data){
				$("#contentpane").html(data);
				searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font>";
				searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
				$("#divSearch").append(searchTbl);
				$('#btnChangeView').attr("href","javascript:changeViewAcquaint(2,"+key+","+doctype+")");
				$(document).ready(function(){ $('#picklist').disableSelection(); });
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display',"inline-block");
				$('#searchCor').focus()
				$("#contentpane").ajaxSuccess(function(evt, request, settings){
					$("#contentpane div").removeAttr("ondblclick").removeAttr("onmouseover").removeAttr("onmouseout")
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
				$("#contentpane").html(data);
				$("#divSearch").empty();
				$(document).ready(function(){ $('#picklist').disableSelection();});
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
	var notEmpty = false,
		ce = $(el),
		left_offset_position = ce.offset().left,
		bottom_offset_position = ce.offset().top +35; 
	$.ajax({
		type: "get",
		url: 'Provider?type=service&operation=users_which_read&id=users_which_read&doctype='+doctype+"&key="+id,
		success:function (xml){
			if (!$("#userWhichRead").length){
				$("body").append("<div id='userWhichRead' class='userwichread'/>");
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
		url: 'Provider?type=service&operation=users_which_read&id=users_which_read&doctype='+doctype+"&key="+id,
		cache:false,
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
	if($(el).width() > $("#property").width() - $(".fc").first().width()-50 ){
		$(el).css("width",$("#property").width() - $(".fc").first().width()-50 + "px")
		$(el).parent("div").css("width",$("#property").width() - $(".fc").first().width()-10 + "px")
	}
}

$(function($) {
	$.datepicker.regional['ru'] = {
		dateFormat : 'dd.mm.yy',
		firstDay : 1,
		isRTL : false,
		showMonthAfterYear : false,
		yearSuffix : ''
	};
	$.datepicker.setDefaults($.datepicker.regional['ru']);
});