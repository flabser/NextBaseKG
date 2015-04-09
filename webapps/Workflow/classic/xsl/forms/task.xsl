<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/fields/title"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:variable name="userid" select="/request/@userid"/>
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
	<xsl:variable name="filename" select="document/fields/pdocrtfcontent"/>
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Workflow документооборот - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<script type="text/javascript">
                    function AppletIsReady() {
                    <!--$.unblockUI();-->
                    $("#appstatus").text("Applet is ready!");
                    }
					$(document).ready(function(){
						<xsl:if test="$status  != 'new'">
							if($("#SignApplet").length !=0 ){
								sign="";
								app=document.getElementById('SignApplet');
								var items =$("#frm input[name][name!=signedfields][name!=key][name!=dbd][name != formsesid][name != taskvn]");
							    items.sort(function(a, b) {
							       return $(a).attr('name').toUpperCase().localeCompare($(b).attr('name').toUpperCase());
							    })
							    items.each(function(){
							        sign+=$(this).val()
							    })
                                state = app.verifyPKCS7(sign,'<xsl:value-of select="document/fields/signedfields"/>')
								switch(state){
									case false:
										$("#eds_status").text("Подпись не валидна")
										break;
									case true:
										$("#eds_status").text('Подпись валидна')
										$("#edsimg").attr("src","/SharedResources/img/iconset/key.png")
										$("#signtext, #signtexttr, #edsimg").css("visibility","visible")
										break;
									default:
										break;
								}
							}
						</xsl:if>
						$("#progressDiv a[href *= '<xsl:value-of select="document/@id"/>']").attr("style","font-weight:bold;")
						hotkeysnav()
					})
   					<![CDATA[
   						function hotkeysnav() {
							$(document).bind('keydown', function(e){
			 					if (e.ctrlKey) {
			 						switch (e.keyCode) {
									   case 66:
									   		<!-- клавиша b -->
									     	e.preventDefault();
									     	$("#canceldoc").click();
									      	break;
									   case 69:
									   		<!-- клавиша e -->
									     	e.preventDefault();
									     	$("#btnexecution").click();
									      	break;
									   case 71:
									  		<!-- клавиша g -->
									     	e.preventDefault();
									     	$("#btngrantaccess").click();
									      	break;
									   case 87:
									  		<!-- клавиша w -->
									     	e.preventDefault();
									     	$("#btnremind").click();
									      	break;
									   case 83:
									   		<!-- клавиша s -->
									     	e.preventDefault();
									     	$("#btnsavedoc").click();
									      	break;
									   case 84:
									   		<!-- клавиша t -->
									     	e.preventDefault();
									     	$("#btnnewkr").click();
									      	break;
									   case 85:
									   		<!-- клавиша u -->
									     	e.preventDefault();
									     	window.location.href=$("#currentuser").attr("href")
									      	break;
									   case 81:
									   		<!-- клавиша q -->
									     	e.preventDefault();
									     	window.location.href=$("#logout").attr("href")
									      	break;
									   case 72:
									   		<!-- клавиша h -->
									     	e.preventDefault();
									     	window.location.href=$("#helpbtn").attr("href")
									      	break;
									   case 73:
									   		<!-- клавиша i -->
									     	e.preventDefault();
									     	window.location.href=$("#helpbtn").attr("href")
									      	break;
									   default:
									      	break;
									}
			   					}
							});
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btncoordyes").hotnav({keysource:function(e){ return "y"; }});
							$("#btngrantaccess").hotnav({keysource:function(e){ return "g"; }});
							$("#btnremind").hotnav({keysource:function(e){ return "w"; }});
							$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
							$("#btnexecution").hotnav({keysource:function(e){ return "e"; }});
							$("#btnnewkr").hotnav({keysource:function(e){ return "t"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
							$("#btnnewish").hotnav({keysource:function(e){ return "i"; }});
						}
					]]>
				</script>
				<xsl:if test="$editmode = 'edit'">
					<script>
						var _calendarLang = "<xsl:value-of select="/request/@lang"/>";
						$(function() {
							$('#ctrldate').datepicker({
								showOn: 'button',
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								buttonText: "Изменить срок исполнения",
								regional:['ru'],
								monthNames: calendarStrings[_calendarLang].monthNames,
								monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
								dayNames: calendarStrings[_calendarLang].dayNames,
								dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
								dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
								weekHeader: calendarStrings[_calendarLang].weekHeader,
								yearSuffix: calendarStrings[_calendarLang].yearSuffix,
								showAnim: '',
								changeYear : true,
								changeMonth : true,
								minDate:0,
								maxDate:'<xsl:value-of select="document/fields/maxdate"/>',
								yearRange: '-0y:+1y',
								onSelect: function(selectedDate) {
									$.ajax({
										url: 'Provider?type=page&amp;id=getdiffctrldate&amp;enddate='+ selectedDate,
										datatype:'xml',
										async:'true',
										cache:false,
										success: function(data) {
											diff= $(data).find("getdiffctrldate").find("daydiff").text();
											$("[name=dbd]").val(diff)
											if (diff >= 0){
												diff = "(Осталось дней : " + diff+")"
												$(".diffdate").css("color","#000");
											}else{
												diff = "(Просрочено дней : " + diff.toString().split("-")[1] +")";
												$(".diffdate").css("color","red");
											}
											$(".diffdate").text(diff)
										}
									});
								}
							});
						});
						function resultdiffdate(date){
							var m = 60 * 1000; 
							var h = m * 60 ; 
							var d = h * 24 ; 
						}
					</script>
				</xsl:if>
			
			<!-- <script>
					$(document).ready(function(){
					    $.ajax({
							url: "Provider?type=query&amp;id=bossandemppicklist",
							dataType: "xml",
							success: function( xmlResponse ) {
								var data = $( "entry[doctype=889]", xmlResponse ).map(function() {
									return {
										value: $(this).attr("viewtext"),
										id: $(this).children("userid").text()
									};
								}).get();
									$( "#executor" ).autocomplete({
										source: data,
										minLength: 0,
										select: function(event, ui) {
											$("input[name=executor]").remove()
											<![CDATA[$("#frm").append("<input type='hidden' name='executor'></input>")]]>
											$("input[name=executor]").val(ui.item.id+"`1`0``")
										},
										change: function() {
											$(this).val('');
											$("input[name=executor]").remove();
										}
									});
									$( "#taskauthor" ).autocomplete({
										source: data,
										minLength: 0,
										select: function(event, ui) {
											$("input[name=taskauthor]").remove()
											<![CDATA[$("#frm").append("<input type='hidden' name='taskauthor'></input>")]]>
											$("input[name=taskauthor]").val(ui.item.id)
										},
										change: function() {
											//$(this).val('');
											//$("input[name=taskauthor]").remove();
										}
									});
								}
							});
						});
  				</script> -->
				 <xsl:if test="$editmode = 'edit'">
					<xsl:call-template name="htmlareaeditor"/>
				</xsl:if>
				 <xsl:call-template name="markisread"/>
			</head>
			<body>
				<div id="docwrapper">
					<!-- applet here
					<xsl:if test="document/@canbesign = '1'">
						<applet id="SignApplet" code="kz.pchelka.digitalsign.Sign" width="200" height="200"
							archive = "digitalSignApplet.jar,saxon9he.jar,servlet-api.jar" codebase = ".">
						</applet>	
					</xsl:if> -->
                    <xsl:if test="document/@canbesign = '1'">
                        <applet id="SignApplet" code="kz.softkey.iola.applet.MainApplet" width="10" height="10" archive="softkey_jce_applet-1.2.jar, softkey_jce_iola-2.2.jar,  xmlsec-1.4.4.jar, commons-logging-1.1.1.jar" codebase=".">
                            <param name="fileExtension" value="P12"></param>
                        </applet>
                </xsl:if>
                    <xsl:call-template name="documentheader"/>
					<div class="formwrapper">
						<div class="formtitle">
							<div style="float:left" class="title">
								<xsl:call-template name="isresol"/><span id="whichreadblock">Прочтен</span>
							</div>
						</div>
						<div class="button_panel">
							<span style=" vertical-align:12px; float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="get_document_accesslist"/>
								<xsl:call-template name="save"/>
								<xsl:call-template name="eds_sign"/>
								<xsl:if test="$status !='new'">
									<xsl:choose>
										<xsl:when test="document/fields/tasktype ='RESOLUTION'">
											<xsl:call-template name="newkp"/>
										</xsl:when>
										<xsl:when test="document/fields/tasktype ='CONSIGN'">
											<xsl:call-template name="newkp"/>
										</xsl:when>
										<xsl:when test="document/fields/tasktype = 'TASK'">
											<xsl:call-template name="newkp"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="newkr"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:call-template name="newki"/>
									<xsl:call-template name="newoutdocprj"/>
									<xsl:call-template name="newworkdocprj"/>
									<xsl:call-template name="resetcontrol"/>
								</xsl:if>
								<!-- кнопка "напомнить" -->
								<xsl:call-template name="remind"/>
								<!-- кнопка "ознакомить" -->
								<xsl:call-template name="acquaint"/>
							</span>
							<span style="float:right" class="bar_right_panel">
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-1"><xsl:value-of select="document/captions/properties/@caption"/></a>
	                  			</li>
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-2"><xsl:value-of select="document/captions/content/@caption"/></a>
	                  			</li>
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-3"><xsl:value-of select="document/captions/control/@caption"/></a>
	                  			</li>
	                  			<xsl:if test="$status != 'new'">
		                  			<li class="ui-state-default ui-corner-top">
										<a href="#tabs-4"><xsl:value-of select="document/captions/progress/@caption"/></a>
									</li>
								</xsl:if>
	                  			<li class="ui-state-default ui-corner-top">
	                  				<a href="#tabs-5"><xsl:value-of select="document/captions/attachments/@caption"/></a>
	                  				<img id="loading_attach_img" style="vertical-align:-8px; margin-left:-10px; padding-right:3px; visibility:hidden" src="/SharedResources/img/classic/ajax-loader-small.gif"></img>
	                  			</li>
	                  			<xsl:if test="document/@parentdocid !='0'">
		                  			<li class="ui-state-default ui-corner-top">
										<a href="#tabs-7"><xsl:value-of select="document/captions/parentdoccontent/@caption"/></a>
									</li>
								</xsl:if>
	                 			<li class="ui-state-default ui-corner-top">
	                 				<a href="#tabs-6"><xsl:value-of select="document/captions/additional/@caption"/></a>
	                 			</li>
		                 		<span style="float:right; font-size:11px; font-weight:normal;">
									<b class="text"><xsl:value-of select="document/captions/author/@caption"/>: </b> 
									<font class="text" style="padding-right:7px;"><xsl:value-of select="document/fields/author"/> </font>
									<xsl:if test="$status != 'new'">
										<img id="edsimg" style="max-width:14px; margin-right:5px; margin-left:2px; visibility:hidden" title="Документ подписан ЭЦП - Подпись верна"/>
										<font class="text">
											<xsl:choose>
												<xsl:when test="document/fields/control/allcontrol = '1'">
													<xsl:attribute name="style">color:red;</xsl:attribute>
													<xsl:value-of select="document/captions/incontrol/@caption"/>
												</xsl:when>
												<xsl:when test="document/fields/control/allcontrol = '0'">
													<xsl:value-of select="document/captions/removedofcontrol/@caption"/>
												</xsl:when>
											</xsl:choose>
										</font>
									</xsl:if>
									<xsl:if test="document/fields/isold = '1'">
										<font class="text">
											Устаревший
										</font>
									</xsl:if>
								</span>
              				</ul>
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
									<br/>
									<table width="100%" border="0">
										<xsl:if test="document/@parentdocid = 0 and $status != 'new'">
											<tr>
												<td class="fc">
													<font style="vertical-align:top">
														<xsl:value-of select="document/captions/taskvn/@caption"/> :
													</font>
												</td>
												<td>
													<table>
														<tr>
															<td style="width:170px;" class="td_noteditable">
																<xsl:value-of select="document/fields/taskvn"/>
															</td>
														</tr>
													</table>
													<input type="hidden" name="taskvn" value="{document/fields/taskvn}"/>
												</td>
											</tr>
										</xsl:if>
										<!-- Дата резолюции -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/taskdate/@caption"/> :
											</td>
											<td>
												<table>
													<tr>
														<td style="width:170px;" class="td_noteditable">
															<xsl:value-of select="document/fields/taskdate"/>
														</td>
														<td style="padding-left:10px">
															<xsl:value-of select="document/captions/ctrldate/@caption"/> :
														</td>
														<td>
															<input type="text" id="controldate2" maxlength="10" class="td_noteditable" style="width:80px;" value="{substring(document/fields/control/primaryctrldate,1,10)}"/>
															<xsl:variable name="cd" select="concat(current-date(),' ')"/>
															<font class="diffdate" style="margin-left:10px; font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; vertical-align:3px">
																<xsl:if test="document/fields/control/diff &lt; 0 ">
																	<xsl:attribute name="color">red</xsl:attribute>
																</xsl:if>
																(<xsl:if test="document/fields/control/diff &gt; 0 or document/fields/control/diff = 0">
																	<xsl:value-of select="document/captions/remaineddays/@caption"/>
																</xsl:if>
																<xsl:if test="document/fields/control/diff &lt; 0 ">
																	<xsl:value-of select="document/captions/delayeddays/@caption"/>
																</xsl:if>
																: <xsl:value-of select="replace(document/fields/control/diff,'-','')"/>)
															</font>
														</td>
													</tr>
												</table>
												<input type="hidden" name="taskdate" value="{substring(document/fields/taskdate,1,10)}"/>
											</td>
										</tr>
										<xsl:if test="document/fields/grandpardocid !=''">
											<tr>
												<td class="fc">
													<font style="vertical-align:top">
														Головной документ :
													</font>
												</td>
												<td>
													<a href="" class="doclink" style="margin-left:3px">
														<xsl:attribute name="href">Provider?type=document&amp;id=<xsl:value-of select="document/fields/grandparform" />&amp;key=<xsl:value-of select="document/fields/grandpardocid" /></xsl:attribute>
														<xsl:value-of select="document/fields/pdocviewtext"/>
													</a>
													<xsl:if test="$filename!=''">
														<a href="">
															<xsl:attribute name="href">Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
															<img src="/SharedResources/img/classic/icons/attach.png" style="margin-left:5px"/>
														</a>
													</xsl:if>
												</td>
											</tr>
										</xsl:if>
										
										<!-- исполнители -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/executors/@caption"/> :
												</font>
												<xsl:if test="$editmode = 'edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','true','executor','frm', 'intexectbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</xsl:if>
											</td>
											<td>
<!-- 												<input id="executor" style="width:600px"></input> -->
												<table id="intexectbl">
													<xsl:if test="document/fields/executors/entry/user =''">
														<tr>
														<!--<input id="tags"/>-->
															 <td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="executor"/>&#xA0;
															</td> 
														</tr>
													</xsl:if>
													<xsl:if test="not(document/fields/execblock/executors/entry)">
														<tr>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																&#xA0;
															</td>
														</tr>
													</xsl:if>
													<xsl:for-each select="document/fields/execblock/executors/entry[type='INTERNAL']">
														<tr>
															<xsl:variable name="num" select="position()"/>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="fullname"/>&#xA0;
															</td>
															<td>
																<xsl:if test="$num =1 and /request/document/@parentdocid = 0">
																	<img src='/SharedResources/img/classic/icons/bullet_yellow.png' style='height:16px' title='ответственный'/>
																</xsl:if>
															</td>
														</tr>
													</xsl:for-each>
												</table>
												<input type="hidden" id="executorcaption" value="{document/captions/executors/@caption}"/>
											</td>
										</tr>
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/extexecutors/@caption"/> :
												</font>
												<xsl:if test="$editmode = 'edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('corrcat','true','extexecutor','frm', 'extexectbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="extexectbl">
													<xsl:if test="document/fields/exexecutors/entry/user =''">
														<tr>
														<!--<input id="tags"/>-->
															 <td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="executor"/>&#xA0;
															</td> 
														</tr>
													</xsl:if>
													<xsl:if test="count(document/fields/execblock/executors/entry[type='EXTERNAL']) = 0">
														<tr>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																&#xA0;
															</td>
														</tr>
													</xsl:if>
													<xsl:for-each select="document/fields/execblock/executors/entry[type='EXTERNAL']">
														<tr>
															<xsl:variable name="num" select="position()"/>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="fullname"/>&#xA0;
															</td>
														</tr>
													</xsl:for-each>
												</table>
												<input type="hidden" id="extexecutorcaption" value="{document/captions/extexecutors/@caption}"/>
											</td>
										</tr>
										<!-- поле "Проект" -->
										<xsl:if test="not(document/fields/project/@mode = 'hide')">
											<tr style="padding-top:103px">
												<td class="fc" style="padding-top:3px"><xsl:value-of select="document/captions/conectedproject/@caption"/> :</td>
												<td style="padding-top:3px">
													<xsl:variable name="project" select="document/fields/project/@attrval"/>
													<xsl:variable name="parentproject" select="document/fields/parentproject"/>
													<select size="1" name="project" style="width:612px;" class="select_editable" autocomplete="off">
														<xsl:if test="$parentproject != ''">
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<xsl:attribute name="disabled">disabled</xsl:attribute>
														</xsl:if>		
														<xsl:if test="$editmode !='edit'">
															<xsl:attribute name="disabled"/>
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<option value="{document/fields/project/@attrval}">
																<xsl:attribute name="selected">selected</xsl:attribute>
																<xsl:value-of select="document/fields/project"/>
															</option>
														</xsl:if>
														<xsl:if test="$editmode ='edit'">
															<option value=" ">
																<xsl:attribute name="selected">selected</xsl:attribute>
																&#xA0;
															</option>
														</xsl:if>
														<xsl:for-each select="document/glossaries/projects/query/entry">
															<option value="{@docid}">
																<xsl:if test="$project = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:if test="$parentproject = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
													<xsl:if test="$editmode !='edit'">
														<input type='hidden' name="project" value="{document/fields/project/@attrval}"/>
													</xsl:if>
												</td>
											</tr>
										</xsl:if>
										<!-- поле "Категория" -->
										<xsl:if test="not(document/fields/category/@mode = 'hide')">
											<tr>
												<td class="fc" style="padding-top:5px"><xsl:value-of select="document/captions/category/@caption"/> :</td>
												<td style="padding-top:5px">
													<xsl:variable name="category" select="document/fields/category/@attrval" />
													<xsl:variable name="parentcategory" select="document/fields/parentcategory"/>
													<select size="1" name="category" style="width:611px;" class="select_editable" autocomplete="off">
														<xsl:if test="$parentcategory != ''">
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<xsl:attribute name="disabled"/>
														</xsl:if>
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<xsl:attribute name="disabled"/>
															<option value="">
																<xsl:attribute name="selected">selected</xsl:attribute>
																<xsl:value-of select="document/fields/category"/>
															</option>
														</xsl:if>
														<xsl:if test="$editmode = 'edit'">
															<option value=" ">
																<xsl:attribute name="selected">selected</xsl:attribute>
																&#xA0;
															</option>
														</xsl:if>
														<xsl:for-each select="document/glossaries/category/query/entry">
															<option value="{@docid}">
																<xsl:if test="$category = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:if test="$parentcategory = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
													<xsl:if test="$editmode !='edit'">
														<input type='hidden' name="category" value="{document/fields/category/@attrval}"/>
													</xsl:if>
												</td>
											</tr>
										</xsl:if>
										<!-- поле "Характер вопроса" 
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/fields/har/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<xsl:variable name="har" select="document/fields/har/@attrval"/>
												<xsl:variable name="parenthar" select="document/fields/parenthar"/>
												<select name="har" style="width:612px;" class="select_editable">
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"></xsl:attribute>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
													</xsl:if>
													<xsl:if test="$parenthar != ''">
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<xsl:attribute name="disabled"/>
													</xsl:if>
													<xsl:for-each select="document/glossaries/har/query/entry">
														<option value="{@docid}">
															<xsl:if test="$har = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:if test="$parenthar = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="@viewtext"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>-->
										<!-- поле "Краткое содержание" -->
											<tr>
												 <td class="fc" style="padding-top:5px">
													<xsl:value-of select="document/captions/briefcontent/@caption"/> :
												</td> 
												<td style="padding-top:5px">
													<div>
														<textarea name="briefcontent" rows="3"  tabindex="3" style="width:750px" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="class">textarea_editable</xsl:attribute>
																<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
															</xsl:if>
															<xsl:if test="count(document/fields/briefcontent) != 0">
																<xsl:value-of select="document/fields/briefcontent"/>
															</xsl:if>
															<xsl:if test="count(document/fields/briefcontent) = 0">
																<xsl:value-of select="document/fields/comment"/>
															</xsl:if>
														</textarea>
													</div>
												</td>
											</tr>
										<!-- поле "Примечание" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/comment/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<div>
													<textarea name="comment" rows="5" tabindex="3" style="width:750px" autocomplete="off">
														<xsl:if test="$editmode !='edit'">
															<xsl:attribute name="readonly"/>
															<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:if test="$editmode = 'edit'">
															<xsl:attribute name="class">textarea_editable</xsl:attribute>
															<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
															<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
														</xsl:if>
													<xsl:value-of select="document/fields/comment"/>
												</textarea>
											</div>
										</td>
									</tr>
									<xsl:if test="document/@status !='new'">
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/notesexecuted/@caption"/> :
											</td>
											<td>
												<div style="display:block; width:90%" id="ki">
													<div style="width:100%; font-size:15px"></div>
													<table id="kiTBL" style=" width:100%"/>
													<script>
														$.ajax({
															url: 'Provider?type=view&amp;id=docthread&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>&amp;onlyxml',
															datatype:'xml',
															async:'true',
															success: function(data) {
																$(data).find("responses").find("entry[doctype=898]").each(function(index, element){
																	text = $(this).find("viewtext").text()
																	link = $(this).attr("url")
																	$("#kiTBL").append('<tr><td><a class="doclink" href="'+link+'">'+text+'</a></td></tr>')
																})
															}
														});
													</script>
													<br/>
												</div>
											</td>
										</tr>
									</xsl:if>
								</table>
							</div>
							<div id="tabs-2">
								<br/>
								<table width="100%" border="0">
									<!-- поле "Текст резолюции" -->
										<tr>
											<td style="padding-left:30px;">
												<script type="text/javascript">  
													$(document).ready(function($) {
												   		 CKEDITOR.config.width = "815px"
												   		 CKEDITOR.config.height = "450px"
												   	});
												</script>
												<xsl:if test="$editmode = 'edit'">
													<textarea id="MyTextarea" name="content">
														<xsl:if test="@useragent = 'ANDROID'">
															<xsl:attribute name="style">width:500px; height:300px</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/content"/>
													</textarea>
												</xsl:if>
												<xsl:if test="$editmode != 'edit'">
													<div id="briefcontent">
														<xsl:attribute name="style">width:815px; height:450px; background:#EEEEEE; padding: 3px 5px; overflow-x:auto</xsl:attribute>
														<script>
															$("#briefcontent").html("<xsl:value-of select='document/fields/content'/>")
														</script>
													</div>
													<input type="hidden" name="content" value="{document/fields/content}"/>
												</xsl:if>
											</td>
										</tr>
								</table>
							</div>
							<div id="tabs-3">
								<br/>
								<table width="100%" border="0">
									<tr>
										<td class="fc" >
											<xsl:value-of select="document/captions/controltype/@caption"/> :
										</td>
										<td>
											<xsl:variable name="controltype" select="document/fields/controltype"/>
											<select size="1" name="controltype" style="width:300px;" class="select_editable" autocomplete="off">
												<xsl:if test="$editmode !='edit'">
													<xsl:attribute name="disabled"/>
													<xsl:attribute name="class">select_noteditable</xsl:attribute>
													<option value="">
														<xsl:attribute name="selected">selected</xsl:attribute>
														<xsl:value-of select="document/fields/controltype"/>
													</option>
												</xsl:if>
												<xsl:for-each select="document/glossaries/controltype/query/entry">
													<option value="{@docid}">
														<xsl:if test="$controltype = @docid">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="viewcontent/viewtext1"/>
													</option>
												</xsl:for-each>
											</select>
											<xsl:if test="$editmode != 'edit'">
												<input type="hidden" name="controltype" value="document/fields/controltype"/>
											</xsl:if>
										</td>
									</tr>
									<tr>
										<td class="fc" style="padding-top:5px;position:relative;top:0px;">
											<xsl:value-of select="document/captions/ctrldate/@caption"/> :
										</td>
										<td style="padding-top:5px">
											<input type="text" name="primaryctrldate" maxlength="10" autocomplete="off" class="td_editable" style="width:80px; vertical-align:top" value="{substring(document/fields/control/primaryctrldate,1,10)}">
												<xsl:if test="$editmode = 'edit'">
													<xsl:attribute name="id">ctrldate</xsl:attribute>
												</xsl:if>
												<xsl:if test="$editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
											<xsl:variable name="cd" select="concat(current-date(),' ')"/>
											<font class="diffdate" style="margin-left:10px; font-size:13px; font-family:Verdana,Arial,Helvetica,sans-serif; vertical-align:3px">
												<xsl:if test="document/fields/control/diff &lt; 0 ">
													<xsl:attribute name="color">red</xsl:attribute>
												</xsl:if>
												(<xsl:if test="document/fields/control/diff &gt; 0 or document/fields/control/diff = 0">
													<xsl:value-of select="document/captions/remaineddays/@caption"/>
												</xsl:if>
												<xsl:if test="document/fields/control/diff &lt; 0 ">
													<xsl:value-of select="document/captions/delayeddays/@caption"/>
												</xsl:if>
												: <xsl:value-of select="replace(document/fields/control/diff,'-','')"/>)
											</font>
										</td>
									</tr>
									<tr>
										<td class="fc">
											<xsl:value-of select="document/captions/cyclecontrol/@caption" /> :
										</td>
										<td>
											<table>
												<tr>
													<td>
														<input type="radio" name="cyclecontrol" value="1" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/control/cyclecontrol = '1'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:if test="$status  = 'new'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/onceonly/@caption"/>
														</input>
														<xsl:if test="$editmode !='edit'">
															<input type="hidden" name="cyclecontrol" value="{document/fields/control/cyclecontrol}"/>
														</xsl:if>
													</td>
													<td>
														<input type="radio" name="cyclecontrol" value="3" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/control/cyclecontrol = '3'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/weekly/@caption"/>
														</input>
													</td>
												</tr>
												<tr>
													<td>
														<input type="radio" name="cyclecontrol" value="4" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/control/cyclecontrol = '4'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/monthly/@caption"/>
														</input>
													</td>
													<td>
														<input type="radio" name="cyclecontrol" value="5" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/control/cyclecontrol = '5'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/quarterly/@caption"/>
														</input>
													</td>
													<td>
														<input type="radio" name="cyclecontrol" value="6" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/control/cyclecontrol = '6'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/semiannual/@caption"/>
														</input>
													</td>
													<td>
														<input type="radio" name="cyclecontrol" value="7" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/control/cyclecontrol = '7'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/annually/@caption"/>
														</input>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td class="fc"><xsl:value-of select="document/captions/removcontrol/@caption"/> :</td>
										<td>
											<table id="intexectable" class="table-border-gray">
												<tr>
													<td style="text-align:center; width:29%">
														<xsl:value-of select="document/captions/performer/@caption"/>
													</td>
													<td style="text-align:center; width:17%">
														<xsl:value-of select="document/captions/date/@caption"/>
													</td>
													<td style="text-align:center; width:27%">
														<xsl:value-of select="document/captions/removedby/@caption"/>
													</td>
													<td style="text-align:center; width:3%"></td>
													<!-- <td style="text-align:center; width:22%">Исполненено</td> -->
												</tr>
												<xsl:for-each select="document/fields/execblock/executors/entry">
													<tr class="{type}">
														<td>
															<xsl:value-of select="shortname"/>
															<input type="hidden" class="idContrExec" value="{shortname/@attrval}"/>
															<xsl:variable name="type" select="if (type = 'INTERNAL') then '1' else '2'"/>
															<xsl:variable name="fieldname" select="if (type = 'INTERNAL') then 'executor' else 'extexecutor'"/>
															<input autocomplete="off" type="hidden" name="{$fieldname}" class="controlres" value="{$type}`{shortname/@attrval}`{responsible}`{resetdate}`{resetauthorid}"/>
															<input type="hidden" id="executorid" value="{shortname/@attrval}"/>
															<input type="hidden" id="controlOffDate" value="{resetdate}"/>
															<input type="hidden" class="responsible" value="{responsible}"/>
															<input type="hidden" id="resetauthor" value="{resetauthorid}"/>
														</td>
														<td class="controlOffDate">
															<xsl:value-of select="resetdate"/>
														</td>
														<td class="idCorrControlOff">
															<xsl:value-of select="resetauthorname"/>
														</td>
														<td style="text-align:center" class="switchControl">
															<xsl:variable name="pos" select="position()"/>
															<xsl:if test="/request/document/actionbar/action[@id='reset']/@mode = 'ON'">
																<xsl:choose>
																	<xsl:when test="string-length(resetauthorname) != 0">
																		<img style="cursor:pointer" src="/SharedResources/img/classic/icons/accept.png">
																			<xsl:attribute name="onclick">javascript:controlOn(this)</xsl:attribute>
																			<xsl:attribute name="title"><xsl:value-of select="/request/document/captions/putundercontrol/@caption"/></xsl:attribute>
																		</img>
																	</xsl:when>
																	<xsl:otherwise>
																		<img style="cursor:pointer" src="/SharedResources/img/classic/icons/eye.png">
																			<xsl:attribute name="onclick">javascript:controlOff(this)</xsl:attribute>
																			<xsl:attribute name="title"><xsl:value-of select="/request/document/captions/removcontrol/@caption"/></xsl:attribute>
																		</img>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:if>
															<xsl:if test="not(/request/document/actionbar/action[@id='reset'])">
																<xsl:attribute name="style">background:#dfdfdf; text-align:center</xsl:attribute>
																<xsl:choose>
																	<xsl:when test="string-length(resetauthorname) != 0">
																		<img  src="/SharedResources/img/classic/icons/accept.png"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<img src="/SharedResources/img/classic/icons/eye.png"/>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:if>
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</td>
									</tr>
								</table>
							</div>
							<div id="tabs-4" style="height:500px">
								<xsl:if test="$status !='new'">
									<div display="block" style="display:block; width:90%; margin-left:25px; font-size:14px" id="execution">
											<br/>
											<div id="progressDiv" style="width:99%; overflow:hidden">
												<table>
													<tr>
														<td>
															<xsl:if test="document/fields/progress/entry[1]/viewtext !=''">
									 							<a href="{document/fields/progress/entry/@url}" class="doclink" style="color:blue; margin-left:3px; vertical-align:7px">
									 								<xsl:value-of select="document/fields/progress/entry[1]/viewtext"/>
									  							</a>
									  						</xsl:if>
															<xsl:if test="document/fields/progress/entry/viewtext ='' and $status = 'new'">
									  							<xsl:value-of select="document/fields/title"/>
									  						</xsl:if>
							  							</td>
							  						</tr>
					  								<xsl:apply-templates select="document/fields/progress/entry/responses[entry]"/>
					  							</table>
											</div>
										</div>
									</xsl:if>
								</div>
							<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
							<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
							<xsl:for-each select="extexecid/item">
								<input type="hidden" name="extexecid" id="extexecid" value="{.}"/>
							</xsl:for-each>
							<!-- Скрытые поля -->
							<input type="hidden" name="isresol" value="{isresol}"/>
							<input type="hidden" name="type" value="save"/>
							<input type="hidden" name="id" value="task"/>
							<input type="hidden" name="taskauthor" value="{document/fields/taskauthor/@attrval}"/>
							<input type="hidden" name="allcontrol" value="{document/fields/control/allcontrol}"/>
							<input type="hidden" name="dbd" value="{document/fields/dbd}">
								<xsl:if test="document/@status = 'new'">
									<xsl:attribute name="value">30</xsl:attribute>
								</xsl:if>
							</input>
							<input type="hidden" name="tasktype">
								<xsl:choose>
									<xsl:when test="document/fields/tasktype = 'RESOLUTION'">
										<xsl:attribute name="value">RESOLUTION</xsl:attribute>
									</xsl:when>
									<xsl:when test="document/fields/parenttasktype=''">
										<xsl:attribute name="value">RESOLUTION</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="value">CONSIGN</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</input>
							<input type="hidden" name="doctype" value="{document/@doctype}"/>
							<input type="hidden" name="key" value="{document/@docid}"/>
							<div id="executers" style="display:none">
								<table style="width:100%">
									<xsl:for-each select="document/fields/executors/entry">
										<tr>
											<td>
												<input type="checkbox" name="chbox" value="{user}" id="{user/@attrval}">
													<xsl:if test="user/@attrval =''">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
												</input>
											</td>
											<td>
												<font class="font" style="font-family:verdana; font-size:13px; margin-left:2px">
													<xsl:if test="user/@attrval =''">
														<xsl:attribute name="color">gray</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="user"/>
												</font>
											</td>
										</tr>
									</xsl:for-each>
								</table>
							</div>
							<input type="hidden" id="currentuserid" value="{@userid}"/>
							<input type="hidden" id="localusername" value="{@username}"/>
<!-- 							<xsl:call-template name="ECPsignFields"/> -->
						</form>
						<div id="tabs-5">
							<br/>
							<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
								<input type="hidden" name="type" value="rtfcontent"/>
								
								<input type="hidden" name="formsesid" value="{formsesid}"/>
								<xsl:call-template name="attach"/>
							</form>
						</div>
						<xsl:if test="document/@parentdocid !='0'">
								<div id="tabs-7">
									<br/>
									<table width="100%" border="0">
										<!-- поле "Текст резолюции" -->
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/content/@caption"/> :</td>
												<td>
													<div id="parentdoccontent">
														<xsl:attribute name="style">width:815px; height:450px; background:#EEEEEE; padding: 3px 5px; overflow-x:auto</xsl:attribute>
														<script>
															$("#parentdoccontent").html("<xsl:value-of select='document/fields/pdoccontent'/>")
														</script>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="2">
												<div id="textprintpreview" style="display:none; overflow:visible">
													</div>
													<script>
														$("#textprintpreview").html("<xsl:value-of select='document/fields/content'/>");
													</script>
												</td>
											</tr>
									</table>
								</div>
							</xsl:if>
						<div id="tabs-6">
							<xsl:call-template name="docinfo"/>
						</div>
					</div>
					<div style="height:10px"/>
				</div>
			</div>
			<xsl:call-template name="formoutline"/>
		</body>
	</html>
	</xsl:template>

<xsl:template match="responses">
	<tr class="response{../@docid}">
		<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
		<td nowrap="true">
			<xsl:apply-templates mode="line"/>
		</td>
	</tr>
</xsl:template>
	
<xsl:template match="entry" mode="line">
	<div class="Node" style="overflow:hidden; height:22px" id="{@docid}{@doctype}">
		<xsl:call-template name="graft"/>
		<xsl:apply-templates select="." mode="item"/>
	</div>
	<xsl:apply-templates mode="line"/>
</xsl:template>
	
<xsl:template match="viewtext" mode="line"></xsl:template>
	
<xsl:template match="entry" mode="item">
	<a href="{@url}" title="{viewtext}" class="doclink" style="font-style:Verdana,​Arial,​Helvetica,​sans-serif; width:100%; font-size:97%; margin-left:2px">
		<xsl:variable name='simbol'>'</xsl:variable>
		<font id="font{@docid}{@doctype}" style="line-height:19px">
			<xsl:value-of select="replace(viewtext, '&amp;gt;', '->')"/>
		</font>
	</a>
</xsl:template>

<xsl:template name="graft">
	<xsl:apply-templates select="ancestor::entry" mode="tree"/>
	<xsl:choose>
		<xsl:when test="following-sibling::entry">
			<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_tee.gif"/>
		</xsl:when>
		<xsl:otherwise>
			<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_corner.gif"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
	
<xsl:template match="responses" mode="tree"/>
<xsl:template match="*" mode="tree">
	<xsl:choose>
		<xsl:when test="following-sibling::*">
			<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_bar.gif"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="parent::responses">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:if>
			<xsl:if test="parent::entry">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>
</xsl:stylesheet>