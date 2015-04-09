var tableField;
var hiddenField;
var formName;
var entryCollections = new Array();
var replaceCoordBlocksConfirm="При изменении поля 'Кем будет подписан' существующие блоки согласования будут удалены";

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

function toggleOrgTreeStructure(elid){
	if ($(".treetablestructure"+elid).css("display") != "none"){
		$(".treetablestructure"+elid).css("display", "none")
		$("#treeorgimg"+elid).attr("src","/SharedResources/img/classic/1/plus.png")
	}else{
		$(".treetablestructure"+elid).css("display", "block")
		$("#treeorgimg"+elid).attr("src","/SharedResources/img/classic/1/minus.png")
	}
}

function toggleDepTreeStructure(countEl, action, dociddoctype){
	if (action == 'close'){
		el = $("#"+dociddoctype)
		for (var i = 0; i < countEl ; i++){
			el = $(el).next("div['display' = 'block']").css("display","none")
		}
		$("#treedep"+dociddoctype).attr("href","javascript:toggleDepTreeStructure("+countEl+",'open',"+ dociddoctype +")")
		$("#treedepimg"+dociddoctype).attr("src","/SharedResources/img/classic/1/plus.png")
	}else{
		el = $("#"+dociddoctype)
		for (var i = 0; i < countEl ; i++ ){
			el = $(el).next("div['display' = 'none']").css("display","block")
		}
		$("#treedep"+dociddoctype).attr("href","javascript:toggleDepTreeStructure("+countEl+",'close',"+ dociddoctype +")")
		$("#treedepimg"+dociddoctype).attr("src","/SharedResources/img/classic/1/minus.png")
	}
}

function checkallOrg(el, tableid){
	$(el).prop("checked") ? $(".treetablestructure"+tableid+ " input[type=checkbox]").prop("checked",true) : $(".treetablestructure"+tableid+ " input[type=checkbox]").prop("checked",false);
	if(queryOpt.fieldname == "executor"){
		$(".treetablestructure"+tableid+ " input[type=checkbox][id != '']").each(function(indx, element){
			addToCollectExecutor($(element))
		});
	}
}

function checkDepInp(el, countEl){
	elem = $(el).parent("div").next("div")
	for (var i = 0; i < countEl ; i++ ){
		$(el).prop("checked") ? $(elem).children("input[type=checkbox]").prop("checked",true) : $(elem).children("input[type=checkbox]").prop("checked",false);
		if(queryOpt.fieldname == "executor"){
			addToCollectExecutor($(elem).children("input[type=checkbox]"))
		}
	}
}

/* обработка нажатия клавиш esc и enter */
function keyDown(el, event){
	if(event.keyCode==27){
		$("#"+el).css("display","none").empty().remove();
		$("#blockWindow").remove();
	}
	if(event.keyCode==13){
		el !='coordParam' ? pickListBtnOk() : coordOk();
	}
}

