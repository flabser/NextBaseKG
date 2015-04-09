var lang = "RUS";
var fieldIsValid = true;
var alertmessage = '';
/* переменные для перевода диалогов */
var acquaintcaption = "Ознакомить"; 
var remindcaption = "Напомнить"; 
var cancelcaption = "Отмена"; 
var changeviewcaption = "Изменить вид"; 
var receiverslistcaption = "Список получателей напоминания"; 
var correspforacquaintance = "Список корреспондентов для ознакомления"; 
var searchcaption = "Поиск"; 
var commentcaption = "Комментарий"; 

function enabledChbox (name){
	$("input[name="+name+"]").attr("checked","true");
}

/* ограничение количества ввода символов в поле*/
function maxCountSymbols (el, count, e, warn){
	if ($(el).val().length > count){
		if ((e.keyCode == 46) || (e.keyCode == 8) ||  (e.keyCode > 36 && e.keyCode < 41) ) {
			if (e.keyCode == 8 && $("#warntext").is(":visible")){
				$("#warntext").remove()
			}
		}else{
			 e.returnValue = false;
			 if(!$("#warntext").is(":visible") && warn==true){
				 $(el).parent().append("<font id='warntext' style='color:red; font-size:11px; margin-left:5px; line-height:20px'>Длина поля не должна превышать "+count+" символов</font>")
			 }
		}
	} 
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

function sendMessageToUser(user){
	var fields = $('#messageform').serializeArray();
	var recursiveEncoded = $.param(fields);
	$.ajax({
		url: 'Provider?type=service&operation=sendmessage&id='+user,
		data: recursiveEncoded,
		success: function(data) {}
	});	
}

function fillingReport(){
	var fields = $('form').serializeArray();
	var formData = $("form").serialize();
	var recursiveEncoded = $.param(fields);
	window.location.href = 'Provider?type=handler&id=filling_report&'+recursiveEncoded;
}

/* кнопка "назад"*/
function CancelForm(url,grandparform) {
	if (url != null && url.length !=0 ){
		window.location.href=url
	}else{
		if (grandparform !=''){
			switch (grandparform) {
			   case 'SZ':
				   window.location.href = "Provider?type=outline&id=outline&subtype=view&subid=sz"
			      break;
			   case 'IN':
				   window.location.href = "Provider?type=outline&id=outline&subtype=view&subid=in"
				   break;
			   case 'KR':
				   window.location.href = "Provider?type=outline&id=outline&subtype=view&subid=tasks"
				   break;
			   default:
				   window.location.href = "Provider?type=outline&id=outline&subtype=view&subid=in"
			      break;
			}
		}else{
			window.history.back()
		}
	}
}

function fieldOnFocus(field) {
	field.style.backgroundColor = '#FFFFE4';
}

function fieldOnBlur(field) {
	field.style.backgroundColor = '#FFFFFF';
}

/* функция снятия с контроля*/
function controlOff(pos){
	$("#idCorrControlOff"+pos).html($("#localusername").val());
	var time=new Date();
	month=time.getMonth()+1;
	day=time.getDate();
	hours=time.getHours();
	minute=time.getMinutes();
	if (month< 10){month="0"+month;}
	if (day<10){day="0"+ time.getDate();}
	if (hours<10){hours="0"+time.getHours();}
	if (minute<10){minute="0"+time.getMinutes();}
	execpercent= $("#exectr"+pos + " #execpercent ").val();
	responsible =$("#exectr"+pos + " #responsible ").val();
	timeOff=day +"."+ month + "." + time.getFullYear()+ " " + hours + ":" + minute ;
	$("#controlOffDate"+pos).text(timeOff);
	$("#switchControl"+pos).html("<a title='Поставить на контроль' href='javascript:controlOn("+pos+")'><img src='/SharedResources/img/classic/tick.gif'/></a>");
	execid=$("#idContrExec"+pos).val();
	idCorrControlOff=$("#currentuser").val();
	$("#controlres"+pos).val( execid +"`"+responsible+"`"+execpercent+"`"+ timeOff+":00" +"`"+idCorrControlOff);
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
	$("#idCorrControlOff"+pos).text(""); 
	$("#controlOffDate"+pos).text("");
	$("#switchControl"+pos).html("<a title='Снять с контроля' href='javascript:controlOff("+pos+")'><img  src='/SharedResources/img/classic/exec_control.gif'/></a>");
	$("#controlres"+pos).val($("#idContrExec"+pos).text()+"` ` ");
}

function infoDialog(text){
	 var myDiv = document.createElement("DIV");
	   divhtml ="<div id='dialog-message' title='Предупреждение'  >";
	   divhtml+="<span style='height:40px; width:100%; text-align:center;'>"+
	   			"<font style='font-size:13px;'>"+text+"</font>"+"</span>";
	   divhtml += "</div>";
	   myDiv.innerHTML = divhtml;
	   document.body.appendChild(myDiv);
	   $("#dialog").dialog("destroy");
	   $( "#dialog-message" ).dialog({
		modal: true,
		buttons: {
			"Ок": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
			}
		}
	});
	$( ".ui-dialog button" ).focus();
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
	var myDiv = document.createElement("DIV");
	divhtml ="<div id='dialog-message' title='"+warning+"'  >";
	divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	"<font style='font-size:13px; '>"+text+"</font>"+"</span>";
	divhtml += "</div>";
	myDiv.innerHTML = divhtml;
	document.body.appendChild(myDiv);
	$("#dialog").dialog("destroy");
	$( "#dialog-message" ).dialog({
		height:140,
		modal: true,
		buttons: {
			"да": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
		    	addComment()
			},
			"нет": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
				submitFormDecision ()
			}
		}
	});
	if (lang == "KAZ"){
		$( "#dialog-message" ).dialog({ buttons: { 
			"иә": function() { 
					$( this ).dialog( "close" );
					$( this ).remove();
					addComment()
				},
			"жоқ": function() { 
					$( this ).dialog( "close" );
					$( this ).remove();
					submitFormDecision ()
				}
			}
		});
	}
	if (lang == "ENG"){
		$( "#dialog-message" ).dialog({ buttons: { 
			"yes": function() { 
				$( this ).dialog( "close" );
				$( this ).remove();
				addComment()
			},
			"no": function() { 
				$( this ).dialog( "close" );
				$( this ).remove();
				submitFormDecision ()
			}
		}
		});
	}
	if (lang == "CHN"){
		$( "#dialog-message" ).dialog({ buttons: { 
			"是否": function() { 
				$( this ).dialog( "close" );
				$( this ).remove();
				addComment()
			},
			"無": function() { 
				$( this ).dialog( "close" );
				$( this ).remove();
				submitFormDecision ()
			}
		}
		});
	}
}

