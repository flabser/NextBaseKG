<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/fields/title"/>
	<xsl:variable name="path" select="/request/@skin" />
	<xsl:variable name="threaddocid" select="document/@docid"/>
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
				<xsl:call-template name="markisread"/>
				<xsl:if test="$editmode = 'edit'">
					<xsl:call-template name="htmlareaeditor"/>
				</xsl:if>
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
									     	$("#btnnewish").click();
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
				<xsl:if test="document/@editmode = 'edit'">
					<script>
						var _calendarLang = "<xsl:value-of select="/request/@lang" />";
						$(function() {
							$('#ctrldate, #din').datepicker({
								showOn: 'button',
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								regional:['ru'],
								showAnim: '',
								monthNames: calendarStrings[_calendarLang].monthNames,
								monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
								dayNames: calendarStrings[_calendarLang].dayNames,
								dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
								dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
								weekHeader: calendarStrings[_calendarLang].weekHeader,
								yearSuffix: calendarStrings[_calendarLang].yearSuffix,
							});
						});
					</script>
				</xsl:if>
		</head>
		<body>
			<div id="docwrapper">
				<xsl:call-template name="documentheader"/>	
				<div class="formwrapper">
					<div class="formtitle">
						<div style="float:left" class="title">
							<xsl:call-template name="doctitle"/><span id="whichreadblock">Прочтен</span>
						</div>
						<div style="float:right; padding-left:5px">
						</div>
					</div>
					<div class="button_panel">
						<span style="width:80%; vertical-align:12px; float:left">
							<xsl:call-template name="showxml"/>
							<xsl:call-template name="get_document_accesslist"/>
							<xsl:call-template name="save"/>
							<xsl:call-template name="newkr"/>
							<xsl:call-template name="newki"/>
							<xsl:call-template name="acquaint"/>
							<!-- <xsl:call-template name="newdiscussion"/> -->
							<xsl:if test="document/@status !='new'">
								<button title ="{document/captions/projectout/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnnewish" style="margin-left:5px">
									<xsl:attribute name="onclick">javascript:infoDialog('<xsl:value-of select="document/captions/outgoingprjexist/@caption"/>')</xsl:attribute>
									<xsl:if test="document/fields/outgoingprjlink/entry = '' or not(document/fields/outgoingprjlink/entry)">
										<xsl:attribute name="onclick">javascript:window.location.href="Provider?type=edit&amp;element=document&amp;id=outgoingprj&amp;docid=&amp;indocid=<xsl:value-of select="document/@id"/>"</xsl:attribute>
									</xsl:if>
									<span>
										<img src="/SharedResources/img/classic/icons/page_white.png" class="button_img"/>
										<font class="button_text"><xsl:value-of select="document/captions/projectout/@caption"/></font>
									</span>
								</button>
							</xsl:if>
							<xsl:call-template name="ECPsign"/>
						</span>
						<span style="float:right">
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
								<a href="#tabs-3"><xsl:value-of select="document/captions/progress/@caption"/></a>
							</li>
							<li class="ui-state-default ui-corner-top">
								<a href="#tabs-4"><xsl:value-of select="document/captions/attachments/@caption"/></a>
								<img id="loading_attach_img" style="vertical-align:-8px; margin-left:-10px; padding-right:3px; visibility:hidden" src="/SharedResources/img/classic/ajax-loader-small.gif"></img>
							</li>
							<li class="ui-state-default ui-corner-top">
								<a href="#tabs-5"><xsl:value-of select="document/captions/additional/@caption"/></a>
							</li>
							<xsl:call-template name="docInfo"/>
						</ul>
						
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
									<br/>
									<table width="100%" border="0">
										<!-- Поле "Ответный проект исходящего" -->
										<xsl:if test="document/fields/outgoingprjlink/entry != '' and document/fields/outgoingprjlink/entry">
											<tr>
												<td class="fc">
													<xsl:value-of select="document/captions/outgoingprjlink/@caption"/> :
												</td>
								            	<td>
						                      		<a class="doclink" href="{document/fields/outgoingprjlink/entry/@url}">
														<xsl:value-of select="document/fields/outgoingprjlink/entry"/>
													</a>
						                       	</td>   					
											</tr>
										</xsl:if>
										<!-- поля "Входящий номер" и "дата входящего" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/vn/@caption"/>&#xA0;№ :
											</td>
											<td>
												<input type="text" value="{document/fields/vn}" readonly="readonly" style="width:80px;" class="td_noteditable"/>
													&#xA0;<xsl:value-of select="document/captions/dvn/@caption" />&#xA0;
												<input type="text" value="{substring(document/fields/dvn,1,10)}" name="dvn" readonly="readonly" onfocus="javascript:$(this).blur()" style="width:80px;" class="td_noteditable"/>
											</td>
										</tr>
										<!-- поля "Исходящий номер" и "Дата исходящего" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/in/@caption"/>&#160;№ :
											</td>
											<td style="padding-top:5px">
												<input type="text" value="{document/fields/in}" name="in" class="td_editable" style="width:80px; vertical-align:top">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
														<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
													</xsl:if>
													<xsl:if test="$editmode = 'edit'">
														<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
														<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
													</xsl:if>
												</input>&#xA0;
												<xsl:value-of select="document/captions/din/@caption" />&#xA0;
												<input type="text" value="{substring(document/fields/din,1,10)}" id="din" name="din" readonly="readonly" onfocus="javascript:$(this).blur()" style="width:80px; vertical-align:top" class="td_editable">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
													</xsl:if>
												</input>
											</td>
										</tr>
										<!-- поле "Откуда поступил" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/corr/@caption"/> :
												</font>
												<xsl:if test="$editmode = 'edit'">
													<img src="/SharedResources/img/iconset/report_magnify.png" style="cursor:pointer">
														<xsl:attribute name="onclick">javascript:dialogBoxStructure('corrcat','false','corr','frm', 'corresptbl');</xsl:attribute>
													</img>
												</xsl:if>
											</td>
											<td style="padding-top:5px">
												<table id="corresptbl" style="border-spacing:0px 3px; margin-top:-3px">
													<tr>
														<td style="width:600px;" class="td_editable">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/corr"/>&#xA0;
															<span style='float:right; border-left:1px solid #ccc; width:17px; padding-right:10px; padding-left:2px; padding-top:1px; color:#ccc; font-size:10.5px'><font><xsl:value-of select="document/fields/corr/@attrval"/></font></span>
														</td>
													</tr>
												</table>
												<input type="hidden" value="{document/fields/corr/@attrval}" id="corr" name="corr"/>
												<input type="hidden" value="{document/captions/corr/@caption}" id="corrcaption"/>
											</td>
										</tr>
										<!-- поле "Кому адресован" -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/recipient/@caption"/> :
												</font>
												<xsl:if test="$editmode = 'edit'">
													<img src="/SharedResources/img/iconset/report_magnify.png" style="cusor:pointer">
														<xsl:attribute name="onclick">javascript:dialogBoxStructure('bossandemppicklist','true','recipient','frm', 'recipienttbl');</xsl:attribute>
													</img>
												</xsl:if>
											</td>
											<td>
												<table id="recipienttbl" style="border-spacing:0px 3px; margin-top:-3px">
													<xsl:if test="not(document/fields/recipient/entry)">
														<tr>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/recipient"/>&#xA0;
															</td>
														</tr>
													</xsl:if>
													<xsl:for-each select="document/fields/recipient/entry">
														<tr>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>&#xA0;
															</td>
														</tr>
													</xsl:for-each>
												</table>
												<xsl:for-each select="document/fields/recipient/entry">
													<input type="hidden" value="{./@attrval}" name="recipient"/>
												</xsl:for-each>
												<xsl:if test="not(document/fields/recipient/entry)">
													<input type="hidden" id="recipient" name="recipient" value="{document/fields/recipient/@attrval}"/>
												</xsl:if>
												<input type="hidden" id="recipientcaption" value="{document/captions/recipient/@caption}"/>
											</td>
										</tr>
										<!-- поле "Тип документа" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/vid/@caption"/> :
											</td>
											<td>
												<select size="1" name="vid" style="width:611px;" class="select_editable">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<xsl:attribute name="disabled"/>
														<option value="">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/vid"/>
														</option>
													</xsl:if>
													<xsl:variable name="vid" select="document/fields/vid/@attrval"/>
													<xsl:for-each select="document/glossaries/vid/query/entry">
														<option value="{@docid}">
															<xsl:if test="$vid=@docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr>
										<!-- Поле "Вид доставки" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/deliverytype/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<xsl:variable name="deliverytype" select="document/fields/deliverytype/@attrval" />
												<select size="1" name="deliverytype" style="width:611px;" class="select_editable">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<xsl:attribute name="disabled">disabled</xsl:attribute>
														<option value="">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/deliverytype"/>
														</option>
													</xsl:if>
													<xsl:for-each select="document/glossaries/deliverytype/query/entry">
														<option value="{@docid}">
															<xsl:if test="$deliverytype = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>
												<xsl:if test="$editmode !='edit'">
													<input type="hidden" name="deliverytype" value="{document/fields/deliverytype/@attrval}"/>
												</xsl:if>
											</td>
										</tr>
										<!-- поле "Проект" -->
										<xsl:if test="not(document/fields/project/@mode = 'hide')">
											<tr>
												<td class="fc" style="padding-top:5px"><xsl:value-of select="document/captions/conectedproject/@caption"/> :</td>
												<td style="padding-top:5px">
													<xsl:variable name="project" select="document/fields/project/@attrval" />
													<select size="1" name="project" style="width:611px;" class="select_editable">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<xsl:attribute name="disabled"/>
															<option value="">
																<xsl:attribute name="selected">selected</xsl:attribute>
																<xsl:value-of select="document/fields/project"/>
															</option>
														</xsl:if>
														<xsl:if test="$editmode = 'edit'">
															<option value=" ">
																<xsl:attribute name="selected">selected</xsl:attribute>
																&#xA0;
															</option>
														</xsl:if>
														<xsl:for-each select="document/glossaries/projectsprav/query/entry">
															<option value="{@docid}">
																<xsl:if test="$project = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
												</td>
											</tr>
										</xsl:if>
										<!-- поле "Категория" -->
										<xsl:if test="not(document/fields/category/@mode = 'hide')">
											<tr>
												<td class="fc" style="padding-top:5px"><xsl:value-of select="document/captions/category/@caption"/> :</td>
												<td style="padding-top:5px">
													<xsl:variable name="category" select="document/fields/category/@attrval" />
													<select size="1" name="category" style="width:611px;" class="select_editable">
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
														<xsl:for-each select="document/glossaries/docscat/query/entry">
															<option value="{@docid}">
																<xsl:if test="$category = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
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
												<select name="har" style="width:611px;" class="select_editable">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<xsl:attribute name="disabled"/>
													</xsl:if>
													<xsl:for-each select="document/glossaries/har/query/entry">
														<option value="{@docid}">
															<xsl:if test="$har = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="@viewtext"/>
														</option>
													</xsl:for-each>
												</select>
											</td>
										</tr> -->
										<!-- поле "Язык обращения" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/lang/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<select size="1" name="lang" style="width:611px;" class="select_editable" autocomplete="off">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
														<xsl:attribute name="disabled"/>
													</xsl:if>
													<option value="1">
														<xsl:if test="document/fields/lang = '1'">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
														Русский
													</option>
													<option value="2">
														<xsl:if test="document/fields/lang = '2'">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
														Английский
													</option>
													<option value="3">
														<xsl:if test="document/fields/lang = '3'">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
														Казахский
													</option>
													<option value="4">
														<xsl:if test="document/fields/lang = '4'">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
														Другой
													</option>
												</select>
											</td>
										</tr>
										<!-- поле "Краткое содержание" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/briefcontent/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<textarea name="briefcontent" rows="3" class="textarea_editable" style="width:750px">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
													</xsl:if>
													<xsl:if test="$editmode = 'edit'">
														<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
														<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/fields/briefcontent"/>
												</textarea>
											</td>
										</tr>
										
										<!-- поле "Количество листов" -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/np/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<input type="text" value="{document/fields/np}" name="np" class="td_editable" onkeypress="javascript:Numeric(this)" style="width:80px;">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
													</xsl:if>
													<xsl:if test="$editmode = 'edit'">
														<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
														<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
													</xsl:if>
												</input>
											</td>
										</tr>
										<!-- поле "Срок исполнения" -->
									<tr>
										<td class="fc" style="padding-top:5px;position:relative;top:0px;">
											<xsl:value-of select="document/captions/ctrldate/@caption"/> :
										</td>
										<td style="padding-top:5px">
											<input type="text" name="ctrldate" maxlength="10" class="td_editable" style="width:80px; vertical-align:top" readonly="readonly" onfocus="javascript:$(this).blur()" value="{substring(document/fields/ctrldate,1,10)}">
												<xsl:if test="$editmode = 'edit'">
													<xsl:attribute name="id">ctrldate</xsl:attribute>
												</xsl:if>
												<xsl:if test="$editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
											</td>
										</tr>
									</table>
								</div>
								<div id="tabs-2" style="height:500px">
									<br/>
									<table width="100%" border="0">
										<!-- поле "Содержание" -->
										<tr>
											<td style="padding-left:30px">
												<xsl:if test="$editmode = 'edit'">
													<script type="text/javascript">  
														$(document).ready(function($) {
												    		 CKEDITOR.config.width = "815px"
												    		 CKEDITOR.config.height = "450px"
												    	});
													</script>
													<textarea id="MyTextarea" name="remark">
														<xsl:if test="@useragent = 'ANDROID'">
															<xsl:attribute name="style">width:500px; height:300px</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/remark"/>
													</textarea>
												</xsl:if>
												<xsl:if test="$editmode != 'edit'">
													<div id="briefcontent">
														<xsl:attribute name="style">width:815px; height:450px; background:#EEEEEE; padding: 3px 5px; overflow-x:auto</xsl:attribute>
														<script>
															$("#briefcontent").html("<xsl:value-of select='document/fields/remark'/>")
														</script>
													</div>
													<input type="hidden" name="remark" value="{document/fields/remark}"/>
												</xsl:if>
											</td>
										</tr>
									</table>
								</div>
								<div id="tabs-3" style="height:500px">
									<xsl:if test="document/@status !='new'">
										<div display="block" style="display:block; width:95%" id="execution">
											<table style="width:100%">
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/progress/@caption"/> :</td>
													<td>
														<font style="font-style:arial; font-size:13px">
															<b><xsl:value-of select="document/fields/title"/> № <xsl:value-of select="document/fields/dvn"/> - <xsl:value-of select="document/fields/briefcontent"/></b>
														</font>
														<table id="executionTbl" style="width:90%"/>
														<script>
															$.ajax({
																url: 'Provider?type=view&amp;id=docthread&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>',
																datatype:'html',
																async:'true',
																success: function(data) {
																	$("#executionTbl").append(data)
																	$("#executionTbl a").css("font-size","12px")
																	$("#executionTbl tr").css("width","700px")
																}
															});
														</script>
													</td>
												</tr>
											</table>
											
											<br/>
										</div>
									</xsl:if>
								</div>
								<!-- Скрытые поля документа -->
								<input type="hidden" name="type" value="save"/>
								<input type="hidden" name="id" value="in"/>
								<input type="hidden" name="author" value="{document/fields/author/@attrval}"/>
								<input type="hidden" name="allcontrol" value="{document/fields/allcontrol}"/>
								<input type="hidden" name="doctype" value="{document/@doctype}"/>
								<input type="hidden" name="key" value="{document/@docid}"/>
								<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
								<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
<!-- 								<xsl:call-template name="ECPsignFields"/> -->
								
							</form>
							<div id="tabs-4" style="height:500px">
								<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
									<input type="hidden" name="type" value="rtfcontent"/>
									<input type="hidden" name="formsesid" value="{formsesid}"/>
									<!-- Секция "Вложения" -->
									<div display="block" id="att">
										<br/>
										<xsl:call-template name="attach"/>
									</div>
								</form>
							</div>
							<div id="tabs-5">
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
</xsl:stylesheet>