/* выбор одного корреспондента из структуры */
function pickListSingleOk(docid){
	text=$("#"+docid).attr("value");
	$("input[name="+ queryOpt.fieldname +"]").remove();
	/* создаем скрытое поле для проектов блок *подписывающий* */
	if (queryOpt.fieldname == "signer"){
		$("#coordBlockSign").remove();
		$("#frm").append("<input type='hidden' name='coordblock' id='coordBlockSign' value='new`tosign`0`"+docid+"'>")
	}
	if (queryOpt.fieldname == 'executor'){
		$("#intexectable tr.INTERNAL , input[name=executor]").remove();
		$('#intexectable').append("<tr class='INTERNAL'>" +
			"<td>"+text+"<input  type='hidden' id='idContrExec' value='"+docid+"'/><input type='hidden' id='controlres' name='executor' value='1`"+ docid +"`1``'/><input type='hidden' class='responsible' value='1'/></td>" +
			"<td class='controlOffDate'/>" +
			"<td class='idCorrControlOff'/>" +
			"<td class='switchControl' style='text-align:center'><img style='cursor:pointer' onclick='controlOff(this)' title='Снять с контроля' src='/SharedResources/img/classic/icons/eye.png'/></td>" +
		"</tr>");
	}else{
		if(queryOpt.fieldname == 'extexecutor'){
			$("#intexectable tr.EXTERNAL").remove();
			ddbid=$("#"+docid).attr("ddbid")
			extexecval='2`'+ddbid+'`1``'
			$('#intexectable').append("<tr class='EXTERNAL'>" +
				"<td>"+text+"<input  type='hidden' id='idContrExec' value='"+docid+"'/><input type='hidden' class='controlres' name='extexecutor' value='"+ extexecval +"'/><input type='hidden' class='responsible' value='1'/></td>" +
				"<td class='controlOffDate'/>" +
				"<td class='idCorrControlOff'/>" +
				"<td class='switchControl' style='text-align:center'><img style='cursor:pointer' onclick='controlOff(this)' title='Снять с контроля' src='/SharedResources/img/classic/icons/eye.png'/></td>" +
			"</tr>");
		}else{
			if (queryOpt.fieldname == "parentsubkey"){
				elcl=$("#"+docid).attr("class");
				$("#parentsubkey").remove();
				$("#frm").append("<input type='hidden' name='parentsubkey' id='parentsubkey' value='"+elcl+"'>")
			}else{
				$("#frm").append("<input type='hidden' name='"+ queryOpt.fieldname +"' id='"+queryOpt.fieldname+"' value='"+docid+"'>")
			}
		}
	}
	 if (queryOpt.fieldname == 'corr' || queryOpt.fieldname == 'recipient' && queryOpt.queryname == 'corrcat'){
		 newTable="<table id="+ queryOpt.tablename +"><tr><td style='width:600px;' class='td_editable'>"+ text +"<span style='float:right; border-left:1px solid #ccc; width:20px; padding-right:10px; padding-left:2px; padding-top:1px; color:#ccc; font-size:11px'>"+docid+"</span></td></tr></table>"
	 }else{
		 newTable="<table id="+ queryOpt.tablename +"><tr><td style='width:600px;' class='td_editable'>"+ text +"</td></tr></table>"
	 }
	$("#"+ queryOpt.tablename).replaceWith(newTable)
	pickListClose(); 
}