function dialogConfirm (text,el,actionEl){
	 var myDiv = document.createElement("DIV");
	   divhtml ="<div id='dialog-message' title='Предупреждение'  >";
	   divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	   			"<font style='font-size:13px; '>"+text+"</font>"+"</span>";
	   divhtml += "</div>";
	   myDiv.innerHTML = divhtml;
	   document.body.appendChild(myDiv);
	   $("#dialog").dialog("destroy");
	   $( "#dialog-message" ).dialog({
		   height:140,
		   modal: true,
		   buttons: {
			   "Ок": function() {
				   $( this ).dialog( "close" );
				   $( this ).remove();
				   if (el == 'picklist'){
					   $('#blockWindow').css('display',"block")
				   }
				   $('#'+el).css('display', "inline-block");
				   $("."+actionEl).remove();
			},
			"Отмена": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
				if (el == 'picklist'){
					$('#blockWindow').remove()
				}
				$('#'+el).empty();
				$('#'+el).remove();
			}
		}
	});
}

/* сохранение формы */
function SaveFormJquery(typeForm, formName, redirecturl, docType) {
	enableblockform()
	divhtml ="<div id='dialog-message' title='Сохранение'>";
	divhtml+="<div style='margin-top:8px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>Пожалуйста ждите...</font></div>";
	divhtml+="<div style='margin-top:5px'><font style='font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; padding-left:10px'>идет сохранение документа</font></div>";
	divhtml+="<br/><div style='margin-top:5px; text-align:center;'><font style='font-size:14px; font-family:arial; padding-left:10px;'><img src='/SharedResources/img/classic/loading.gif'/></font></div>";
	divhtml+="</div>";
	$("body").append(divhtml);
	$("#dialog").dialog("destroy");
	$("#dialog-message").dialog({
		modal: false,
		height:150,
		title:"Уведомление"
	});
	var formData = $("form").serialize();
	$.ajax({
		type: "POST",
		url: 'Provider',
		data: $("form").serialize(),
		success:function (xml){ 
			redir = $(xml).find('history').find("entry[type=outline]:last").text();
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
					msgtext = msgtext || "Документ сохранен";
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
}

/*set of upload function*/
function loadingAttch(tableID){
	$("#"+tableID).append("<tr id='loading_attach'><td></td><td><div style='position:absolute; z-index:999'><img  src='/SharedResources/img/classic/progress_bar_attach.gif'></div></td></tr>")
	blockWindow = "<div  class = 'blockWindow' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$("body").css("cursor","wait")
}

/* добавление приложений в форму */
function submitFile(form, tableID, fieldName) {
	if ($('#'+fieldName).attr('value') == '') {
		alert('Укажите имя файла для вложения');
	} else {
		loadingAttch(tableID)
		form = $('#'+form);
		var frame = createIFrame();
		frame.onSendComplete = function() {
			uploadComplete(tableID, getIFrameXML(frame));
			$("#loading_attach").remove();
			$('#loadingpage').remove();
			$('#blockWindow').remove();
			$("body").css("cursor","default")
		};
		form.attr('target', frame.id);
		form.submit();
		$("#upload")[0].reset();
		//form.reset();
	}
}

function createIFrame() {
	var id = 'f' + Math.floor(Math.random() * 99999);
	var div = document.createElement('div');
	var divHTML = '<iframe style="display:none" src="about:blank" id="' + id
			+ '" name="' + id + '" onload="sendComplete(\'' + id
			+ '\')"></iframe>';
	div.innerHTML = divHTML;
	document.body.appendChild(div);
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
	var xmldoc = doc.documentElement;
	var st = xmldoc.getAttribute('status');
	var msg = xmldoc.getElementsByTagName('BODY');
	d=$("BODY", doc).text();
	
	var Url = {
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
					}else {
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
					}else {
						c2 = utftext.charCodeAt(i+1);
						c3 = utftext.charCodeAt(i+2);
						string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
						i += 3;
					}
				}
				string=string.substring(0, string.length - 3)
				return string;
			}
	}
	if($.browser.mozilla)
	{
		encd=d;
	}else{
		encd= Url.encode(d)
		encd=encd.substring(0, encd.length - 3)
	}
	if (st = 'ok') {
		tableid='#'+tableID;
		var table = $(tableid);
		sesid=$(doc).find("message").attr('formsesid');
		var range = 200 - 1 + 1;
		detectExtAttach(d); //определение расширения
		fieldid=Math.floor(Math.random()*range) + 1;;
		$(table).append("<tr id='"+ fieldid + "'>" +
				"<td></td>" +
				"<td >" +
				"<img class='newimageatt' onerror='javascript:changeAttIcon(this)' onload='$(this).removeClass()' src='/SharedResources/img/iconset/file_extension_"+ ext +".png' style='margin-right:5px'><a href='Provider?type=getattach&formsesid="+ sesid+"&field=rtfcontent&file="+encd+"' style='vertical-align:6px'>"+ d +"</a>&#xA0;&#xA0;" +
				"<a href='javascript:deleterow("+sesid +",&quot;"+ d +"&quot;,"+ fieldid +")'><img src='/SharedResources/img/iconset/cross.png' style='width:10px; height:10px; vertical-align:6px'/></a>" +
		"</td><td></td</tr>");
	
	} else {
		alert('Произошла ошибка на сервере при выгрузке файла');
	}
}

