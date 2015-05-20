var tableField;
var hiddenField;
var formName;
var entryCollections = new Array();

var queryOpt = {
	queryname:'',
	formname:'',
	fieldname:'',
	isMultiValue:'',
	tablename:'',
	pagenum:'1',
	keyword:'',
	dialogview:'1'
} 

function keyDown(el,event){
	if(event.keyCode==27){
		$("#"+el).css("display","none").empty().remove();
		$("#blockWindow").remove();
	}
	if(event.keyCode==13){
		if (el !='coordParam'){
			pickListBtnOk()
		}else{
			coordOk()
		}
	}
}

function pickListSingleOk(docid){
	$("#"+docid).attr("value")
	text=$("#"+docid).attr("value");
	$("input[name="+ queryOpt.fieldname +"]").remove();
	if (queryOpt.fieldname == 'executor'){
		$("#intexectable tr:gt(0)").remove();
		$("input [name=executor]").remove();
		num=$("#intexectable tr").length;
		addExecutorField(num,docid);
		$('#intexectable').append("<tr>" +
				"<td style='text-align:center'>"+num+"</td>" +
				"<td>"+text+"<input  type='hidden' id='idContrExec"+num+"' value='"+docid+"'/></td>" +
				"<td id='controlOffDate"+num+"'></td>" +
				"<td id='idCorrControlOff"+num+"'></td>" +
				"<td id='switchControl"+num+"'><a href='javascript:controlOff("+num+")'><img  title='Ð¡Ð½Ñ�Ñ‚ÑŒ Ñ� ÐºÐ¾Ð½Ñ‚Ñ€Ð¾Ð»Ñ�' src='/SharedResources/img/classic/exec_control.gif'/><a/></td>" +
		"</tr>");
	}else if(queryOpt.queryname == 'project-list'){
		$("input[name=parentdocid]").val(docid);
		name=$("#"+docid).prev(".projectinfo").val();
		prjid=$("#"+docid).prev(".projectinfo").attr("id");
		prjdocid=$("#"+docid).prev(".projectinfo").attr("name");
		$("#projectname").val(name.replace("\"","'"))
		$("#projectid").val(prjid)
		$("#projectdocid").val(prjdocid)
	}else{ 
		$("#frm").append("<input type='hidden' name='"+ queryOpt.fieldname +"'  id='"+queryOpt.fieldname+"' value='"+docid+"'>")
	}
	if(queryOpt.fieldname == 'corr' || queryOpt.fieldname == 'recipient' && queryOpt.queryname == 'corrcat'  ){
		newTable="<table id='"+ queryOpt.tablename +"'  width='500px' style='border:1px solid #ccc; margin-top:2px'><tr><td >"+ text +"<span style='float:right; border-left:1px solid #ccc; width:20px; padding-right:10px; padding-left:2px; padding-top:1px; color:#ccc; font-size:11px'>"+docid+"</span></td></tr></table>"
	}else if(queryOpt.queryname == 'project-list'){
		var m_data = text.split('#`');
		$("#parentProjectfont").html(m_data[0])
		$("#projectURL").attr("href",m_data[1]).attr("style","display:block");
		$("#parentMilestonefont").html(m_data[2]);		 
		$("#milestoneURL").attr("href",m_data[3]).attr("style","display:block");
		queryOpt.tablename = "";
		newTable = ""
	}else{
		newTable="<table style='border-collapse:collapse' id='"+ queryOpt.tablename +"'><tr><td width='500px' class='td_editable'>"+ text +"</td></tr></table>"
	}
	$("#"+ queryOpt.tablename).replaceWith(newTable)
	pickListClose(); 
}

