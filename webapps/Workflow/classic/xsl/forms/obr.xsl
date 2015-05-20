<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/fields/title"/>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Workflow документооборот - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<script type="text/javascript">
					$(document).ready(function(){
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
					<xsl:call-template name="markisread"/>
				</head>
				<body>
					<div id="docwrapper">
						<xsl:call-template name="documentheader"/>	
						<div class="formwrapper">
							<div class="formtitle">
								<div style="float:left" class="title">
				   					<xsl:call-template name="doctitle"/><span id="whichreadblock"><xsl:value-of select="document/captions/read/@caption"/></span>											
				   				</div>
				    			<div style="float:right; padding-right:5px;">
								</div>
							</div>		
							<div class="button_panel">
								<span style="vertical-align:12px; float:left">
									<xsl:call-template name="showxml"/>
									<xsl:call-template name="get_document_accesslist"/>
									<xsl:call-template name="save"/>
									<xsl:call-template name="newkr"/>
									<xsl:call-template name="newki"/>
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
											<a href="#tabs-2"><xsl:value-of select="document/captions/progress/@caption"/></a>
										</li>
										<li class="ui-state-default ui-corner-top">
											<a href="#tabs-3"><xsl:value-of select="document/captions/attachments/@caption"/></a>
											<img id="loading_attach_img" style="vertical-align:-8px; margin-left:-10px; padding-right:3px; visibility:hidden" src="/SharedResources/img/classic/ajax-loader-small.gif"></img>
										</li>
										<li class="ui-state-default ui-corner-top">
											<a href="#tabs-4"><xsl:value-of select="document/captions/additional/@caption"/></a>
										</li>
										<xsl:call-template name="docInfo"/>
									</ul>
									<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
										<div class="ui-tabs-panel" id="tabs-1">
											<br/>
											<table width="100%" border="0">
												<!-- поля "Входящий номер" и "Дата входящего" -->
												<tr>
													<td width="30%" class="fc"><xsl:value-of select="document/captions/vn/@caption"/> № :</td>
			            							<td>
                        								<input type="text" name="vn" value="{document/fields/vn}" class="td_noteditable" style="width:80px;" onfocus="javascript:$(this).blur()" readonly="readonly"/>
	                            						&#xA0;
                            							<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
                            							<input type="text" name="dvn" value="{substring(document/fields/dvn,1,10)}" style="width:80px;" class="td_noteditable" onfocus="javascript:$(this).blur()" readonly="readonly"/>
     				    							</td>   					
												</tr>
												<!-- поле "Ф.И.О." -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/fio/@caption"/> :
													</td>
													<td>
														<input type="text"  name="fio" id="fio" value="{document/fields/fio}" style="width:600px;" class="td_editable"> 
															<xsl:if test="$editmode !='edit'">
	                            								<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            								<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
	                            								<xsl:attribute name="class">td_noteditable</xsl:attribute>
	                            							</xsl:if>   
	                            							<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
															</xsl:if>               			              		
														</input>	
													</td>
												</tr>
												<!-- поле "Адрес" -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/address/@caption"/> :
													</td>
													<td>
														<input value="{document/fields/address}" style="width:600px;" type="text" id="address" name="address" class="td_editable">
															<xsl:if test="$editmode !='edit'">
							                            		<xsl:attribute name="readonly">readonly</xsl:attribute>
							                            		<xsl:attribute name="onfocus">javascript: $(this).blur()</xsl:attribute>
							                            		<xsl:attribute name="class">td_noteditable</xsl:attribute>
							                            	</xsl:if>   
							                            	<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
															</xsl:if>                   			              		
														</input>	
													</td>
												</tr>
												<!-- поле "Кому адресован" -->
												<tr>
													<td class="fc">
														<font style="vertical-align:top">
															<xsl:value-of select="document/captions/recipient/@caption"/> : 
														</font>
														<xsl:if test="$editmode = 'edit'">
															<a href="">
																<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','false','recipient','frm','recipienttbl');</xsl:attribute>								
																<img src="/SharedResources/img/iconset/report_magnify.png"/>		
															</a>
														</xsl:if>
													</td>
													<td>
														<table id="recipienttbl" style="border-spacing:0px 3px;">
															<tr>
																<td style="width:600px;" class="td_editable">
																	<xsl:if test="$editmode !='edit'">
							                            				<xsl:attribute name="class">td_noteditable</xsl:attribute>
							                            			</xsl:if>   
																	<xsl:value-of select="document/fields/recipient"/>&#xA0;
																</td>
															</tr>
														</table>
														<input type="hidden" id="corr" name="recipient" value="{document/fields/recipient/@attrval}"/>
														<input type="hidden" id="recipientcaption" value="{document/fields/recipient/@caption}"/>
													</td>
												</tr>
												<!-- поле "Тип документа" -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/vid/@caption"/> :
													</td>
													<td>
														<xsl:variable name="vid" select="document/fields/vid/@attrval"/>
														<select name="vid" class="select_editable" style="width:611px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"/>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
																<option value="">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																	<xsl:value-of select="document/fields/vid"/>
																</option>
															</xsl:if>
															<xsl:for-each select="document/glossaries/typedoc/query/entry">
																<option value="{@docid}">
																	<xsl:if test="$vid = @docid">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>
																	<xsl:value-of select="viewcontent/viewtext1"/>
																</option>
															</xsl:for-each>
														</select>	
													</td>
												</tr>
												<!-- поле "Район/регион" -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/regionview/@caption"/> :
													</td>
													<td>
														<xsl:variable name="regionview" select="document/fields/regionview/@attrval"/>
														<select name="regionview" class="select_editable" style="width:611px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"/>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
																<option value="">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																	<xsl:value-of select="document/fields/regionview"/>
																</option>
															</xsl:if>
															<xsl:for-each select="document/glossaries/city/query/entry">
																<option value="{@docid}">
																	<xsl:if test="$regionview = @docid">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>
																	<xsl:value-of select="viewcontent/viewtext1"/>
																</option>
															</xsl:for-each>
														</select>		
													</td>
												</tr>
												<!-- поле "Язык обращения" -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/lang/@caption"/> :
													</td>
													<td>
														<select name="lang" class="select_editable" style="width:611px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"/>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
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
												<!-- поле "Характер вопроса" -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/har/@caption"/> :
													</td>
													<td>
														<xsl:variable name="har" select="document/fields/har/@attrval"/>
														<select name="har" class="select_editable" style="width:611px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"></xsl:attribute>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
																<option value="">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																	<xsl:value-of select="document/fields/har"/>
																</option>
															</xsl:if>
															<xsl:for-each select="document/glossaries/har/query/entry">
																<option value="{@docid}">
																	<xsl:if test="$har = @docid">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>
																	<xsl:value-of select="viewcontent/viewtext1"/>
																</option>
															</xsl:for-each>
														</select>		
													</td>
												</tr>		
												<!-- поле "Результат рассмотрения" -->
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/resultview/@caption"/> :</td>
													<td>
														<select name="resultview" class="select_editable" style="width:611px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"/>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
															</xsl:if>
															<option value="0">
																<xsl:if test="document/fields/resultview = '0'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
															</option>
															<option value="1">
																<xsl:if test="document/fields/resultview = '1'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/clarified/@caption"/>
															</option>
															<option value="2">
																<xsl:if test="document/fields/resultview = '2'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/satisfied/@caption"/>
															</option>
															<option value="3">
																<xsl:if test="document/fields/resultview = '3'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/rejected/@caption"/>
															</option>
														</select>
													</td>
												</tr>
												<!-- поле "Срок исполнения" -->
												<tr>
													<td class="fc" style ="position:relative;top:0px">
														<xsl:value-of select="document/captions/ctrldate/@caption"/> :
													</td>
													<td>
													<xsl:if test="document/@editmode = 'edit'">
															<script type="text/javascript">
																$(function() {
																	$('#ctrldate').datepicker({
																		showOn: 'button',
																		buttonImage: '/SharedResources/img/iconset/calendar.png',
																		buttonImageOnly: true,
																		regional:['ru'],
																		showAnim: '',
																		<xsl:if test="/request/@lang = 'KAZ'">
																			monthNames: ['Қаңтар','Ақпан','Наурыз','Сәуір','Мамыр','Маусым',
																			'Шілде','Тамыз','Қыркүйек','Қазан','Қараша','Желтоқсан'],
																			monthNamesShort: ['Қаңтар','Ақпан','Наурыз','Сәуір','Мамыр','Маусым',
																			'Шілде','Тамыз','Қыркүйек','Қазан','Қараша','Желтоқсан'],
																			dayNames: ['жексебі','дүйсенбі','сейсенбі','сәрсенбі','бейсенбі','жұма','сенбі'],
																			dayNamesShort: ['жек','дүй','сей','сәр','бей','жұм','сен'],
																			dayNamesMin: ['Жс','Дс','Сс','Ср','Бс','Жм','Сн']
																		</xsl:if>
																		<xsl:if test="/request/@lang = 'ENG'">
																				monthNames: ['January','February','March','April','May','June',
																				'July','August','September','October','November','December'],
																				monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
																				'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
																				dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
																				dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
																				dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
																				weekHeader: 'Wk',
																				firstDay: 1,
																				isRTL: false,
																		</xsl:if>
																		<xsl:if test="/request/@lang = 'CHN'">
																				closeText: '关闭',
																				prevText: '&#x3c;上月',
																				nextText: '下月&#x3e;',
																				currentText: '今天',
																				monthNames: ['一月','二月','三月','四月','五月','六月',
																				'七月','八月','九月','十月','十一月','十二月'],
																				monthNamesShort: ['一','二','三','四','五','六',
																				'七','八','九','十','十一','十二'],
																				dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
																				dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
																				dayNamesMin: ['日','一','二','三','四','五','六'],
																				weekHeader: '周',
																				firstDay: 1,
																				isRTL: false,
																				showMonthAfterYear: true,
																				yearSuffix: '年',
																		</xsl:if>
																	});
																});
																</script>
														</xsl:if>
														
														<input type="text" name="ctrldate" value="{substring(document/fields/ctrldate,1,10)}" maxlength="10" class="td_editable" style="width:80px; vertical-align:top">
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="id">ctrldate</xsl:attribute>
															</xsl:if>
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="onfocus">javascript: $(this).blur()</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>		
												<!-- поле "Краткое содержание" -->
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/briefcontent/@caption"/> :</td>
													<td>
														<textarea name="briefcontent" rows="3" style="width:760px;" class="textarea_editable">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
																<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
															</xsl:if>	
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">javascript:fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">javascript:fieldOnBlur(this)</xsl:attribute>
															</xsl:if>	
															<xsl:value-of select="document/fields/briefcontent"/>
														</textarea>							
													</td>
												</tr>
												<!--  поле "Примечание"   -->
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/remark/@caption"/> :</td>
													<td>
														<textarea name="remark" rows="5" style="width:760px;" class="textarea_editable">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
																<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
															</xsl:if>	
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">javascript:fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">javascript:fieldOnBlur(this)</xsl:attribute>
															</xsl:if>	
															<xsl:value-of select="document/fields/remark"/>
														</textarea>							
													</td>
												</tr>
												<!--  поле "Телефон"   -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/phone/@caption"/> :
													</td>
													<td>
														<input size="48" type="text" value="{document/fields/phone}" style="width:185px" name="phone" id="phone" class="td_editable">    
															<xsl:if test="$editmode !='edit'">
							                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
							                           			<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
							                           			<xsl:attribute name="class">td_noteditable</xsl:attribute>
							                           		</xsl:if>
							                           		<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
															</xsl:if>                   			              		
														</input>	
													</td>
												</tr>
												<!--  поля "Вид обращения"   -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/otype/@caption"/> :
													</td>
													<td>
														<select name="private" style="width:185px;" class="select_editable">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"/>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
															</xsl:if>
															<option value="1">
																<xsl:if test="document/fields/private = '1'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/individual/@caption"/>
															</option>
															<option value="2">
																<xsl:if test="document/fields/private = '2'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/collective/@caption"/>
															</option>
														</select>
														<select name="otype" style="width:135px;" class="select_editable">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled"/>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
															</xsl:if>
															<option value="1">
																<xsl:if test="document/fields/otype = '1'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/written/@caption"/>
															</option>
															<option value="2">
																<xsl:if test="document/fields/otype = '2'">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/orally/@caption"/>
															</option>
														</select>
													</td>
												</tr>
												<!-- Поля "количество листов" и "количество экземпляров" -->
												<tr>
													<td class="fc">
														<xsl:value-of select="document/captions/np/@caption"/> <xsl:value-of select="document/fields/np2/@caption"/> :
													</td>
													<td>
														<input type="text" name="np" id="np" value="{document/fields/np}" style="width:67px;" onkeypress="javascript:Numeric(this)" class="td_editable">
															<xsl:if test="$editmode !='edit'">
							                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
							                           			<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
							                           			<xsl:attribute name="class">td_noteditable</xsl:attribute>
							                           		</xsl:if>                    			              		
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
															</xsl:if>
														</input>	
														/
														<input style="width:67px;" type="text" value="{document/fields/np2}" name="np2" id="np2" onkeypress="javascript:Numeric(this)" class="td_editable">
															<xsl:if test="$editmode !='edit'">
							                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
							                           			<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
							                           			<xsl:attribute name="class">td_noteditable</xsl:attribute>
							                           		</xsl:if>                    			              		
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
															</xsl:if>
														</input>	
													</td>
												</tr>
											</table>		
										</div>
										<div id="tabs-2" style="height:500px">
											<xsl:if test="document/@status !='new'">
												<div display="block" style="display:block;  width:90%" id="execution">
													<br/>
													<font style="font-style:arial; font-size:13px">
														<b><xsl:value-of select="document/@viewtext"/></b>
													</font>
													<table id="executionTbl" style="width:90%">
													</table>
													<script>
														$.ajax({
															url: 'Provider?type=view&amp;id=docthread&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>',
															datatype:'html',
															async:'true',
															success: function(data) {
																$("#executionTbl").append(data)
																$("#executionTbl a").css("font-size","12px")
																$("#executionTbl tr").css("width","600px")
															}
														});
													</script>
													<br/>
												</div>
											</xsl:if>
										</div>
										<input type="hidden" name="type" value="save"/>
										<input type="hidden" name="id" value="L"/>
										<input type="hidden" name="doctype" value="{document/@doctype}"/>
										<input type="hidden" name="author" value="{document/fields/author/@attrval}"/>
										<xsl:if test="document/@status !='new'">
											<input type="hidden" name="key" value="{document/@docid}"/>
											<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
											<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
										</xsl:if>
										<input type="hidden" name="page" value="{document/@openfrompage}"/>
										<xsl:call-template name="ECPsignFields"/>       
								    </form>
									<div id="tabs-3" style="height:500px">
									 	<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
											<input type="hidden" name="type" value="rtfcontent"/>
											<input type="hidden" name="formsesid" value="{formsesid}"/>
											<div display="block" id="att">
												<br/>	
												<xsl:call-template name="attach"/>
											</div>
										</form>
									</div>
									<div id="tabs-4">
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