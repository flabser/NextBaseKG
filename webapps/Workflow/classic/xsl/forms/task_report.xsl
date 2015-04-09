<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype">Отчет</xsl:variable>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Workflow документооборот - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<script type="text/javascript">
   					$(document).ready(function(){hotkeysnav()})
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
									     	$("#generatereport").click();
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
							$("#generatereport").hotnav({keysource:function(e){ return "s"; }});
							$("#btnexecution").hotnav({keysource:function(e){ return "e"; }});
							$("#btnnewkr").hotnav({keysource:function(e){ return "t"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
							$("#btnnewish").hotnav({keysource:function(e){ return "i"; }});
						}
					]]>
				</script>
				<xsl:if test="$editmode='edit'">
					<xsl:if test="/request/@lang = 'RUS'">
						<script>
							var _calendarLang = "<xsl:value-of select="/request/@lang" />";
							$(function() {
								$("textarea:not([readOnly]):first").focus();
							});
							$(function() {
								var dates = $( "#ctrldatefrom, #ctrldateto").datepicker({
								defaultDate: "+1w",
								showOn: "button",
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								changeMonth: true,
								numberOfMonths: 1,
								monthNames: calendarStrings[_calendarLang].monthNames,
								monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
								dayNames: calendarStrings[_calendarLang].dayNames,
								dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
								dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
								weekHeader: calendarStrings[_calendarLang].weekHeader,
								yearSuffix: calendarStrings[_calendarLang].yearSuffix,
								onSelect: function( selectedDate ) {
									var option = this.id == "ctrldatefrom" ? "minDate" : "maxDate",
									instance = $( this ).data( "datepicker" ),
									date = $.datepicker.parseDate(
									instance.settings.dateFormat ||
									$.datepicker._defaults.dateFormat,
									selectedDate, instance.settings );
									dates.not( this ).datepicker( "option", option, date );
								}
							});
							});
							$(function() {
								var dates = $( "#taskdatefrom, #taskdateto" ).datepicker({
								defaultDate: "+1w",
								changeMonth: true,
								numberOfMonths: 1,
								showOn: "button",
								monthNames: calendarStrings[_calendarLang].monthNames,
								monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
								dayNames: calendarStrings[_calendarLang].dayNames,
								dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
								dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
								weekHeader: calendarStrings[_calendarLang].weekHeader,
								yearSuffix: calendarStrings[_calendarLang].yearSuffix,
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								onSelect: function( selectedDate ) {
									var option = this.id == "taskdatefrom" ? "minDate" : "maxDate",
									instance = $( this ).data( "datepicker" ),
									date = $.datepicker.parseDate(
									instance.settings.dateFormat ||
									$.datepicker._defaults.dateFormat,
									selectedDate, instance.settings );
									dates.not( this ).datepicker( "option", option, date );
									}
								});
							});
						</script>
					</xsl:if>
								
						
						
					</xsl:if>
			</head>
			<body>
				<xsl:if test="$status != 'new'">
					<xsl:attribute name="onLoad">javascript:onLoadActions()</xsl:attribute>
				</xsl:if>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div class="formtitle">
							<div style="float:left" class="title">
								<xsl:value-of select="document/captions/report/@caption"/>
							</div>
							<div style="float:right; padding-right:5px">
							</div>
						</div>
						<div class="button_panel">
							<span style=" vertical-align:12px; float:left">
								<xsl:call-template name="showxml"/>
								<!-- <xsl:if test="document/fields/allcontrol != '0' and document/@editmode ='edit'"> -->
									<xsl:call-template name="filling_report"/>
							<!-- 	</xsl:if> -->
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
							</ul>
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
									<br/>
									<!-- Автор резолюции -->
								 	<table width="100%" border="0">
										<tr>
											<td class="fc" style = "padding:7px;">
												<font style="vertical-align:top"><xsl:value-of select="document/captions/taskauthor/@caption"/> :</font>
												<a>
													<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','false','taskauthor','frm', 'taskauthortbl');</xsl:attribute>
													<img src="/SharedResources/img/iconset/report_magnify.png"/>
												</a>
											</td>
											<td>
												<table id="taskauthortbl">
													<tr>
														<td style="background:#fff; padding:3px 3px 3px 1px; width:600px; border:1px solid #ccc">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:600px; border:1px solid #ccc</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/taskauthor"/>&#xA0;
														</td>
													</tr>
												</table>
												<input type="hidden" id="taskauthor" name="taskauthor" value="{document/fields/taskauthor/@attrval}"/>
												<input type="hidden" id="taskauthorcaption" value="{document/captions/taskauthor/@caption}"/>
											</td>
										</tr>
										<!-- Дата резолюции -->
										<tr>
											<td class="fc" style = "padding:5px;position:relative;top:0px"><xsl:value-of select="document/captions/taskdate/@caption"/> :</td>
											<td>
												&#xA0;<label for="from"><xsl:value-of select="document/captions/from/@caption"/></label>&#xA0;
												<input type="text" id="taskdatefrom" size="7" name="taskdatefrom" value="{document/fields/taskdatefrom}" style="background:#fff; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc;vertical-align:top;">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="style">background:none;padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc</xsl:attribute>
													</xsl:if>
												</input>
												&#xA0;<label for="to"><xsl:value-of select="document/captions/to/@caption"/></label>&#xA0;
												<input type="text" id="taskdateto" value="{document/fields/taskdateto}" size="7" name="taskdateto" style="background:#fff; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc;vertical-align:top">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc</xsl:attribute>
													</xsl:if>
												</input>
											</td>
										</tr>
										<tr>
											<td class="fc" style = "padding:7px;"><xsl:value-of select="document/captions/controltype/@caption"/> :</td>
											<td>
												<xsl:variable name="controltype" select="document/fields/controltype/@attrval"/>
												<select size="1" name="controltype" style="margin-top:10px;margin-bottom:5px;background:#fff; padding:3px 3px 3px 5px; width:288px; border:1px solid #ccc">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:288px; border:1px solid #ccc</xsl:attribute>
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = '0'">
														<xsl:attribute name="disabled"/>
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
											</td>
										</tr>
										<tr>
											<td class="fc" style = "padding:5px;position:relative;top:0px;"><xsl:value-of select="document/captions/ctrldate/@caption"/> :</td>
											<td>
												&#xA0;<label for="from"><xsl:value-of select="document/captions/from/@caption"/></label>&#xA0;
												<input type="text" id="ctrldatefrom" size="7" name="ctrldatefrom" value="{document/fields/ctrldatefrom}" style="background:#ffffff; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc; vertical-align:top">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc</xsl:attribute>
													</xsl:if>
												</input>
												&#xA0;<label for="to"><xsl:value-of select="document/captions/to/@caption"/></label>&#xA0;
												<input type="text" id="ctrldateto" value="{document/fields/ctrldateto}" size="7" name="ctrldateto" style="background:#fff; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc;  vertical-align:top">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:80px; border:1px solid #ccc</xsl:attribute>
													</xsl:if>
												</input>
											</td>
										</tr>
										 <tr>
											<td class="fc" style = "padding:7px;"><xsl:value-of select="document/captions/reportfiletype/@caption"/> :</td>
											<td>
												<table>
													<tr>
														<td>
															<input type="radio" name="typefilereport" value="1">
																<xsl:attribute name="onclick">javascript: reportsTypeCheck(this)</xsl:attribute>
																<xsl:if test="$editmode !='edit'">
																	<xsl:attribute name="disabled">disabled</xsl:attribute>
																</xsl:if>
																<xsl:if test="document/fields/typefilereport  = '1'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																<xsl:if test="$status  = 'new'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																PDF
															</input>
														</td>
														<td>
															<input type="radio" name="typefilereport" value="2">
																<xsl:attribute name="onclick">javascript: reportsTypeCheck(this)</xsl:attribute>
																<xsl:if test="$editmode !='edit'">
																	<xsl:attribute name="disabled">disabled</xsl:attribute>
																</xsl:if>
																<xsl:if test="document/fields/typefilereport  = '2'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																XLS
															</input>
														</td>
														<td>
															<input type="radio" name="typefilereport" value="3">
																<xsl:attribute name="onclick">javascript: reportsTypeCheck(this)</xsl:attribute>
																<xsl:if test="$editmode !='edit'">
																	<xsl:attribute name="disabled">disabled</xsl:attribute>
																</xsl:if>
																<xsl:if test="document/fields/typefilereport  = '3'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																HTML
															</input>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										  <tr>
											<td class="fc" style = "padding:7px;"><xsl:value-of select="document/captions/openreport/@caption"/> :</td>
											<td>
												<table>
													<tr>
														<td> 
															<input type="radio" name="disposition" value="attachment">
																<xsl:if test="$editmode='noaccess'">
																	<xsl:attribute name="disabled">disabled</xsl:attribute>
																</xsl:if>
																<xsl:if test="document/fields/disposition  = 'attachment'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																<xsl:if test="$status  = 'new'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/bydefaultinprogram/@caption"/>
															</input>
														</td>
														<td>
															<input type="radio" name="disposition" value="inline">
																<xsl:if test="$editmode='noaccess'">
																	<xsl:attribute name="disabled">disabled</xsl:attribute>
																</xsl:if>
																<xsl:if test="document/fields/disposition  = 'inline'">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/inbrowserwindow/@caption"/>
															</input>
														</td>
													</tr>
												</table>
											</td>
										</tr> 
									</table>
								</div>
								<!-- Скрытые поля -->
								<input type="hidden" name="isresol" value="{isresol}"/>
								<input type="hidden" name="type" value="save"/>
								<input type="hidden" name="id" value="kr"/>
								<input type="hidden" name="author" value="{document/fields/author/@attrval}"/>
								<input type="hidden" name="allcontrol" value="{document/fields/allcontrol}"/>
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
								<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
								<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
								<xsl:for-each select="extexecid/item">
									<input type="hidden" name="extexecid" id="extexecid" value="{.}"/>
								</xsl:for-each>
							</form>
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
													<font class="font"  style="font-family:verdana; font-size:13px; margin-left:2px">
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
							<input type="hidden" id="currentuser" value="{@userid}"/>
							<input type="hidden" id="localusername" value="{@username}"/>
						</div>
						<div style="height:10px"/>
					</div>
				</div>
				<xsl:call-template name="formoutline"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>