function pickListBtnOk(){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	var chDocinfo = $('input[name=docinfo]'); 
	var hidfields = $("#executorsColl").children("input[type=hidden]"); 
	
		 
		for( var i = 0; i < chBoxes.length; i ++ ){ 
			if (chBoxes[i].checked){  
				if (k==0){
					newTable="<table id="+ queryOpt.tablename +"  width='100%' ></table>"
					$("#"+ queryOpt.tablename).replaceWith(newTable)
					$("input[name="+queryOpt.fieldname+"]").remove();
				}
				k=k+1;
				$("#"+ queryOpt.tablename).append("<tr><td style='border:1px solid #ccc;width:600px' class='td_editable'>"+chBoxes[i].value+"</td><td><a target='blank' href='"+chDocinfo[i].value+"'><img src='/SharedResources/img/iconset/world_go.png' /></a></td></tr>");
				if (queryOpt.fieldname == "linked_docs"){						 
					//$("[name="+queryOpt.fieldname+"]").remove();
					$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+chBoxes[i].id+"'>")
					// add links here
				}else{ 
					$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+chBoxes[i].id+"'>")
				}
			}
		}
	
	if (k>0){
		pickListClose();  
	}else{
		if ($.cookie("lang")=="RUS" || !$.cookie("lang"))
			msgtxt ="Выберите значение";
		else if ( $.cookie("lang")=="KAZ")
			msgtxt ="Мәндi таңдаңыз";
		else if ( $.cookie("lang")=="ENG")
			msgtxt ="Select value";
		else if ( $.cookie("lang")=="CHN")
			msgtxt ="选择";
		
		infoDialog(msgtxt);
	}
}

function pickListClose(){ 
	$("#picklist").empty().remove();
	$('#blockWindow').remove();
	//$('#picklist').enableSelection();
	if (queryOpt.fieldname == 'executor'){
		$("#content").focus().blur().focus();
	}
}

/* Ð²Ñ‹Ð±Ð¾Ñ€ Ð¾Ð´Ð½Ð¾Ð³Ð¾ ÐºÐ¾Ñ€Ñ€ÐµÑ�Ð¿Ð¾Ð½Ð´ÐµÐ½Ñ‚Ð°*/
function pickListSingleCoordOk(docid){ 
	text=$("#"+docid).attr("value");
	$("input[name=coorder]").remove();
	$("#frm").append("<input type='hidden' name='coorder'  id='coorder' value='"+docid+"'>")
	newTable="<table id='coordertbl' width='100%'><tr><td>"+ text +"</td></tr></table>"
	$("#coordertbl").replaceWith(newTable);
	closePicklistCoord();  
}

/* Ð·Ð°ÐºÑ€Ñ‹Ñ‚Ð¸Ðµ Ð´Ð¸Ð°Ð»Ð¾Ð³Ð¾Ð²Ð¾Ð³Ð¾ Ð¾ÐºÐ½Ð°*/
function closePicklistCoord(){
	$("#picklist").remove();
	$("#blockWindow").css('z-index','2');
}

/* Ð²Ñ‹Ð²Ð¾Ð´ Ð¾ÐºÐ½Ð° Ð¿Ð¾Ñ�ÐµÑ€ÐµÐ´Ð¸Ð½Ðµ Ñ�ÐºÑ€Ð°Ð½Ð°  */
function centring(id,wh,ww){
	var w=$(window).width(); 
	var h=$(window).height();
	var winH=$('#'+id).height(); 
	var winW=$('#'+id).width();
	var scrollA=$("body").scrollTop(); 
	var scrollB=$("body").scrollLeft();
	htop=scrollA+((h/2)-(winH/2))
	hleft=scrollB+((w/2)-(winW/2))
	$('#'+id).css('top',htop).css('left',hleft) ;
}

/*Ñ„ÑƒÐ½ÐºÑ†Ð¸Ñ� Ð´Ð»Ñ� Ð¾Ð±ÐµÑ�Ð¿ÐµÑ‡ÐµÐ½Ð¸Ñ� rollover*/
function entryOver(cell){
	cell.style.backgroundColor='#FFF1AF';
}

/*Ñ„ÑƒÐ½ÐºÑ†Ð¸Ñ� Ð´Ð»Ñ� Ð¾Ð±ÐµÑ�Ð¿ÐµÑ‡ÐµÐ½Ð¸Ñ� rollover*/
function entryOut(cell){
	cell.style.backgroundColor='#FFFFFF';
}

