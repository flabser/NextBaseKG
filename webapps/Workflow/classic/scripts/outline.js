var direction;
var n;
var cfg;
var sumReloadView;
var curlangOutline;
var timeout
var AppName = "WORKFLOW"

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
	filterauthor:'',
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
	_utf8_decode : function (utftext) {
		var string = "",
			i = 0,
			c = c1 = c2 = 0;
		while ( i < utftext.length ) {
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

function addDocToFav(el,docid,doctype){
	$.ajax({
		type: "GET",
		datatype:"XML",
		url: "Provider",
		data: "type=service&operation=add_to_favourites&id=add_to_favourites&key="+docid+"&doctype="+doctype+"&dbid=Avanti",
		cache:false,
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
		data: "type=service&operation=remove_from_favourites&id=remove_from_favourites&key="+docid+"&doctype="+doctype+"&dbid=Avanti",
		cache:false,
		success: function (msg){
			$(el).attr("src","/SharedResources/img/iconset/star_empty.png").attr("onclick","addDocToFav(this,"+docid+","+doctype+")")
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
	if($("input[name^='chbox']:checked").length != 0){
		var ck="";
		$("input[name^='chbox']:checked").each(function(indx, element){
			ck+=$(element).val()+"~"+$(element).attr("id")+"`";
		});
		ck =ck.substring(0, ck.length - 1);
		$.ajax({
			type: "GET",
			datatype:"XML",
			url: "Provider",
			data: "type=undelete&id=undelete&ck=" + ck +"&dbid=Avanti",
			cache:false,
			success: function (msg){
				restoredcount=$(msg).find('message[id=restored]').text();
				notrestoredcount=$(msg).find('message[id=notrestored]').text();
				divhtml ="<div id='dialog-message' title='Восстановление'>";
				divhtml+="<span style='text-align:center; font-size:13px;'>";
				divhtml+="<font>Документов восстановлено:"+restoredcount+"</font><br/>" ;
				if(notrestoredcount !=''){ divhtml+="<font>Документов не восстановлено:"+notrestoredcount+"</font>";}
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
	}else{
		infoDialog("Выберите документ для восстановления")
	}
}

function search(){
	$(".searchpan").html("");
	value=$("#searchInput").val();
	if(value.length==0){
		if ($.cookie("lang")=="RUS" || !$.cookie("lang"))
			message("Заполните строку поиска","searchInput");
		else if ($.cookie("lang")=="KAZ")
			message("Іздеу қатарын толтырыңыз","searchInput");
		else if ($.cookie("lang")=="ENG")
			message("Please fill the search field","searchInput");
	}else{
		//value = Url.encode(value)
		window.location="Provider?type=page&id=search&title=Поиск&keyword="+value;
	}
}

function closeSearch(){
	$(".searchpan").css("display","none");
	$("#searchInput").attr("value","");
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
function openParentDocView(element) {
	var elem = null,
		tr = $(element).closest("tr"),
		docid = $(element).attr("docid"),
		doctype = $(element).attr("doctype")
	$("<tr id='loadingparentdoc"+ docid +"' style='background: #fff'><td colspan='"+ $(element).children("td").length +"' style='text-align:center'><img src='classic/img/image_311968.gif'/></td></tr>").insertAfter(tr);
	$.ajax({
		  url: 'Provider?type=view&id=docthread&parentdocid='+docid+'&parentdoctype='+doctype+'&command=expand`'+docid+'`'+doctype,
		  datatype:'html',
		  success: function(data) {
			 elem = $(data);
			 $(element).closest("td").prevAll("td").each(function(){
				 $("<td></td>").insertBefore($(elem).children("#parentdoccell"))
			 })
			 $(elem).find("#parentdoccell").attr("colspan", $(element).closest("td").nextAll("td").length +1);
			 $("#loadingparentdoc"+docid).remove()
			 $(elem).insertAfter(tr);	
			 $(tr).next("tr").css("background","#fff").addClass("response"+docid+doctype)
			 $(tr).next("tr").find('font').each(function(){
				 $(this).html($(this).html().replace("--&gt;", "<img src='/SharedResources/img/classic/arrow_blue.gif'/>"));
			 });
		  }
	});	
	$(element).attr("src","/SharedResources/img/classic/1/minus1.png").attr("onclick","javascript:closeResponses(this)");
}


function closeResponses(element){
	var docid = $(element).attr("docid"),
		doctype = $(element).attr("doctype");
	$.get('Provider?type=view&id=docthread&command=collaps`'+docid+'`'+doctype, {})
	var tr = $(element).closest("tr").next("tr.response"+docid+doctype);
	$(tr).remove();
	$(element).attr("onclick","javascript:openParentDocView(this)").attr("src","/SharedResources/img/classic/1/plus1.png");
}

function checkAll(allChbox) {
	allChbox.checked ? $("input[name=chbox]").attr("checked","true") : $("input[name=chbox]").removeAttr("checked");
}

function refresher() {
	if (timeout != null || timeout != undefined){
		clearTimeout(timeout)
	}
	sumReloadView = 0
	$.cookie("refresh") !=null ? timeval= $.cookie("refresh") * 60000 : timeval=360000;
	timeout = setTimeout("refreshAction()", timeval);
}

function refreshAction() {
	outline.sumReloadView++;
	window.location.reload();
}

function doSearch(keyWord ,num){
	outline.curPage = num || outline.curPage;
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
				dialogAndFunction(text,func)
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
	color = $("#"+id).attr("bgcolor") || "#ffffff";
	$("#"+id).animate({backgroundColor: '#ffff99'}, 1000);
	$("#"+id).animate({backgroundColor: color}, 1000);
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
			count = $(data).find('query').text() || 0;
			$("#"+ idcount).html("<font style='font-size:12px'>["+count+"]</font>")
		}
	});
}

function chooseCategoryView(category){
	outline.filtercat = category
	updateView(outline.type, outline.viewid, outline.page, outline.command,  outline.sortField, outline.sortOrder)
}

function chooseProjectView(project){
	outline.filterproj = project
	updateView(outline.type, outline.viewid, outline.page, outline.command,  outline.sortField, outline.sortOrder)
}

function chooseStatusView(status){
	outline.filterstatus = status
	updateView(outline.type, outline.viewid, outline.page, outline.command,  outline.sortField, outline.sortOrder)
}

function chooseAuthorView(author){
	outline.filterauthor = author
	updateView(outline.type, outline.viewid, outline.page, outline.command,  outline.sortField, outline.sortOrder)
}

function chooseRespView(resp){
	outline.filterresp = resp
	updateView(outline.type, outline.viewid, outline.page, outline.command,  outline.sortField, outline.sortOrder)
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
	$("#tablecontent").animate({top:'-=29px'},'fast', function() {
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
	outline.type = type || outline.type;
	outline.viewid = viewid || outline.viewid;
	outline.curPage = page || outline.curPage;
	commandPart = '';
	if (command != null){
		outline.command = command;
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
	
	if($.cookie("lang")=="RUS" || !$.cookie("lang")){
		text="Cессия пользователя была закрыта сервером, для продолжения работы необходима повторная авторизация";
	}else if ($.cookie("lang")=="ENG"){
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
				$('body').html(data.split("<body>")[1].split("</body>")[0]);
				$.ajax({
					url: "Provider?type=view&id=mydocs_count&onlyxml",
					dataType:'xml',
					async:'true',
					success: function(data) {
						$("#counttoconsider").html($(data).find("toconsider").text());
						$("#counttaskforme").html($(data).find("taskforme").text());
						$("#countmytasks").html($(data).find("mytasks").text());
						$("#countcompletetask").html($(data).find("completetask").text());
						$("#countwaitforcoord").html($(data).find("waitforcoord").text());
						$("#countwaitforsign").html($(data).find("waitforsign").text());
						$("#countfavdocs").html($(data).find("favdocs").text());
					},
					error: function(data) {
						
					}
				});
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
	$('#blockWindow , #loadingpage').css("display","block");
	$("body").css("cursor","wait")
}

function endLoadingOutline(){
	$('#loadingpage ,#blockWindow').css("display","none");
	$("body").css("cursor","default")
	refresher()
}

function beforeOpenDocument(){
	$('#blockWindow , #loadingpage').css("display","block");
	$(window).unload(function(){ 
		$('#blockWindow , #loadingpage').css("display","none");
	});
}

function subentry(id) {
	if ($("subentry" + id).style.display == "none") {
		$('subentry' + id).style.display = "block"
	} else {
		$('subentry' + id).style.display = "block"
	}
}

function openXMLdoc(){
	window.location.href=window.location +"&onlyxml"
}

function openXMLdocView(curviewid){
	window.location.href="Provider?type=view&id="+curviewid+"&onlyxml"
}