function changeAttIcon(el){
	$(el).attr("src","/SharedResources/img/iconset/file_extension_undefined.png");
	$(el).removeClass()
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
	ext=d.substring(fileLen +1, file.length).replace(RegEx, "").toLowerCase();
	
return ext;
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
			/*$.cookie("pagesize",$("select[name='countdocinview']").val(),{ path:"/", expires:30});	
			if ($("#history_vis").is(":checked")){
				historyval="history_on";
			}else{
				historyval="history_off";
			}
			$.cookie("history",historyval ,{ path:"/", expires:30 });	*/	
			if (redir == '' ){
				window.history.back();
			}else{
				window.location = redir;
			}
		},
		error:function (xhr, ajaxOptions, thrownError){
           if (xhr.status == 400){
        	  if( xhr.responseText.indexOf("Old password has not match")!=-1){
        		  infoDialog("Некорректно заполнено поле 'старый пароль'")
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
			$("#markDocRead").animate({backgroundColor: '#ffff99'}, 500);
			$("#markDocRead").html("&#xA0; Прочтен");
			$("#markDocRead").animate({backgroundColor: '#ffffdd'}, 1000);
		}
	});
}

function deleterow(sesid,filename, fieldid){
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
	divhtml +="<div id='contentpane'   style='overflow:auto;  border:1px solid  #a6c9e2; padding-top:10px; width:95%; margin:10px; height:250px;' >Загрузка данных...</div>"; 
	divhtml +="<div id='divComment' style='text-align:left; margin:10px; font-size:13px; width:95%'><table width='100%'><tr><td style='font-size:13px;'>"+commentcaption+" : </td></tr><tr><td><textarea id='comment'  rows='6' style='border:1px solid #a6c9e2;width:100%; margin-top:8px'></textarea></td></tr></table></div>"
	divhtml += "<div  id = 'btnpane' class='button_panel' style='margin:2%; text-align:right;'>";
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:remindOk("+key+","+doctype+")' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" 
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='pickListClose()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
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
		alert ("Поле 'Комментарий' не заполнено")
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
			alert('Выберите значение');
		}
	}
}