/* Ñ„ÑƒÐ½ÐºÑ†Ð¸Ñ� Ð´Ð»Ñ� Ð·Ð°Ð³Ñ€ÑƒÐ·ÐºÐ¸ ÐºÐ¾Ñ€Ñ€ÐµÑ�Ð¿Ð¾Ð½Ð´ÐµÐ½Ñ‚Ð¾Ð² Ð² Ñ„Ð¾Ñ€Ð¼Ñƒ Ñ�Ð¾Ð·Ð´Ð°Ð½Ð¸Ñ� Ð±Ð»Ð¾ÐºÐ¾Ð² Ñ�Ð¾Ð³Ð»Ð°Ñ�Ð¾Ð²Ð°Ð½Ð¸Ñ� */
function picklistCoordinators(){
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=bossandemp',
		success:function (data){
			if(data.match("html")){
				window.location="Provider?type=static&id=start&autologin=0"
			}
			$("#contentpane").attr("innerText",'');
			$("#contentdiv").append(data);
			$('#searchCor').focus();
		}
	});
}

var elementCoord;

function closeDialog(el){
	$("#"+el).empty().remove();
	$("#blockWindow").remove();
}

function fastCloseDialog(){
	$("#picklist").css("display","none");
}

function enableblockform(){
	blockWindow = "<div class='ui-widget-overlay' id = 'blockWindow'/>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(window).width()).css('height',$(window).height()).css('display',"block"); 
}

function disableblockform(){
	$('#blockWindow').remove(); 
}