/* нажатие кнопки "ок" в форме выбора кореспондента из структуры*/ /* переделать весь код*/
function pickListBtnOk(){
	var table = $("#"+ queryOpt.tablename),
		hidfields = $("#executorsColl").children("input[type=hidden]"); 
	if ($('input[name=chbox]:checked').length > 0){
		$(table).empty();
		$("input[name="+queryOpt.fieldname+"]").remove();
		if (queryOpt.fieldname == "executor"){
			if($('input[name=chbox]:checked').length > 0 ){
				$(".INTERNAL").remove();
			}
			$('input[name=chbox]:checked').each(function(indx, element){
				$(table).append("<tr><td style='width:600px;' class='td_editable'>"+hidfields[indx].value +"</td><td/></tr>");
				indx == 0 ? resp="1" : resp="0";
				controlres = "<input type='hidden' class='responsible' value='"+resp+"'/><input type='hidden' class='controlres' name='executor' value='1`"+ hidfields[indx].id +"`"+resp+"``'/>";
				$('#intexectable').append("<tr class='INTERNAL'>" +
					"<td>"+hidfields[indx].value+"<input  type='hidden' class='idContrExec' value='"+hidfields[indx].id+"'/>"+controlres+"</td>" +
					"<td class='controlOffDate'></td>" +
					"<td class='idCorrControlOff'></td>" +
					"<td class='switchControl' style='text-align:center'><img style='cursor:pointer' onclick='controlOff(this)' title='Снять с контроля' src='/SharedResources/img/classic/icons/eye.png'/></td>" +
				"</tr>");
			})
			if($('input[name=chbox]:checked').length > 1 ){
				$(table).find("tr:first td:last").append("<img src='/SharedResources/img/classic/icons/bullet_yellow.png' style='height:16px; margin-left:5px' title='ответственный исполнитель'/>")
			}
		}else{
			if(queryOpt.fieldname == "extexecutor"){
				if($('input[name=chbox]:checked').length > 0 ){
					$(".EXTERNAL").remove();
				}
				$('input[name=chbox]:checked').each(function(indx, element){
					indx == 0 ? resp="1" : resp="0";
					controlres = "<input type='hidden' class='responsible' value='"+resp+"'/><input type='hidden' class='controlres' name='executor' value='2`"+ $(this).attr("ddbid") +"`"+resp+"``'/>";
					$('#intexectable').append("<tr class='EXTERNAL'>" +
						"<td>"+$(this).val()+"<input  type='hidden' class='idContrExec' value='"+$(this).attr("ddbid")+"'/>"+controlres+"</td>" +
						"<td class='controlOffDate'></td>" +
						"<td class='idCorrControlOff'></td>" +
						"<td class='switchControl' style='text-align:center'><img style='cursor:pointer' onclick='controlOff(this)' title='Снять с контроля' src='/SharedResources/img/classic/icons/eye.png'/></td>" +
					"</tr>");
					$("#"+ queryOpt.tablename).append("<tr><td style='width:600px;' class='td_editable'>"+$(this).val()+"<span style='float:right; border-left:1px solid #ccc; width:20px; padding-right:10px; padding-left:2px; padding-top:1px; color:#ccc; font-size:11px'>"+$(this).attr("id")+"</span></td></tr>");
					extexecval='2`'+$(this).attr("ddbid")+'`1``';
					//$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+extexecval+"'/>")
				})
			}else{
				if(queryOpt.fieldname == 'corr' || queryOpt.fieldname == 'recipient' && queryOpt.queryname == 'corrcat'){
					$('input[name=chbox]:checked').each(function(indx, element){
						$("#"+ queryOpt.tablename).append("<tr><td style='width:600px;' class='td_editable'>"+$(this).val()+"<span style='float:right; border-left:1px solid #ccc; width:20px; padding-right:10px; padding-left:2px; padding-top:1px; color:#ccc; font-size:11px'>"+$(this).attr("id")+"</span></td></tr>");
						$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+$(this).attr("id")+"'>")
					})
				}else{
					if(queryOpt.fieldname == "parentsubkey"){
						$('input[name=chbox]:checked').each(function(indx, element){
							$("#"+ queryOpt.tablename).append("<tr><td style='width:600px;' class='td_editable'>"+$(this).val()+"</td></tr>");
							$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+$(this).attr("class")+"'>")
						})
					}else{
						$('input[name=chbox]:checked').each(function(indx, element){
							$("#"+ queryOpt.tablename).append("<tr><td style='width:600px;' class='td_editable'>"+$(this).val()+"</td></tr>");
							if (queryOpt.fieldname == "signer"){
								$("#coordBlockSign").remove();
								$("#frm").append("<input type='hidden' name='coordblock'  id='coordBlockSign' value='new`tosign`0`"+$(this).attr("id")+"'>")
								$("#frm").append("<input type='hidden' name='signer' id='coordBlockSign' value='"+$(this).attr("id")+"'>")
							}else{
								$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+$(this).attr("id")+"'>")
							}
						})
					}
				}
			}
		}
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

/*закрытие формы выбора корреспондентов из структуры */
function pickListClose(){ 
	$("#picklist").empty().remove();
	$('#blockWindow').remove();
	$('#picklist').enableSelection();
	if (queryOpt.fieldname == 'executor'){
		$("#content").focus().blur().focus();
	}
}

/* выбор одного корреспондента*/
function pickListSingleCoordOk(docid){ 
	text=$("#"+docid).attr("value");
	$("input[name=coorder]").remove();
	$("#frm").append("<input type='hidden' name='coorder' id='coorder' value='"+docid+"'>")
	newTable="<table id='coordertbl' width='100%'><tr><td>"+ text +"</td></tr></table>"
	$("#coordertbl").replaceWith(newTable);
	closePicklistCoord();  
}

/* закрытие диалогового окна*/
function closePicklistCoord(){
	$("#picklist").remove();
	$("#blockWindow").css('z-index','2');
}

/* вывод окна посередине экрана  */
function centring(id,wh,ww){
	var w=$(window).width(), 
		h=$(window).height(),
		winH=$('#'+id).height(), 
		winW=$('#'+id).width(),
		scrollA=$("body").scrollTop(), 
		scrollB=$("body").scrollLeft();
	htop=scrollA+((h/2)-(winH/2))
	hleft=scrollB+((w/2)-(winW/2))
	$('#'+id).css({"top":htop, "left":hleft}) ;
}

/*функция для обеспечения rollover*/
function entryOver(cell){
	cell.style.backgroundColor='#FFF1AF';
}