/* функция ознакомить*/
function acquaint(key,doctype){
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' class='headertext'></font>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose(); '/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:10px; margin-left:78%'>";
	divhtml +="<a id='btnChangeView' class='actionlink' href='javascript:changeViewAcquaint(1,"+key+","+doctype+")'><font style='font-size:11px'>"+changeviewcaption+"</font></a></div>";
	divhtml +="<div id='divSearch' class='divSearch' display='inline-block'></div>" ;
	divhtml +="<div style='font-size:13px; text-align:left; margin-top:10px'>&#xA0;&#xA0;"+correspforacquaintance+":</div>" ;
	divhtml +="<div id='contentpane' style='overflow:auto; border:1px solid  #a6c9e2; height:250px; width:95%; margin:10px;' >Загрузка данных...</div>";    
	divhtml +="<div id='divComment' style='text-align:left; font-size:13px; width:97.5%; margin:10px'>" ;
	divhtml +="<table width='98%'><tr><td style='font-size:13px'>"+commentcaption+": </td></tr><tr><td><textarea id='comment'  rows='6' style='width:100%; border:1px solid #a6c9e2; margin-top:8px'></textarea></td></tr></table></div>"
	divhtml += "<div  id = 'btnpane' class='button_panel' style='margin-top:2%; text-align:right; margin:2%'>";
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='javascript:acquaintOk("+key+","+doctype+")' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" 
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='pickListClose()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$("body").css("cursor","wait")
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$('#picklist').css('display', "none");
	$("#headertext").text(acquaintcaption);
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=bossandemppicklist',
		success:function (data){
			$("#contentpane").text('');
			$("#contentpane").append(data);
			searchTbl =
				"<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font> <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>" 
				$("#contentpane div").removeAttr("ondblclick")		
				$("#contentpane div").removeAttr("onmouseover")		
				$("#contentpane div").removeAttr("onmouseout")		
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
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	if ($("#comment").val().length == 0){
		alert ("Поле 'Комментарий' не заполнено")
	}else{
		for( var i = 0; i < chBoxes.length; i ++ ){
			if (chBoxes[i].checked){ 
				if (k==0){
					form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
						$("body").append(form);
				}
				new FormData('grantusers', chBoxes[i].id); 
				k++		 	
			}
		}
		if (k>0){
			new FormData('type', 'handler'); 
			new FormData('id', "grant_access"); 
			new FormData('key', key);
			new FormData('doctype', doctype);
			new FormData('comment', $("#comment").val());
			submitFormDecision ()
			pickListClose(); 
		}else{
			alert('Выберите значение');
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
				$("#contentpane").text('');
				$("#contentpane").append(data);
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
					$("#contentpane div").removeAttr("ondblclick")
					$("#contentpane div").removeAttr("onmouseover")		
					$("#contentpane div").removeAttr("onmouseout");
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
				$("#contentpane").text('');
				$("#contentpane").append(data);
				$("#divSearch").empty();
				// запрещаем выделение текста
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display', "inline-block");
				$("#contentpane").ajaxSuccess(function(evt, request, settings){
					$("#contentpane td").removeAttr("ondblclick")
					$("#contentpane tr").removeAttr("onmouseover")		
					$("#contentpane tr").removeAttr("onmouseout")
					$("#contentpane tr").removeAttr("onmouseout")
				});
			}
		});
	}
}

/* функция для отображения списка прочитавших текущий документ */
function usersWhichRead(el,doctype, id){
	notEmpty = false;
	var сe = $(el);
	var left_offset_position = сe.offset().left ; 
	var bottom_offset_position = сe.offset().bottom - 25; 
	$.ajax({
		type: "get",
		url: 'Provider?type=service&operation=users_which_read&doctype='+doctype+"&key="+id,
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
					$("#userWhichRead").css("left",left_offset_position );
					$("#userWhichRead").css("bottom",25);
					$("#userWhichRead").css("display","inline-block");
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
				if ($(this).attr('username') != undefined){
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