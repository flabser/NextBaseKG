var direction;
var n;
var cfg;
var sumReloadView;
var curlangOutline;
var timeout
var AppName = "STRUCTURE"

var outline = {
	type:null,
	viewid:null,
	docid:null,
	element:null,
	curPage:null,
	command:null,
	curlangOutline:null,
	isLoad:false,
	sortField:null,
	sortOrder:null,
	category:null,
	project:null,
	filterid:null,
	filtercat:'',
	filterproj:'',
	filterplace:'',
	filterstatus:'',
	filterresp:'',
	filterauthor:''
}

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
			}else{
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
		}
		return utftext;
	},
	_utf8_decode : function (utftext){
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
		while(i < utftext.length){
			c = utftext.charCodeAt(i);
			if (c < 128){
				string += String.fromCharCode(c);
				i++;
			}else if((c > 191) && (c < 224)){
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
		return string;
	}
}

function openregioncity(docid, group){
	$('#img'+docid).attr("src","/SharedResources/img/classic/1/minus.png");
	$('#a'+docid).attr("href","javascript:closeregioncity("+docid+",'"+group+"')");
	$("."+group).show()
}

function closeregioncity(docid,group){
	$('#img'+docid).attr("src","/SharedResources/img/classic/1/plus.png");
	$('#a'+docid).attr("href","javascript:openregioncity("+docid+",'"+group+"')");
	$("."+group).hide()
}

function closepanel(){
	$("#outline-container, #view , #resizer").animate({left: '-=300px'},'50'); 
	$("#resizer").attr("onclick","openpanel()");
	$("#iconresizer").attr("class","ui-icon ui-icon-triangle-1-e");
}

function openpanel(){
	$("#outline-container, #view, #resizer").animate({left: '+=300px'},'50'); 
	$("#resizer").attr("onclick","closepanel()");
	$("#iconresizer").attr("class","ui-icon ui-icon-triangle-1-w");
}

function closeformpanel(){
	$("#outline-container, .formwrapper").animate({left: '-=305px'},'50'); 
	$("#resizer").animate({left:'-=305px'},'50');
	if ($(window).width() < "1280"){
		$(".td_editable").animate({width: '600px'},'50'); 
		$(".select_editable").animate({width: '610px'},'50'); 
		$(".fc").animate({width: '+=20px'},'50'); 
	}
	$("#resizer").attr("onclick","openformpanel()");
	$("#iconresizer").attr("class","ui-icon ui-icon-triangle-1-e");
}

function openformpanel(){
	$("#outline-container , .formwrapper").animate({left: '+=305px'},'50'); 
	if ($(window).width()< "1200"){
		$(".select_editable, .td_editable").animate({width: '460px'},'50'); 
		$(".fc").animate({width: '-=20px'},'50'); 
	}
	$("#resizer").animate({left:'+=305px'},'50').attr("onclick","closeformpanel()");
	$("#iconresizer").attr("class","ui-icon ui-icon-triangle-1-w");
}

function ToggleCategory(el){
	if ($(el).parent().next().next().is(":visible")){
		$(el).children().attr("src","/SharedResources/img/classic/1/plus.png")
		$(el).children().next("img").attr("src","/SharedResources/img/classic/1/folder_close_view.png")
		$(el).parent().next().next().slideUp("fast")
		if ($(el).parent().next().next().children(".entry").children(".viewlink_current").length != 0 ){
			$(el).parent().children("font").attr("font-weight","bold")
		}
		SavePropVisCategory($(el).parent().next().next().attr("id"),"none")
	}else{
		$(el).children().attr("src","/SharedResources/img/classic/1/minus.png")
		$(el).children().next("img").attr("src","/SharedResources/img/classic/1/folder_open_view.png")
		$(el).parent().next().next().css("visibility","visible");
		$(el).parent().next().next().slideDown("fast")
		SavePropVisCategory($(el).parent().next().next().attr("id"),"block")
	}
}

function SavePropVisCategory(id,val){
	$.cookie(AppName + "_" + id, val,{ path:"/", expires:30});	
}

function delGlossary(dbID,typedel){
	if($("input[name^='chbox']:checked").length != 0){
		var ck="";
		$("input[name^='chbox']:checked").each(function(indx, element){
			ck+=$(element).val()+"~"+$(element).attr("id")+"`";
		});
		ck =ck.substring(0 , ck.length - 1);
		$.ajax({
			type: "GET",
			datatype:"XML",
			url: "Provider",
			data: "type=delete&ck=" + ck + "&typedel="+typedel+"&dbid=Avanti&id=delete&nocache="+Math.random() * 300 ,
			success: function (msg){
				if( $.cookie("lang")=="RUS" || !$.cookie("lang")){
					divhtml ="<div id='dialog-message' title='Удаление'>";	
					divhtml += "Удалено успешно. <br/>";
				}else if ( $.cookie("lang")=="KAZ"){
					divhtml ="<div id='dialog-message' title='Жою'>";	
					divhtml += "Жою сәтті аяқталды. <br/>";
				}else if ( $.cookie("lang")=="ENG"){
					divhtml ="<div id='dialog-message' title='Deleting'>";	
					divhtml += "Successfully deleted. <br/>";
				}else if ( $.cookie("lang")=="CHN"){
					divhtml ="<div id='dialog-message' title='切除'>";	
					divhtml += "成功删除. <br/>";
				}
				divhtml += "</div>";
				$("body").append(divhtml);
				$("#dialog").dialog("destroy");
				$("#dialog-message").dialog({
					modal: true,
					width: 300,
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
			error: function(data,status,xhr) {
				if($.cookie("lang")=="RUS")
					infoDialog("Ошибка удаления")
				else if($.cookie("lang")=="KAZ")
					infoDialog("Жою қателігі")
				else if( $.cookie("lang")=="ENG")
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

function addDocToFav(el,docid,doctype){
	$.ajax({
		type: "GET",
		datatype:"XML",
		url: "Provider",
		data: "type=service&operation=add_to_favourites&id=add_to_favourites&key="+docid+"&doctype="+doctype+"&dbid=Avanti&nocache="+Math.random() * 300 ,
		success: function (msg){
			$(el).attr("src","/SharedResources/img/iconset/star_full.png")
			$(el).attr("onclick","removeDocFromFav(this,"+docid+","+doctype+")")
			$.ajax({
				url: "Provider?type=view&id=mydocs_count&onlyxml",
				dataType:'xml',
				async:'true',
				success: function(data) {
					$("#countfavdocs").html($(data).find("favdocs").text());
				}
			});
		},
		error: function(data,status,xhr) {
			infoDialog("Ошибка добавления в избранное")
		}
	})
}

function removeDocFromFav(el,docid,doctype){
	$.ajax({
		type: "GET",
		datatype:"XML",
		url: "Provider",
		data: "type=service&operation=remove_from_favourites&id=remove_from_favourites&key="+docid+"&doctype="+doctype+"&dbid=Avanti&nocache="+Math.random() * 300 ,
		success: function (msg){
			$(el).attr("src","/SharedResources/img/iconset/star_empty.png")
			$(el).attr("onclick","addDocToFav(this,"+docid+","+doctype+")")
			$.ajax({
				url: "Provider?type=view&id=mydocs_count&onlyxml",
				dataType:'xml',
				async:'true',
				success: function(data) {
					$("#countfavdocs").html($(data).find("favdocs").text());
				}
			});
		},
		error: function(data,status,xhr) {
			infoDialog("Ошибка удаления из избранного")
		}
	})
}

function undelGlossary(dbID){
	var ck="";
	$("input[name^='chbox']:checked").each(function(indx, element){
		  ck+=$(element).val()+"~"+$(element).attr("id")+"`";
	});
	ck =ck.substring(0 , ck.length - 1);
	$.ajax({
		type: "GET",
		datatype:"XML",
		url: "Provider",
		data: "type=undelete&ck=" + ck +"&dbid=Avanti&nocache="+Math.random() * 300 ,
		success: function (msg){
			restoredcount=$(msg).find('restored').text();
			notrestoredcount=$(msg).find('notrestored').text();
			divhtml ="<div id='dialog-message' title='Восстановление'>";
			divhtml+="<span style='text-align:center;'>";
			divhtml+="<font style='font-size:13px; '>Документов восстановлено:"+restoredcount+"</font><br/>" ;
			if(notrestoredcount !=''){ divhtml+="<font style='font-size:13px; '>Документов не восстановлено:"+notrestoredcount+"</font>";}
			divhtml += "</div>";
			$("body").append(divhtml);
			$("#dialog-message").dialog("destroy");
			$("#dialog-message").dialog({
				modal: true,
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
		error: function(data,status,xhr) {
			infoDialog("Ошибка восстановления")
		}
	})
}

/* функция поиска*/
function search(){
	$(".searchpan").html("");
	value=$("#searchInput").attr("value");
	if(value.length==0){
		if ($.cookie("lang")=="RUS")
			message("Заполните строку поиска","searchInput");
		else if ($.cookie("lang")=="KAZ")
			message("Іздеу қатарын толтырыңыз","searchInput");
		else if ($.cookie("lang")=="ENG")
			message("Please fill the search field","searchInput");
	}else{
		value = Url.encode(value);
		window.location="Provider?type=search&keyword="+value;
	}
}

function closeSearch(){
	$(".searchpan").css("display","none");
	$("#searchInput").val("");
}

function openSearch(){
	$(".searchpan").css("display","block")
}

function collapsSearch(){
	$("#content").attr("style","display:none");
	$(".searchpan").css("style","height:20px");
	$("#colsearch").attr("src","/SharedResources/img/classic/open_gray.gif");
	$("#excol").attr("href","javascript:expandSearch()");
}

function expandSearch(){
	$("#content").attr("style","display:block");
	$("#colsearch").attr("src","/SharedResources/img/classic/close_gray.gif");
	$("#excol").attr("href","javascript:collapsSearch()");
}

function openCategoryView(id,cdoctype,pos,s) {
	$.ajax({
		url: 'Provider?type=view&id=docsbyproject&parentdocid='+id+'&parentdoctype='+cdoctype+'&command=expand`'+id,
		datatype:'html',
		success: function(data) {
			$(data).insertAfter("#category"+ id);	
		}
	});	
	$("#a"+id).attr("href","javascript:closeCategoryView('"+id+"','"+ cdoctype+"','"+pos+"',"+s+")");
	$("#img"+id).attr("src","/SharedResources/img/classic/1/minus.png");
}

function closeCategoryView(id,cdoctype,pos,s){
	$.get('Provider?type=view&id=docsbyproject&command=collaps`'+id, {})
	$("#category"+id).next(".viewtable").remove();
	$("#a"+id).attr("href","javascript:openCategoryView('"+id+"','"+ cdoctype+"','"+pos+"',"+s+")");
	$("#img"+id).attr("src","/SharedResources/img/classic/1/plus.png");
}

/* открытие ответных документов в виде*/
function openParentDocView(id,cdoctype,pos,s) {
	$("<tr id='loadingparentdoc"+id+"' style='background: #fff'><td colspan='7' style='text-align:center'><img src='classic/img/image_311968.gif'/></td></tr>").insertAfter("."+ id );
	$.ajax({
		  url: 'Provider?type=view&id=docthread&parentdocid='+id+'&parentdoctype='+cdoctype+'&command=expand`'+id+'`'+cdoctype,
		  datatype:'html',
		  success: function(data) {
			 $("#loadingparentdoc"+id).remove()
			 $(data).insertAfter("."+ id );	
			 $("."+id).next("tr").css("background","#fff");
			 $("."+id).next("tr").find('.font').each(function(){
				 html=$(this).html().replace("--&gt;", "<img src='/SharedResources/img/classic/arrow_blue.gif'/>");
				 $(this).html("").append(html);
			 });
		  }
	});	
	$("#a"+id).attr("href","javascript:closeResponses('"+id+"','"+ cdoctype+"','"+pos+"',"+s+")");
	$("#img"+id).attr("src","/SharedResources/img/classic/1/minus.png");
}

function closeResponses(id,cdoctype,pos,s){
	$.get('Provider?type=view&id=docthread&command=collaps`'+id+'`'+cdoctype, {})
	$("."+id).next("tr").replaceWith("");
	$("#a"+id).attr("href","javascript:openParentDocView('"+id+"','"+ cdoctype+"','"+pos+"',"+s+")");
	$("#img"+id).attr("src","/SharedResources/img/classic/1/plus.png");
}

function checkAll(allChbox) {
	allChbox.checked ? $("input[name=chbox]").attr("checked","true") : $("input[name=chbox]").removeAttr("checked");
}

function refresher() {
	if (timeout != null || timeout != undefined ){
		clearTimeout(timeout)
	}
	sumReloadView = 0
	if ($.cookie("refresh") !=null){
		timeval= $.cookie("refresh") * 60000;
	}else{
		timeval=180000
	}
	timeout = setTimeout("refreshAction()", timeval);
}

function refreshAction() {
    sumReloadView = sumReloadView + 1;
	updateView();
}

function doSearch(keyWord ,num){
	if (num != null){
		outline.curPage = num
	}
	keyWord = Url.encode(keyWord)
	$.ajax({
		url: 'Provider?type=search&keyword=' + keyWord + '&page=' + outline.curPage,
		datatype:"html",
		beforeSend: function(){
			loadingOutline()
		},
		success: function(data) {
			$("body").html(data.split("<body>")[1].split("</body>")[0]);
			endLoadingOutline()
		},
		error: function(data,status,xhr) {
			if (xhr == "Bad Request"){
				text="Запрос не распознан";
				func = function(){window.history.back()};
				dialogAndFunction (text,func)
			}else{
				$("#noserver").css("display","block");
				$("#finddoc").css("display","none");
			}
		}
	});
}

function elemBackground(el,color){
	$(el).css("background","#"+color)
}

function flashentry(id) {
	color = $("#"+id).attr("bgcolor");
	$("#"+id).animate({backgroundColor: '#ffff99'}, 1000);
	if (color == null){
		$("#"+id).animate({backgroundColor: "#ffffff"}, 1000, function(){$("#"+id).css("background","none")});
	}else{
		$("#"+id).animate({backgroundColor: color}, 1000);
	}
}

function updateAllCount(){
	$(".countSpan").each(function(indx, element){
		if($(element).attr("id")!=''){
			updateCount($(element).attr("id")+"_count", $(element).attr("id"))
		}
	});
	setTimeout("updateAllCount()", 960000);
}

function updateCount(query, idcount) {
	$.ajax({
		url: 'Provider?type=query&id='+query+'&rndm='+Math.random(),
		dataType:'xml',
		async:'true',
		success: function(data) {
			count = $(data).find('query').text();
			if (count == ''){
				count= 0
			}
			$("#"+ idcount).html("<font style='font-size:12px'>["+count+"]</font>")
		}
	});
}

function resetFilterView(){
	outline.filtercat = '0';
	outline.filterproj = '0';
	outline.filterplace = '0';
	outline.filterstatus = '0';
	outline.filterresp = '0';
	outline.filterauthor = '0';
	updateView(outline.type, outline.viewid, outline.page, outline.command,  outline.sortField, outline.sortOrder)
}

function openCategoryList(el, listid){
	$(".glosslisttable").css("visibility", "hidden");
	$(el).offset(function(i,val){
		$("#"+listid).css("position", "absolute");
		if(IE='\v'=='v'){
			$("#"+listid).css("top", val.top -70);
		}else{
			$("#"+listid).css("top", val.top - 55);
		}
		$("#"+listid).css("left", val.left -320);
		return {top:val.top, left:val.left};
	});
	$("#"+listid).css("visibility", "visible");
	$(el).attr("onclick", "closeCategoryList(this,'"+listid+"')");
    $(document).bind('click.'+listid, function(e) {
       if ($(e.target).closest("#"+listid+"button").length == 0) {
          	$("#"+listid).css("visibility", "hidden");
            $(document).unbind('click.'+listid);
            $(el).attr("onclick", "openCategoryList(this,'"+listid+"')");
       }
    });
}

function hideQFilterPanel(){
	$('#btnQFilter').removeAttr('onclick')
	$("#QFilter").slideUp("fast");
	$( "#tablecontent" ).animate({top:'-=29px'},'fast', function() {
		$('#btnQFilter').attr('onclick',"openQFilterPanel();")
		}); 
	if (outline.filtercat !='' || outline.filterproj!=''|| outline.filterplace!='' || outline.filterstatus !='' || outline.filterresp !='' || outline.filterauthor!=''){
		if (outline.filtercat !='0' || outline.filterproj!='0'|| outline.filterplace!='0' || outline.filterstatus !='0' || outline.filterresp !='0' || outline.filterauthor!='0'){
			resetFilterView()
		}
	}
}

function openQFilterPanel(){
	$('#btnQFilter').removeAttr('onclick')
	if($("#QFilter").css("display") == 'none'){
		$("#QFilter").slideDown("fast")
		$("#tablecontent").animate({top:'+=29px'},'fast', function() {
			$('#btnQFilter').attr('onclick',"hideQFilterPanel();")
		}); 
	}
}

function closeCategoryList(el,listid){
	$("#"+listid).css("visibility", "hidden");
	$(el).attr("onclick", "openCategoryList(this,'"+listid+"')");
}

function updateView(type, viewid, page, command,  sortField, sortOrder){
	loadingOutline()
	category = outline.category || '';
	project = outline.project || '';
	if (type !=null){
		outline.type=type;
	}
	if (viewid !=null){
		outline.viewid=viewid;
	}
	if (page !=null || page !=undefined ){
		outline.curPage=page;
	}
	if (outline.filterid !=null || outline.filterid !=undefined ){
		filterid = outline.filterid;
	}
	commandPart = '';
	if (command != null){
		outline.command=command;
		commandPart = '&command=' + outline.command;
	}
	sortPart = '';
	if (sortField != null && sortOrder != null ){
		outline.sortField = sortField;
		outline.sortOrder = sortOrder;
		$.cookie("sortField", sortField,{
			path:"/",
			expires:30
		});	
		$.cookie("sortOrder", sortOrder,{
			path:"/",
			expires:30
		});	
	}
	if (outline.sortField != null && outline.sortOrder != null && $.cookie("sortField") == null && $.cookie("sortOrder") == null){
		sortPart ='&sortfield='+outline.sortField+"&order=" + outline.sortOrder;
	}
	if ($.cookie("sortField") != null && $.cookie("sortOrder") != null){
		sortPart ='&sortfield='+$.cookie("sortField")+"&order=" +$.cookie("sortOrder");
	}
	
	url= 'Provider?type=' + outline.type + '&id=' + outline.viewid + '&page=' + outline.curPage + commandPart+ sortPart+"&keyword="+category+"&filterid="+outline.filterid+"&filtercat="+outline.filtercat + "&filterproj=" + outline.filterproj+ "&filterorigin=" + outline.filterplace+ "&filterstatus=" + outline.filterstatus+ "&filterresp=" + outline.filterresp+ "&filterauthor=" + outline.filterauthor ;
	if ($.cookie("lang")=="RUS" || $.cookie("lang") == null){
		text="Cессия пользователя была закрыта, для продолжения работы необходима повторная авторизация"
	}else if($.cookie("lang")=="ENG"){
		text="User session was closed by the server, in order to proceed re-authorization is required";
	}else if ($.cookie("lang")=="KAZ"){
		text="Пайдаланушының сессиясы сервермен жабылды, жұмысты жалғастыру үшін қайта авторлану керек";
	}
	$.ajax({
		url: url,
		dataType:'HTML',
		async:'true',
		success: function(data) {
			if (!data.match("viewtable")){
				func = function(){window.location.reload()};
				dialogAndFunction (text,func);
				checksrv()
			}else{
				$("document").html(data);
				$("#searchInput").css("padding","2px")
				endLoadingOutline();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			checksrv()
		}
	});
}

function checksrv(){
	$.ajax({
		url: "Provider?type=edit&element=userprofile&id=userprofile",
		dataType:'HTML',
		async:'true',
		success: function(data) {
			$("body").hidenotify({"delay":200,"onclose":function(){}, loadanimation:false})
		},
		error: function(jqXHR, textStatus, errorThrown) {
			if($("#notifydiv").length == 0){
				$("body").notify({"text":"Отсутствует соединение с сервером","onopen":function(){}, loadanimation:false})
			}
			setTimeout(function(){refreshAction()}, 10000);
		}
	});
}

function loadingOutline(){
	$('#blockWindow, #loadingpage').css("display","block");
	$("body").css("cursor","wait")
}

function endLoadingOutline(){
	$('#loadingpage, #blockWindow').css("display","none");
	$("body").css("cursor","default")
	outline.isLoad=true;
	refresher()
}

function beforeOpenDocument(){
	$('#blockWindow, #loadingpage').css("display","block");
}

function subentry(id) {
	if($("subentry" + id).style.display == "none"){
		$('subentry' + id).style.display = "block"
	}else{
		$('subentry' + id).style.display = "block"
	}
}

function openXMLdoc(){
	window.location.href=window.location +"&onlyxml"
}

function openXMLdocView(curviewid){
	window.location.href="Provider?type=view&id="+curviewid+"&onlyxml"
}