/*функция для обеспечения rollover*/
function entryOut(cell){
	cell.style.backgroundColor='#FFFFFF';
}

/* функция для загрузки корреспондентов в форму создания блоков согласования */
function picklistCoordinators(){
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=bossandemp',
		success:function (data){
			if(data.match("html")){
				window.location="Provider?type=static&id=start&autologin=0"
			}
			$("#contentdiv").html(data);
			$('#searchCor').focus();
		}
	});
}

var elementCoord;
/* добавление корреспондентов в таблицу двойным щелчком мыши*/

function addCoordinator(docid,el){
	//docid - userID  выбранного корреспондента
	// el - строка таблицы с выбранным корреспондентом
	cwb=$(".coordinatorsWithBlock")
	signer=$("#signer").val(); 
	recipient=$("#recipient").val()
	if(signer == docid){
		text=issignerofsz;
		infoDialog(text);
	}else{
		if(recipient == docid){
			text=isrecieverofsz;
			infoDialog(text);
		}else{
			if($("."+docid).val()!= null){
				text=alreadychosen;
				infoDialog(text);
			}else{
				text=$("#"+docid.replace(".","\\.")).val();
				$(el).replaceWith("");
				tr="<div style='display:block; width:100%; text-align:left; cursor:pointer' name='itemStruct' onClick='selectItem(this)' ondblclick='removeCoordinator(&quot;"+docid+"&quot;,this)' style='cursor:pointer'><input class='chbox' type='hidden' name='chbox'   id='"+ docid+"' value='"+ text +"'></input><font style='font-size:12px'>"+text+"</font></div>";
				$("#coorderToBlock").append(tr);
			}
		}
	}
}

/*удаление из таблицы корреспондентов двойным щелчком мыши */
function removeCoordinator(docid,el){
	text=$("#"+docid.replace(".","\\.")).val();
	tr="<div style='display:block; width:100%; text-align:left; cursor:pointer' name='itemStruct' onClick='selectItem(this)' ondblclick='addCoordinator(&quot;"+docid+"&quot;,this)' ><input class='chbox' type='hidden' name='chbox'   id='"+ docid+"' value='"+ text +"'></input><font style='font-size:12px'>"+ text+"</font></div>";
	$(el).remove();
	$("#picklistCoorder").append(tr);
}

/*выделение и снятие выделения корреспондента в таблице одинарным щелчком мыши */
var prevSelectItem=null

function selectItem (el){
	elementCoord=el;
	if (prevSelectItem != null){
		$(prevSelectItem).removeClass();
	}
	$(el).attr("class","selectedItem");
	prevSelectItem=el
}

function plusCoordinator(){
	isWithBlock="false";
	userID=$(".selectedItem  input").attr("id");
	if(!userID){
		infoDialog("Вы не выбрали участника согласования для добавления");
	}
	if($("."+userID).val() != null){
		infoDialog(alreadychosen)
		isWithBlock="true"
	}
	if (isWithBlock=="false"){
		signer=$("#signer").val(); 
		recipient=$("#recipient").val()
		if (userID == signer){
			infoDialog(issignerofsz);
		}else{
			if (userID == recipient){
				infoDialog(isrecieverofsz);
			}else{
				$("#coorderToBlock").append(elementCoord);
				$(elementCoord).removeClass();
				$("#picklistCoorder .selectedItem").replaceWith("");
				elementCoord=null;
			} 
		}
	}
}

/* удаление корреспондента из таблицы нажатием кнопки "<--" */
function minusCoordinator(){
	if($("#coorderToBlock").children(".selectedItem").length !=0){
		$("#coorderToBlock").children(".selectedItem").remove();
		$("#picklistCoorder").append(elementCoord);
		$(elementCoord).removeClass();
		elementCoord=null
	}else{
		infoDialog("Вы не выбрали участника согласования для удаления");
	}
}

function closeDialog(el){
	$("#"+el).empty().remove();
	$("#blockWindow").remove();
}

function fastCloseDialog(){
	$("#picklist").css("display","none");
}

