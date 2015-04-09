<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype"><xsl:value-of select="/request/document/captions/employer/@caption"/></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="status" select="request/document/@status"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('4ms Structure - ',document/captions/employer/@caption)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="keypressactions"/>
				<script type="text/javascript">
					function checkAll(el,classname) {
						if(!(el.checked)) {
							$("input[class="+classname+"]").each(function(){$(this).attr("disabled","disabled");})
							$("tr[class="+classname+"]").each(function(){$(this).attr("style","background:#ededed");})
						}else{
							$("input[class="+classname+"]").each(function(){$(this).removeAttr("disabled");})
							$("tr[class="+classname+"]").each(function(){$(this).removeAttr("style");})
						}
					}
					var _calendarLang = "<xsl:value-of select="/request/@lang" />";
					$(function() {
						$('#birthdate').datepicker({
							showOn: 'button',
							buttonImage: '/SharedResources/img/iconset/calendar.png',
							buttonImageOnly: true,
							regional:['ru'],
							showAnim: '',
							changeYear : true,
							changeMonth : true,
							monthNames: calendarStrings[_calendarLang].monthNames,
							monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
							dayNames: calendarStrings[_calendarLang].dayNames,
							dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
							dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
							weekHeader: calendarStrings[_calendarLang].weekHeader,
							yearSuffix: calendarStrings[_calendarLang].yearSuffix,
							maxDate : 0,
							yearRange: '-100y:+0y',
						}).keyup(function(e) {
						    if(e.keyCode == 8 || e.keyCode == 46) {
						        $.datepicker._clearDate(this);
						    }
						});
					});
				</script>
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
									   case 68:
									   		<!-- клавиша d -->
									     	e.preventDefault();
									     	$("#btnnewdep").click();
									      	break;
									   case 69:
									   		<!-- клавиша e -->
									     	e.preventDefault();
									     	$("#btnnewemp").click();
									      	break;
									   case 83:
									   		<!-- клавиша s -->
									     	e.preventDefault();
									     	$("#btnsavedoc").click();
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
									   default:
							      	break;
								}
							}
						});
						$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
						$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
						$("#btnnewdep").hotnav({keysource:function(e){ return "d"; }});
						$("#btnnewemp").hotnav({keysource:function(e){ return "e"; }});
						$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
						$("#logout").hotnav({keysource:function(e){ return "q"; }});
						$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
					}
					]]>
				</script>
			</head>
			<body>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div class="formtitle">
							<div class="title">
								<xsl:call-template name="doctitleBoss"/>
							</div>
						</div>
						<div class="button_panel">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<xsl:if test="document/actionbar/action[@id = 'save_and_close']/@mode='ON'">
								<button title= "{document/captions/saveclose/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnsavedoc">
									<xsl:attribute name="onclick">javascript:SaveFormJquery(&quot;<xsl:value-of select="history/entry[@type eq 'page'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>&quot;)</xsl:attribute>
									<span>
										<img src="/SharedResources/img/classic/icons/disk.png" class="button_img"/>
										<font class="button_text"><xsl:value-of select="document/captions/saveclose/@caption"/></font>
									</span>
								</button>
								</xsl:if>
								<xsl:if test="$status !='new'">
									<xsl:if test="document/actionbar/action[@id = 'NEW_DEPARTMENT']/@mode='ON'">
										<button title= "{document/captions/newdept/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnnewdep" style="margin-left:5px">
											<xsl:attribute name="onclick">javascript:window.location.href="Provider?type=structure&amp;id=department&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
											<span>
												<img src="/SharedResources/img/classic/icons/package_add.png" class="button_img"/>
												<font class="button_text"><xsl:value-of select="document/captions/newdept/@caption"/></font>
											</span>
										</button>
									</xsl:if>
									<xsl:if test="document/actionbar/action[@id = 'NEW_EMPLOYER']/@mode='ON'">
										<button title= "{document/captions/newemp/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnnewemp" style="margin-left:5px">
											<xsl:attribute name="onclick">javascript:window.location.href="Provider?type=structure&amp;id=employer&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
											<span>
												<img src="/SharedResources/img/classic/icons/user_add.png" class="button_img"/>
												<font class="button_text"><xsl:value-of select="document/captions/newemp/@caption"/></font>
											</span>
										</button>
									</xsl:if>
								</xsl:if>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancelwithjson"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1">
										<xsl:value-of select="document/captions/properties/@caption"/>
									</a>
								</li>
								<xsl:if test="$editmode = 'edit'">
									<li class="ui-state-default ui-corner-top">
		                  				<a href="#tabs-2"><xsl:value-of select="document/captions/applications/@caption"/></a>
		                  			</li>
									<li class="ui-state-default ui-corner-top">
		                  				<a href="#tabs-3"><xsl:value-of select="document/captions/electronicsignature/@caption"/></a>
		                  			</li>
		                  		</xsl:if>
							</ul>
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
									<div display="block" id="property">
										<br/>
										<table width="100%" border="0">
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/fullname/@caption"/> :</td>
												<td>
													<input type="text" name="fullname" value="{document/fields/fullname}" size="45" class="td_editable" style="width:600px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/shortname/@caption"/> :</td>
												<td>
													<input type="text" name="shortname" value="{document/fields/shortname}" style="width:400px" class="td_editable">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">UserID :</td>
												<td>
													<input type="text" name="userid" value="{document/fields/userid}" class="td_editable" style="width:400px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">e-mail :</td>
												<td>
													<input type="text" name="email" value="{document/fields/email}" class="td_editable" style="width:400px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Instant Messenger address :</td>
												<td>
													<input style="width:300px" name="instmsgaddress" type="text" class="td_editable" value="{document/fields/instmsgaddress}">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
													<span style="vertical-align:middle;">
														<xsl:choose>
															<xsl:when test="document/fields/instmsgstatus = 'true'">
																<img src="/SharedResources/img/iconset/bullet_gren.png" title="Instant Messenger on"/>
															</xsl:when>
															<xsl:otherwise>
																<img src="/SharedResources/img/iconset/bullet_red.png" title="Instant Messenger off"/>
															</xsl:otherwise>
														</xsl:choose>
													</span>
												</td>
											</tr>
											<xsl:if test="$editmode = 'edit'">		
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/password/@caption"/> :</td>
													<td>
														<input type="password" value="" name="password" style="width:300px" class="td_editable" autocomplete="off">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/reenterpassword/@caption"/> :</td>
													<td>
														<input type="password" value="" name="repassword" style="width:300px" class="td_editable" autocomplete="off">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
											</xsl:if>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/organization/@caption"/> :
												</td>
												<td>
													<table id="orgtable">
														<tr>
															<td class="td_editable" style="width:300px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="readonly">readonly</xsl:attribute>
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/organization"/>&#xA0;
															</td>
														</tr>
													</table>
													<input type="hidden" name="organization" value="{document/fields/organization/@attrval}" size="30"/>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/department/@caption"/> :
													<xsl:if test="$editmode = 'edit'">
														<a href="">
															<xsl:attribute name="href">javascript:dialogBoxStructure('deptpicklist','false','depid','frm', 'depttable');</xsl:attribute>
															<img src="/SharedResources/img/iconset/report_magnify.png"/>
														</a>
													</xsl:if>
												</td>

												<td>
													<table id="depttable">
														<tr>
															<td class="td_editable" style="width:300px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="readonly">readonly</xsl:attribute>
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/depid"/>&#xA0;
															</td>
														</tr>
													</table>
													<input type="hidden" name="depid" size="30" value="{document/fields/depid/@attrval}"/>
													<input type="hidden" id="depidcaption" size="30" value="Департамент"/>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/post/@caption"/> :</td>
												<td>
													<select name="post" class="select_editable" style="width:312px;">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="disabled">disabled</xsl:attribute>
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<option value=" ">
																<xsl:value-of select="document/fields/post"/>
															</option>
														</xsl:if>
														<xsl:variable name="post" select="document/fields/post/@attrval"/>
														<xsl:if test="$editmode = 'edit'">
															<option value="">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</option>
														</xsl:if>
														<xsl:for-each select="document/glossaries/post/query/entry">
															<option value="{@docid}">
																<xsl:if test="/request/document/fields/post/@attrval = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
													
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/rank/@caption"/> :</td>
												<td>
													<input type="text" name="rank" value="{document/fields/rank}" size="20" class="td_editable" style="width:301px;">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<xsl:if test="$editmode = 'edit'">
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/phone/@caption"/> :</td>
													<td>
														<input type="text" name="phone" value="{document/fields/phone}" size="20" class="td_editable" style="width:301px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
												<tr>
													<td class="fc" style="padding-top:5px;position:relative;top:0px;">
														<xsl:value-of select="document/captions/birthdate/@caption"/> :
													</td>
													<td style="padding-top:5px;">
														<input type="text" name="birthdate" maxlength="10" value="{substring(document/fields/birthdate,1,10)}" readonly="readonly" class="td_editable"  style="width:80px;">
															<xsl:if test="$editmode = 'edit'">
																<xsl:attribute name="id">birthdate</xsl:attribute>
															</xsl:if>
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/mailing/@caption"/> :</td>
													<td>
														<select name="sendto" class="select_editable" style="width:311px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
															</xsl:if>
															<option value="1">
																<xsl:if test="document/fields/sendto =1">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/touserandreplacer/@caption"/>
															</option>
															<option value="2">
																<xsl:if test="document/fields/sendto =2">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/onlytouser/@caption"/>
															</option>
															<option value="3">
																<xsl:if test="document/fields/sendto =3">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/onlytoreplacer/@caption"/>
															</option>
															<option value="4">
																<xsl:if test="document/fields/sendto =4">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/captions/shutoff/@caption"/>
															</option>
														</select>
													</td>
												</tr>
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/fired/@caption"/> :</td>
													<td>
														<input type="checkbox" name="fired" value="1">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/fired = '1'">
																<xsl:attribute name="checked">true</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/comment/@caption"/> :</td>
													<td>
														<textarea class="textarea_editable" rows="4" value="{document/fields/comment}" name="comment" cols="45" style="width:301px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/comment"/>
														</textarea>
													</td>
												</tr>
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/groups/@caption"/> :</td>
													<td>
														<xsl:for-each select="document/fields/group/entry">
															<font><xsl:value-of select="."/></font><br/>
														</xsl:for-each>
														<!--<xsl:for-each select="document/fields/group/entry">
															<input type="hidden" name="group" value="{.}"/>
														</xsl:for-each>
														 <xsl:if test = "not(document/fields/group/@islist)">
															<input type="hidden" name="group" value="{document/fields/group/@attrval}"/>
														</xsl:if> -->
													</td>
												</tr>
											</xsl:if>
										</table>
									</div>
									<input type="hidden" name="type" value="save"/>
									<input type="hidden" name="id" value="employer"/>
									<input type="hidden" name="key" value="{document/@docid}"/>
									<input type="hidden" name="doctype" value="{document/@doctype}"/>
									<input type="hidden" name="parentdoctype" id="parentdoctype" value="{document/@parentdoctype}"/>
									<input type="hidden" name="parentdocid" id="parentdocid" value="{document/@parentdocid}"/>
							</div>
							<xsl:if test="$editmode = 'edit'">
								<div class="ui-tabs-panel" id ="tabs-2">
									<div display="block" id="applications">
										<br/>
										<!-- <table style="width:100%; margin-left:50px;" >
											<tr>
											<td class="fc"> Включенные приложения:&#xA0;</td>
											<td style="padding-top:10px">
												<table>
												<xsl:for-each select="document/glossaries/apps/entry">
													<xsl:variable name="app" select="apptype"/>
													<tr class="QA_{$app}">
													 <td style="padding-right:5px">
																<input type="checkbox" value="{apptype}" name="enabledapps">
																<xsl:if test="/request/document/glossaries/roles/entry/appname = $app">
																	<xsl:attribute name="checked">checked</xsl:attribute>
																</xsl:if> 
															</input>
															<font style="padding:5px"><xsl:value-of select="apptype"/></font>
														</td>
														<td style="padding-right:5px">
															<font style="padding:5px; font-size:12px">Тип авторизации:&#xA0;</font>
															<select name="loginmode" onchange="javascript:selectLoginMode(this,'{$app}')">
																<xsl:attribute name="id">loginmode_<xsl:value-of select="$app"/></xsl:attribute>
																<option value="0">
																	<xsl:if test="/request/document/enabledapps/entry[appname=$app]/loginmode = 'LOGIN_AND_REDIRECT' ">
																		<xsl:attribute name="selected"></xsl:attribute>
																	</xsl:if> 
																Логин и редирект
																</option>
																<option value="1">
																	<xsl:if test="/request/document/enabledapps/entry[appname=$app]/loginmode = 'LOGIN_AND_QUESTION'">
																		<xsl:attribute name="selected"></xsl:attribute>
																	</xsl:if>
																	Вход и вопрос
																</option>
																<option value="2">
																	<xsl:if test="/request/document/enabledapps/entry[appname=$app]/loginmode = 'JUST_LOGIN' or not(/request/document/enabledapps/entry[appname=$app]/loginmode)">
																		<xsl:attribute name="selected"></xsl:attribute>
																	</xsl:if>
																	Вход 
																</option>
															</select>
														</td>
														<td style="padding-right:5px">
															<font style="font-size:12px">Вопрос:&#xA0;</font>
															<input type="text" name="question_{$app}" size="30" value="{/request/document/enabledapps/entry[appname=$app]/entry[1]/question}">
																<xsl:if test="/request/document/enabledapps/entry[appname eq $app]/loginmode = 'JUST_LOGIN' or not(/request/document/enabledapps/entry/appname = $app)">
																	<xsl:attribute name="readonly"></xsl:attribute>
																	<xsl:attribute name="value"></xsl:attribute>
																	<xsl:attribute name="class">readonly</xsl:attribute>
																</xsl:if>
															</input>
														</td>
														<td style="padding-right:5px">
															<font style=" font-size:12px">Ответ:&#xA0;</font>
															<input type="text" name="answer_{$app}" size="30" value="{/request/document/enabledapps/entry[appname=$app]/entry[1]/answer}">
																<xsl:if test="/request/document/enabledapps/entry[appname eq $app]/loginmode = 'JUST_LOGIN' or not(/request/document/enabledapps/entry/appname = $app)">
																	<xsl:attribute name="readonly"></xsl:attribute>
																	<xsl:attribute name="value"></xsl:attribute>
																	<xsl:attribute name="class">readonly</xsl:attribute>
																</xsl:if>
															</input>
															<a href="javascript:$.noop()" onclick="javascript:AddNewQuestAndAnswer(this,'{$app}')">
																add
															</a>
														</td>
													</tr>
													<xsl:for-each select="/request/document/enabledapps/entry[appname=$app]/entry[not(position() = 1)]">
														<tr class="QA_{$app}">
															<td style="padding-right:5px">
															</td>
															<td style="padding-right:5px">
															</td>
															<td style="padding-right:5px">
																<font style="font-size:12px">Вопрос:&#xA0;</font>
																<input type="text" name="question_{$app}" size="30" value="{question}">
																	<xsl:if test="/request/document/enabledapps/entry[appname=$app]/loginmode = 'JUST_LOGIN'">
																		<xsl:attribute name="readonly"></xsl:attribute>
																		<xsl:attribute name="value"></xsl:attribute>
																		<xsl:attribute name="class">readonly</xsl:attribute>
																	</xsl:if>
																</input>
															</td>
															<td style="padding-right:5px">
																<font style=" font-size:12px">Ответ:&#xA0;</font>
																<input type="text" name="answer_{$app}" size="30" value="{answer}">
																	<xsl:if test="/request/document/enabledapps/entry[appname=$app]/loginmode = 'JUST_LOGIN'">
																		<xsl:attribute name="readonly"></xsl:attribute>
																		<xsl:attribute name="value"></xsl:attribute>
																		<xsl:attribute name="class">s</xsl:attribute>
																	</xsl:if>
																</input>
																<a href="javascript:$.noop()" onclick="javascript:AddNewQuestAndAnswer(this,'{$app}')">
																	add
																</a>
															</td>
														</tr> 
													</xsl:for-each>
												</xsl:for-each>
				 							</table>
										</td>
									</tr>
								</table> -->
							<table border="0" style="margin-left:50px; margin-top:30px;width:645px; border-collapse:collapse" class="table_editable">
								<xsl:if test="not(/request/document/fields/issupervisor='1') and document/@status != 'new'">
									<xsl:attribute name="class">table_noteditable</xsl:attribute>
								</xsl:if>
								<xsl:for-each select="document/glossaries/application/entry">
									<xsl:variable name="app" select="apptype"/>
									<tr style="background:#EDEDED">
										<th colspan="3" style="text-align:left">
											<div style="width:290px; display:inline-block; text-align:right">
												<input type="checkbox" id="allchbox" value="{$app}" name="enabledapps" autocomplete="off">
													<xsl:attribute name="onсlick">javascript:checkAll(this, '<xsl:value-of select="$app"/>')</xsl:attribute>
													<xsl:if test="not(/request/document/fields/issupervisor='1') and $status != 'new'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="/request/document/fields/apps/entry = $app">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
												</input>
											</div>
											<font style="vertical-align:2px; margin-left:5px">
												<xsl:value-of select="$app"/>
											</font>
											<input type="hidden" name="loginmode" value="2"/>
										</th>
									</tr>
									<xsl:for-each select="/request/document/glossaries/roles/entry[app = $app]">
										<tr>
											<xsl:attribute name='class'><xsl:value-of select="$app"/></xsl:attribute> 
											<td>
												<input type="checkbox" value="{name}#{$app}" name='role'>
													<xsl:attribute name='class' select="$app"/>
													<xsl:if test="/request/document/fields/role/entry[appid=$app]/name = name">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:if test="not(/request/document/fields/issupervisor='1') and $status != 'new'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<br/>
												</input>
											</td>
											<td style="text-align:left">
												<xsl:if test="name = 'supervisor'">
													<xsl:attribute name="style">color:red</xsl:attribute>
												</xsl:if>	
					      				  		<xsl:value-of select="name"/>
					      				  		<font style="margin-left:5px; color:#aaaaaa">
					      				  			<xsl:value-of select="description"/>
					      				  		</font>
											</td>
										</tr>
									</xsl:for-each>
									<tr>
										<td height="10px"></td>
									</tr>	
								</xsl:for-each>
								<tr style= "text-align:center;background-color:#ededed">
									<td style="text-align:left; width:25px"></td>	
									<th colspan="2">System</th>
								</tr>
								<tr>
									<td>
										<input type="checkbox" value="supervisor" name='role' disabled="disabled">
											<xsl:if test="/request/document/fields/role/entry = 'supervisor'">
												<xsl:attribute name="checked">checked</xsl:attribute>
											</xsl:if>
											<br/>
										</input>
									</td>
									<td style="text-align:left">
										<xsl:attribute name="style">color:red</xsl:attribute>
					      		  		supervisor
					      		  		<font style="margin-left:5px; color:#aaaaaa">
					      		  		</font>
									</td>
								</tr>
								<!-- 	<xsl:for-each-group select="document/glossaries/roles/entry" group-by ="app">
									<xsl:variable name="role" select="name"/>
									<xsl:variable name="app" select="apptype"/>
									<tr style= "text-align:center;background-color:#ededed">
										<td style="text-align:left; width:25px">
											<input type="checkbox" id="allchbox" value="{app}" name="enabledapps">
												<xsl:attribute name="onClick">javascript:checkAll(this, '<xsl:value-of select="app"/>')</xsl:attribute>
													<xsl:if test="/request/document/fields/apps/entry/appname = app">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if> 
											</input>
										</td>	
										<th colspan="2"><xsl:value-of select="app"/></th>
									</tr>
									<xsl:for-each select="current-group()">
										<tr>
											<xsl:attribute name='class'><xsl:value-of select="app"/></xsl:attribute> 
											<td>
												<input type="checkbox" value="{name}" name='role'>
												<xsl:attribute name='class'><xsl:value-of select="app"/></xsl:attribute>  
													<xsl:if test="/request/document/fields/role[entry = $role]">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:if test="/request/document/fields[role = $role]">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>	
													<br/>
												</input>
											</td>
											<td style="text-align:left">
												<xsl:if test="name = 'supervisor'">
													<xsl:attribute name="style">color:red</xsl:attribute>
												</xsl:if>	
					      				  		<xsl:value-of select="name"/>
					      				  		<font style="margin-left:5px; color:#aaaaaa">
					      				  			<xsl:value-of select="description"/>
					      				  		</font>
											</td>
										</tr>
									</xsl:for-each>
									<tr>
										<td height="10px"></td>
									</tr>	
								</xsl:for-each-group>
								 -->
							</table>
						</div>
					</div>
					<div class="ui-tabs-panel" id ="tabs-3" >
						<div display="block" id="publickey">
						<br/>
							<table border="0" style="width:100%;">
								<tr>		
									<xsl:choose>
										<xsl:when test="/request/document/fields/publickey!= ''">
											<td class="fc"><xsl:value-of select="document/captions/publickey/@caption"/>:&#xA0;</td>
											<td>
												<input type="text" name="publickey" disabled="disabled" value="{/request/document/fields/publickey}"/>					
											</td>
										</xsl:when>					
										<xsl:otherwise>
											<td style ="padding-left:70px">
												<xsl:value-of select="document/captions/elsignstatus/@caption"/>
											</td>												
										</xsl:otherwise>			
									</xsl:choose>								
								</tr>
							</table>
						</div>
					</div>
				</xsl:if>
							</form>
						</div>
						<div style="height:10px"/>
					</div>
				</div>
				<xsl:call-template name="formoutline"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>