function dialogBoxStructure(query,isMultiValue, field, form, table) {
	enableblockform()
	queryOpt.fieldname = field;
	queryOpt.formname = form;
	queryOpt.isMultiValue = isMultiValue;
	queryOpt.queryname = query;
	queryOpt.tablename = table;
	_type= 'view';
	if(query == "articlelist"){
		_type = "page"
		 
	}
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el,event);'>";
	divhtml +="<div  class='header'><font id='headertext' class='headertext'></font>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose(); '/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:-10px'><div id='divSearch' class='divSearch' style='display:inline-block; float:left; width:360px'></div>" 
	divhtml +="<div  style='display:inline-block ; float:right; width:100px; margin-top:20px'><a class='actionlink' id='btnChangeView' href='javascript:changeViewStructure(1)' style='margin-top:50px'><font style='font-size:11px'>"+changeviewcaption+"</font></a></div></div>";
	divhtml +="<div id='contentpane' class='contentpane'>Ð—Ð°Ð³Ñ€ÑƒÐ·ÐºÐ° Ð´Ð°Ð½Ð½Ñ‹Ñ…...</div>";  
	divhtml += "<div id='btnpane' class='button_panel' style='margin-top:8%; margin:15px 15px 0; padding-bottom:15px;text-align:right;'>";
	divhtml += "<button onclick='pickListBtnOk()' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>Ок</font></span></button>" 
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='pickListClose()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>";    
	divhtml += "</div><div id='executorsColl' display='none'></div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	$("#picklist").focus().css('display', "none");
	$("#headertext").text($("#"+field).attr("title"))
	$("body").css("cursor","wait")
	$.ajax({
		type: "get",
		url: 'Provider?type='+_type+'&id='+query+'&keyword='+queryOpt.keyword+'&page='+queryOpt.pagenum,
		success:function (data){
			if (data.match("login") && data.match("password")){
				text="Cессия пользователя была закрыта, для продолжения работы необходима повторная авторизация"
				func = function(){window.location.reload()};
				dialogAndFunction (text,func)
			}else{
				if (isMultiValue=="false"){
					while(data.match("checkbox")){
						data=data.replace("checkbox", "radio");
					}
				}
				$("#contentpane").html(data);
				$("#searchTable").remove();
				if(isMultiValue=="false"){
					$("#contentpane").append("<input type='hidden' id='radio' value='true'/>");
				}else{
					$("#contentpane").append("<input type='hidden' id='radio' value='false'/>");
					$("div[name=itemStruct] input[type=checkbox]").click(function(){
						addToCollectExecutor(this)
					});
				}
				  
				if(queryOpt.fieldname == 'executer'){
					searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font>";
					searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
					$("#divSearch").append(searchTbl);
				}else{
					searchTbl ="<font style='vertical-align:3px;   margin-left:8%'><b>"+searchcaption+":</b></font>";
					searchTbl +=" <input type='text' id='searchCor' style=' margin-left:3px;margin-bottom:10px' size='34' onKeyUp='findCorStructure()'/>"; 
					$("#divSearch").append(searchTbl);
				} 
				// Запрещаем выделение текста
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				if ($("#coordTableView tr").length > 1 &&  field == 'signer'){
					textConfirm="При изменении поля 'Кем будет подписан' существующие блоки согласования будут удалены";
					dialogConfirm (textConfirm, "picklist","trblockCoord")
				}else{
					$('#blockWindow').css('display',"block")
					$('#picklist').css('display', "inline-block");
				}
				$('#picklist').focus()
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
	$("body").css("cursor","default")
}

function delmember(el){
	var member = $(el).parent("td").parent("tr").parent("tbody");
	if (member.children("tr").length == 1){
		$(el).parent("td").html(" &#xA0; ");}
	else{
		$(el).parent("td").parent("tr").remove();
	}		
}

function addMemberSingleOk(docid){
	$("#"+docid).attr("value")
	text=$("#"+docid).attr("value");
	newtr="<tr><td style='width:600px;' class='td_editable'>"+ text +"<input type='hidden' name='"+ queryOpt.fieldname +"'  id='"+queryOpt.fieldname+"' value='"+docid+"'><img style='width:15px; height:15px; margin-right:3px; margin-top:1px; float:right; cursor:pointer' src='/SharedResources/img/iconset/cross.png' onclick='delmember(this)'></td></tr>"
	$("#"+ queryOpt.tablename).append(newtr)
	if ($("#"+ queryOpt.tablename+" tr:first td input").length == 0){
		$("#"+ queryOpt.tablename+" tr:first").remove()
	}
	pickListClose(); 
}

function addMemberBtnOk(){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	var hidfields = $("#executorsColl").children("input[type=hidden]"); 
	var chEmpty= $("#"+ queryOpt.tablename+"tr:first td input");
	for(var i = 0; i < chBoxes.length; i ++ ){
		if (chBoxes[i].checked && $(chBoxes[i]).attr("id") != ''){
			if (k==0){
				newTable="<table id="+ queryOpt.tablename +"></table>"
			}
			k=k+1;
			$("#"+ queryOpt.tablename).append("<tr><td style='width:490px;' class='td_editable'>"+chBoxes[i].value+"<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+chBoxes[i].id+"'><img style='width:15px; height:15px; margin-right:3px; margin-top:1px; float:right; cursor:pointer' src='/SharedResources/img/iconset/cross.png' onclick='delmember(this)'></td></tr>");
			$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+chBoxes[i].id+"'>")
		}
	}
	if (k>0){
		if($("#"+ queryOpt.tablename+" tr:first td input").val()==''){
			$("#"+ queryOpt.tablename+" tr:first").remove()
		}
		pickListClose();  
	}else{
		if($.cookie("lang")=="RUS" || !$.cookie("lang"))
			msgtxt ="Выберите значение";
		else if($.cookie("lang")=="KAZ")
			msgtxt ="Мәндi таңдаңыз";
		else if($.cookie("lang")=="ENG")
			msgtxt ="Select value";
		else if($.cookie("lang")=="CHN")
			msgtxt ="选择";
		
		infoDialog(msgtxt);
	}
}

function addMemberGroup(query,isMultiValue, field, form, table) {
	enableblockform()
	queryOpt.fieldname = field;
	queryOpt.formname = form;
	queryOpt.isMultiValue = isMultiValue;
	queryOpt.queryname = query;
	queryOpt.tablename = table;
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' class='headertext'></font>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/iconset/cross.png' onclick='pickListClose(); '/>";
	divhtml +="</div></div>" 
	divhtml +="<div id='contentpane' class='contentpane'>Загрузка данных...</div>";  
	divhtml += "<div id='btnpane' class='button_panel' style='margin-top:8%; margin:15px 15px 0; padding-bottom:15px;text-align:right;'>";
	divhtml += "<button onclick='addMemberBtnOk()' class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' style='margin-right:5px'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>ОК</font></span></button>" 
	divhtml += "<button class='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only' onclick='pickListClose()'><span class='ui-button-text'><font style='font-size:12px; vertical-align:top'>"+cancelcaption+"</font></span></button>";    
	divhtml += "</div><div id='executorsColl' display='none'></div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	$("#picklist").focus()
	$('#picklist').css('display', "none");
	$("#headertext").text($("#"+field+"caption").val());
	$("body").css("cursor","wait")
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+query+'&keyword='+queryOpt.keyword+'&page='+queryOpt.pagenum,
		success:function (data){
			if (data.match("login") && data.match("password")){
				text="Cессия пользователя была закрыта, для продолжения работы необходима повторная авторизация"
				func="reload";
				dialogAndFunction(text,func)
			}else{
				if (isMultiValue=="false"){
					while(data.match("checkbox")){
						data=data.replace("checkbox", "radio");
					}
				}
				$("#contentpane").html(data);
				$("#searchTable").remove();
				if (isMultiValue=="false"){
					$("#contentpane").append("<input type='hidden' id='radio' value='true'/>");
				}else{
					$("#contentpane").append("<input type='hidden' id='radio' value='false'/>");
					$("div[name=itemStruct] input[type=checkbox][id != '']").click(function(){
						addToCollectExecutor(this)
					});
				}
				// запрещаем выделение текста
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display',"inline-block").focus();
				
				$("div[name=itemStruct]").each(function(){
					$(this).children(".font").attr("onClick","addMemberSingleOk('"+$(this).children("input[name=chbox]").attr("id") +"')")
				})
				$("input[name="+field+"]").each(function(){
					$("input[name=chbox][id="+$(this).val()+"]").attr("disabled","disabled");
					$("input[name=chbox][id="+$(this).val()+"]").parent("div").removeAttr("ondblclick").removeAttr("onmouseover").removeAttr("onmouseout").css("color","#ccc");
				})
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
	$("body").css("cursor","default")
}

function addToCollectExecutor(el){
	if($(el).is(':checked') && $(el).attr("id") != ''){
		$("#executorsColl").append("<input type='hidden' id='"+$(el).attr("id")+"' value='"+$(el).val() +"'/>")
	}else{
		$("#executorsColl").children("#"+$(el).attr("id")).remove();
	}
	$("#executorsColl input[type=hidden]:first").attr("class","otv")
}

jQuery.fn.extend({
    disableSelection : function() {
    	this.each(function() {
    		this.onselectstart = function() { return false; };
    		this.unselectable = "on";
    		jQuery(this).css('-moz-user-select', 'none');
    	});
    },
    enableSelection : function() {
    	this.each(function() {
    		this.onselectstart = function() {};
    		this.unselectable = "off";
    		jQuery(this).css('-moz-user-select', 'auto');
    	});
    }
});

function findCorStructure(){
	var value=$('#searchCor').val();
	var len=value.length
	if (len > 0){
		$("div[name=itemStruct]").css("display","none");
		$("#contentpane").find("div[name=itemStruct]").each(function(){
			if ($(this).text().substring(0,len).toLowerCase()== value.toLowerCase()){
				$(this).css("display","block")
			}
		});
	}else{
		$("div[name=itemStruct]").css("display","block");
	}
}
function selectPage(page){
	queryOpt.pagenum = page;
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+ queryOpt.queryname +'&page='+ queryOpt.pagenum +"&keyword="+queryOpt.keyword,
		success:function (data){
			if (queryOpt.isMultiValue == "false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").html(data);
			$('#btnChangeView').attr("href","javascript:changeViewStructure("+queryOpt.dialogview+")");
			$('#searchCor').focus()
		}
	});
}

function changeViewStructure (viewType){
	if (viewType==1){
		switch (queryOpt.queryname){
			case "corresp":
				queryOpt.queryname="corr";
				break;
			case "signers":
				queryOpt.queryname="signers";
				break;
			case "n":
				queryOpt.queryname="n";
				break;
			default:
				queryOpt.queryname="structure";
				break;
		}
		queryOpt.dialogview = 2;
	}else{
		switch (queryOpt.queryname){
			case "corr":
				queryOpt.queryname="corresp";
				break;
			case "corresp":
				queryOpt.queryname="corr";
				break;
			case "signers":
				queryOpt.queryname="signers";
				break;
			case "n":
				queryOpt.queryname="n";
				break;
			default:
				queryOpt.queryname="bossandemppicklist";
				break;
		}
		queryOpt.dialogview = 1;
	}
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+queryOpt.queryname+'&keyword='+queryOpt.keyword+'&page='+queryOpt.pagenum,
		success:function (data){
			if (queryOpt.isMultiValue =="false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").html(data);
			$("#contentpane input[type=checkbox]").click(function(){
				addToCollectExecutor(this)
			});
			if(viewType == 2){
				searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font>";
				if (queryOpt.queryname == 'n'){
					searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='ajaxFind()'/>"; 
				}else{
					searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
				}
				$("#divSearch").append(searchTbl);
			}else{
				$("#divSearch").empty()
			}
			$('#btnChangeView').attr("href","javascript:changeViewStructure("+queryOpt.dialogview+")");
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

function ajaxFind(){
	queryOpt.keyword=$("#searchCor").val()+"*";
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+queryOpt.queryname+'&keyword='+queryOpt.keyword+"&page=1",
		success:function (data){
			if (queryOpt.isMultiValue == "false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").html(data);
			$('#btnChangeView').attr("href","javascript:changeViewStructure(2)");
			$('#searchCor').focus()
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

function expandChapter(query,id,doctype) {
	$.ajax({
		url: 'Provider?type=view&id='+query+'&parentdocid='+id+'&parentdoctype='+doctype+'&command=expand`'+id+'`'+doctype,
		success: function(data) {
			if(queryOpt.isMultiValue == "false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$(".tbl"+id+doctype).append(data);	
			if (doctype == "891"){
				$("input[name=chbox]").removeAttr("style");	
			}
		}
	});	
	$("#a"+id+doctype).attr("href","javascript:collapseChapter('"+query+"','"+id+"','"+ doctype+"')");
	$("#img"+id+doctype).attr("src","/SharedResources/img/classic/minus.gif");
}

function collapseChapter(query,id,doctype){
	$.ajax({
		url: 'Provider?type=view&id='+query+'&parentdocid='+id+'&parentdoctype='+doctype+'&command=collaps`'+id+'`'+doctype,
		success: function(data) {
			$(".tbl"+id+doctype+" tr:[name=child]").remove()
		}
	});
	$("#img"+id+doctype).attr("src","/SharedResources/img/classic/plus.gif");
	$("#a"+id+doctype).attr("href","javascript:expandChapter('"+query+"','"+id+"','"+ doctype+"')");
}

function expandChapterCorr(docid,num,url,doctype, page) {
	el = $(".tblCorr:eq("+num+")");
	$.ajax({
		url:url+"&page="+queryOpt.pagenum,
		dataType:'html',
		success: function(data) {
			$("#contentpane").html(data)
			$("#img"+docid+doctype).attr("src","/SharedResources/img/classic/minus.gif");
			$("#a"+docid+doctype).attr("href","javascript:collapsChapterCorr('"+docid+"','"+num+"','"+ url+"','"+doctype+"','"+page+"')");
		}
	});	
}

function collapsChapterCorr(docid,num,url,doctype, page) {
	el = $(".tblCorr:eq("+num+")");
	$.ajax({
		url:"Provider?type=view&id=corrcat&command=collaps`"+docid+"&page="+ queryOpt.pagenum ,
		dataType:'html',
		success: function(data) {
			$("#contentpane").html(data)
			$("#img"+docid+doctype).attr("src","/SharedResources/img/classic/plus.gif");
			$("#a"+docid+doctype).attr("href","javascript:expandChapterCorr('"+docid+"','"+num+"','"+ url+"','"+doctype+"','"+page+"')");
		}
	});	
}