function enableblockform(){
	blockWindow="<div class='ui-widget-overlay' id='blockWindow'/>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css({"width":$(window).width(), "height":$(window).height(), "display":"block"}); 
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
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el, event);'>";
	divhtml +="<div class='header'><font id='headertext' class='headertext'/>";
	divhtml +="<div class='closeButton'><img style='width:15px; height:15px; margin-left:3px; margin-top:1px' src='/SharedResources/img/classic/icons/cross.png' onclick='pickListClose();'/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:-10px'><div id='divSearch' class='divSearch' style='display:inline-block; float:left; width:360px'></div>" 
	divhtml +="<div  style='display:inline-block; float:right; width:100px; margin-top:20px'><a class='actionlink' id='btnChangeView' href='javascript:changeViewStructure(1)' style='margin-top:50px'><font style='font-size:11px'>"+changeviewcaption+"</font></a></div></div>";
	divhtml +="<div id='contentpane' class='contentpane'>Загрузка данных...</div>";  
	divhtml += "<div id='btnpane' class='button_panel' style='margin-top:8%; margin:15px 15px 0; padding-bottom:15px;text-align:right;'>";
	divhtml += "<button onclick='pickListBtnOk()' style='margin-right:5px'><font class='button_text'>ОК</font></button>" 
	divhtml += "<button onclick='pickListClose()'><font class='button_text'>"+cancelcaption+"</font></button>";    
	divhtml += "</div><div id='executorsColl' display='none'/></div>";
	$("body").append(divhtml);
	$("#picklist #btnpane").children("button").button()
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	$("#picklist").focus().css('display', "none");
	$("#headertext").text($("#"+field+"caption").val());
	$("body").css("cursor","wait")
	reqType='view';
	if(query=='corrcat'){
		reqType='page';
	}
	$.ajax({
		type: "get",
		url: 'Provider?type='+reqType+'&id='+query+'&keyword='+queryOpt.keyword+'&page='+queryOpt.pagenum,
		success:function (data){
			if (data.match("login") && data.match("password")){
				text="Cессия пользователя была закрыта, для продолжения работы необходима повторная авторизация";
				func = function(){window.location.reload()};
				dialogAndFunction(text,func)
			}else{
				if(isMultiValue=="false"){
					if($.browser.msie){
						while(data.match("checkbox")){
							data=data.replace("checkbox", "radio");
						}
					}else{
						elem=$(data);
						$(elem).find("input[type=checkbox]").prop("type","radio")
						data = elem;
					}
				}
				$("#contentpane").html(data);
				$("#searchTable").remove();
				if (isMultiValue=="false"){
					$("#contentpane").append("<input type='hidden' id='radio' value='true'/>");
				}else{
					$("#contentpane").append("<input type='hidden' id='radio' value='false'/>");
					$("input[type=checkbox][id != '']").on('change',function(){
						addToCollectExecutor(this)
					});
				}
				if(queryOpt.queryname == 'workdocsigners' || queryOpt.queryname == 'signers' || queryOpt.queryname == "corrcat" || queryOpt.queryname == "n"){
					$("#btnChangeView").remove();
				}
				if(queryOpt.queryname != 'n' && queryOpt.queryname != 'corrcat'){
					searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%; font-weight:bold'>"+searchcaption+":</font>";
					searchTbl +="<input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
					$("#divSearch").append(searchTbl);
				}
				if(queryOpt.queryname == 'n'){
					searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%; font-weight:bold'>"+searchcaption+":</font>";
					searchTbl +="<input type='text' id='searchCor' style='float:left; margin-left:3px;margin-bottom:10px' size='34' onKeyUp='ajaxFind()'/>"; 
					$("#divSearch").append(searchTbl);
				}
				// запрещаем выделение текста
				$('#picklist').disableSelection();
				if($("#coordTableView tr").length > 1 &&  field == 'signer'){
					dialogConfirm(replaceCoordBlocksConfirm, "picklist","trblockCoord")
				}else{
					$('#blockWindow').css("display","block")
					$('#picklist').css("display","inline-block");
				}
				$('#picklist').focus()
			}
		},
		error:function (xhr, ajaxOptions, thrownError){
            if (xhr.status == 400){
         	  $("body").children().wrapAll("<div id='doerrorcontent' style='display:none'/>")
         	  $("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
         	  $("li[type='square'] > a").attr("href","javascript:backtocontent()")
            }
         }  
	});
	$("body").css("cursor","default")
}

function addToCollectExecutor(el){
	if($(el).prop('checked') == true && $(el).attr("id") != ''){
		$("#executorsColl").append("<input type='hidden' id='"+$(el).attr("id")+"' value='"+$(el).val() +"'/>")
	}else{
		$("#executorsColl").children("#"+$(el).attr("id")).remove();
	}
	$("#executorsColl input[type=hidden]:first").attr("class","otv")
}

/* Функция  запрета и разрешения выделения текста   */
jQuery.fn.extend({
    disableSelection : function() {
    	this.each(function() {
    		this.onselectstart = function(){return false;};
    		this.unselectable = "on";
    		$(this).css('-moz-user-select','none');
    	});
    },
    enableSelection : function() {
    	this.each(function() {
    		this.onselectstart = function() {};
    		this.unselectable = "off";
    		$(this).css('-moz-user-select','auto');
    	});
    }
});

/* функция поиска корреспондентов в форме 'Новое согласование'*/
function findCorCoord(){
	var value=$('#searchCor').val(),
		len=value.length
	if (len > 0){
		$("#picklistCoorder div[name=itemStruct]").css("display","none");
		$("#contentdiv").find("div[name=itemStruct]").each(function(){
			if ($(this).text().substring(0,len).toLowerCase()== value.toLowerCase()){
				$(this).css("display","block")
			}
		});
	}else{
		$("div[name=itemStruct]").css("display","block");
	}
}

/* функция поиска в структуре*/
function findCorStructure(){
	var value=$('#searchCor').val(),
		len=value.length
	if (len > 0){
		$("div[name=itemStruct]").css("display","none");
		$("#contentpane").find("div[name=itemStruct]").each(function(){
			if ($(this).text().substring(0,len).toLowerCase() == value.toLowerCase()){
				$(this).css("display","block")
			}
		});
	}else{
		$("div[name=itemStruct]").css("display","block");
	}
}

/* функция выбора страницы в диалогах*/
function selectPage(page,ruleid){
	if(ruleid && ruleid !=''){
		queryOpt.queryname = ruleid;
	}
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

/* функция изменения вида диалога (список или структура)*/
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
				queryOpt.queryname="structurefullpicklist";
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
			// по клику добавляем в коллекцию 
			$("#contentpane input[type=checkbox]").change(function(){
				addToCollectExecutor(this)
			});
			if(viewType == 2){
				searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>"+searchcaption+":</b></font>";
				if (queryOpt.queryname == 'n'){
					searchTbl +="<input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='ajaxFind()'/>"; 
				}else{
					searchTbl +="<input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
				}
				$("#divSearch").append(searchTbl);
			}else{
				$("#divSearch").empty()
			}
			$('#btnChangeView').attr("href","javascript:changeViewStructure("+queryOpt.dialogview+")");
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

/* функция открытия категорий в структуре*/
function expandChapter(query,id,doctype) {
	var complexid=String(id)+String(doctype);
	$.ajax({
		url: 'Provider?type=view&id='+query+'&parentdocid='+id+'&parentdoctype='+doctype+'&command=expand`'+id+'`'+doctype,
		success: function(data) {
			if(queryOpt.isMultiValue == "false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$(".tbl"+complexid).append(data).css("margin-left","15px");	
			if (doctype == "891"){
				$("input[name=chbox]").removeAttr("style");	
			}
		}
	});	
	$("#a"+complexid).attr("href","javascript:collapseChapter('"+query+"','"+id+"','"+ doctype+"')");
	$("#img"+complexid).attr("src","/SharedResources/img/classic/1/minus.png");
}

/* функция закрытия категорий в структуре*/
function collapseChapter(query,id,doctype){
	var complexid=String(id)+String(doctype);
	$.ajax({
		url: 'Provider?type=view&id='+query+'&parentdocid='+id+'&parentdoctype='+doctype+'&command=collaps`'+id+'`'+doctype,
		success: function(data) {
			$(".tbl"+complexid+" tr:[name=child]").remove()
		}
	});
	$("#img"+complexid).attr("src","/SharedResources/img/classic/1/plus.png");
	$("#a"+complexid).attr("href","javascript:expandChapter('"+query+"','"+id+"','"+ doctype+"')");
}

/* функция открытия категорий корреспондентов*/
function expandChapterCorr(docid,num,url,doctype, page) {
	var complexid=String(docid)+String(doctype);
	el = $(".tblCorr:eq("+num+")");
	$.ajax({
		url:url+"&page="+queryOpt.pagenum,
		dataType:'html',
		success: function(data) {
			$("#contentpane").html(data)
			$("#img"+complexid).attr("src","/SharedResources/img/classic/1/minus.png");
			$("#a"+complexid).attr("href","javascript:collapsChapterCorr('"+docid+"','"+num+"','"+ url+"','"+doctype+"','"+page+"')");
		}
	});	
}

/* функция закрытия категорий корреспондентов*/
function collapsChapterCorr(docid,num,url,doctype, page) {
	var complexid=String(docid)+String(doctype);
	el = $(".tblCorr:eq("+num+")");
	$.ajax({
		url:"Provider?type=view&id=corrcat&command=collaps`"+docid+"&page="+ queryOpt.pagenum ,
		dataType:'html',
		success: function(data){
			$("#contentpane").html(data)
			$("#img"+complexid).attr("src","/SharedResources/img/classic/1/plus.png");
			$("#a"+complexid).attr("href","javascript:expandChapterCorr('"+docid+"','"+num+"','"+ url+"','"+doctype+"','"+page+"')");
		}
	});	
}


function openListRespDoc(docid,doctype,num,page) {
	var complexid=String(docid)+String(doctype);
	$.ajax({
		datatype:"XML",
		url: 'Provider?type=page&id=responses&docid='+docid+'&doctype='+doctype+'&page='+page,
		success: function(xml){
			level=parseInt($(".tblCorr"+complexid).attr('level'));
			newlevel=level+1;
			$("<table style='border-collapse:collapse; width:100%' id='respList"+complexid+"'/>").insertAfter(".tblCorr"+complexid)
			table=$("#respList"+complexid);
			i=1;
			$(xml).find("entry[docid][doctype]").each(function(indx, element){
				var __docid=$(this).attr("docid"),
					__doctype=$(this).attr("doctype"),
					__complexid=__docid+__doctype,
					__ddbid=$(this).attr("id"),
					iconresponse='<img src="/SharedResources/img/classic/tree_spacer.gif"/>'
				if($(this).attr("hasresponse") != '0'){
					iconresponse="<a style='margin-right:3px' id='a"+__complexid+"' href='javascript:openListRespDoc("+$(this).attr("docid")+","+$(this).attr("doctype")+", i, 1)'><img border='0' src='/SharedResources/img/classic/1/plus.png' id='img"+__complexid+"'/></a>"
				}
				corrname = $(this).find("viewtext1").text() || $(this).find("viewtext6").text();
				viewtext1 = JSON.stringify(corrname);
				newcontent="<tr><td><table style='border-collapse:collapse; width:100%; text-align:left; cursor:pointer' level='"+newlevel+"' class='tblCorr"+__complexid+"'>" +
					"<tr onmouseover='javascript:entryOver(this)' onmouseout='javascript:entryOut(this)'>" +
					"<td ondblclick='javascript:pickListSingleOk("+__docid+")'>"+iconresponse+"<input type='checkbox' name='chbox' ddbid='"+__ddbid+"' value="+viewtext1+" id='"+$(this).attr("docid")+"'/>"+ corrname +"</td></tr></table></td></tr>"
				$(table).append(newcontent)
				$(".tblCorr"+__complexid).css("margin-left",level*20+"px")
				i++;
			})
		}
	});	
	$("#a"+complexid).attr("href","javascript:closeListRespDoc('"+docid+"','"+ doctype+"','"+num+"','"+page+"')");
	$("#img"+complexid).attr("src","/SharedResources/img/classic/1/minus.png");
}

function closeListRespDoc(docid,doctype,num,page) {
	complexid=String(docid)+String(doctype);
	$("#respList"+complexid).remove();
	$("#a"+complexid).attr("href","javascript:openListRespDoc('"+docid+"','"+ doctype+"','"+num+"',1)");
	$("#img"+complexid).attr("src","/SharedResources/img/classic/1/plus.png");
}

function selectItemPicklist(element, event){
	if (!event.target) {
	    event.target = event.srcElement
	}
	if(event.target.nodeName !="INPUT"){
		target_input = $(element).find("input[type!=hidden]");
		if($(target_input).prop("checked")){
			target_input.prop("checked",false).change();
		}else{
			target_input.prop("checked",true).change()
		}
	}
}