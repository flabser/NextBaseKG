<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/fields/title"/>
	<xsl:variable name="path" select="/request/@skin" />
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Workflow документооборот - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="markisread"/>
				<script type="text/javascript">
					$(document).ready(function(){
						hotkeysnav()
						 $('.coord_comment_action .open').click(function (){
						 	link=$(this)
						 	scrollheight =   $(this).parents('.coord_comment_box').children(".coord_comment_txt")[0].scrollHeight;
					        $(this).parents('.coord_comment_box').animate({height: scrollheight + 15},'fast',function(){$(link).parents('.coord_comment_box').height("auto")}).removeClass('close').addClass('open');
					    });
					    $('.coord_comment_action .close').click(function (){
					    	link=$(this)
					        $(this).parents('.coord_comment_box').animate({height: 166},'fast', function(){$(link).parents('.coord_comment_box').addClass('close')}).removeClass('open');
					    });
					   $(window).resize(function(){
						    $(".coord_comment_box").each(function(){
								if($(this).children(".coord_comment_txt")[0].scrollHeight &lt; 150){
									$(this).children(".coord_comment_action").css("display","none")
								}else{
									$(this).children(".coord_comment_action").css("display","block")
								}
							})
						})
					})
					<![CDATA[
						function hotkeysnav() {
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btncoordyes").hotnav({keysource:function(e){ return "y"; }});
							$("#btncoordno").hotnav({keysource:function(e){ return "n"; }});
							$("#btngrantaccess").hotnav({keysource:function(e){ return "g"; }});
							$("#btnsavedraft").hotnav({keysource:function(e){ return "s"; }});
							$("#btntocoordinate").hotnav({keysource:function(e){ return "t"; }});
							$("#btnsendsign").hotnav({keysource:function(e){ return "m"; }});
							$("#btnsign").hotnav({keysource:function(e){ return "y"; }});
							$("#btnstopdoc").hotnav({keysource:function(e){ return "l"; }});
							$("#btnsignno").hotnav({keysource:function(e){ return "n"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
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
									   case 78:
									  		<!-- клавиша n -->
									    	e.preventDefault();
									    	$("#btnsignno").click();
									    	$("#btncoordno").click();
									      	break;
									   case 83:
									   		<!-- клавиша s -->
									     	e.preventDefault();
									     	$("#btnsavedraft").click();
									      	break;
									   case 84:
									   		<!-- клавиша t -->
									     	e.preventDefault();
									     	$("#btntocoordinate").click();
									      	break;
									   case 89:
									   		<!-- клавиша y -->
									     	e.preventDefault();
									     	$("#btnsign").click();
									     	$("#btncoordyes").click();
									      	break;
									   case 76:
									   		<!-- клавиша y -->
									     	e.preventDefault();
									     	$("#btnstopdoc").click();
									      	break;
									   case 77:
									   		<!-- клавиша y -->
									     	e.preventDefault();
									     	$("#btnsendsign").click();
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
						}
					]]>
				</script>
				<xsl:if test="$editmode = 'edit'">
					<xsl:call-template name="htmlareaeditor"/>
				</xsl:if>
			</head>
			<body>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>
					<div class="formwrapper">
						<div class="formtitle">
							<!-- заголовок -->
							<div class="title" style="float:left">
								<xsl:call-template name="doctitleprj"/>
								<span id="whichreadblock">Прочтен</span>
							</div>
						</div>
						<div class="button_panel">
							<span style="vertical-align:12px; float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="get_document_accesslist"/>
								<xsl:call-template name="projects_buttons"/>
								<xsl:call-template name="ECPsign"/>
							</span>
							<span style="float:right">
								<!-- кнопка "закрыть" -->
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div
							style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul
								class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1">
										<xsl:value-of select="document/captions/properties/@caption"/>
									</a>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-2">
										<xsl:value-of select="document/captions/content/@caption"/>
									</a>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-3">
										<xsl:value-of select="document/captions/coordination/@caption"/>
									</a>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-4" style="padding-right:5px">
										<xsl:value-of select="document/captions/attachments/@caption"/>
										<img id="loading_attach_img" style="vertical-align: -3px; margin-left: 3px; visibility:hidden;" src="/SharedResources/img/classic/ajax-loader-small.gif"/>
									</a>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-5">
										<xsl:value-of select="document/captions/additional/@caption"/>
									</a>
								</li>
								<span style="float:right; font-weight:normal;">
									<table style="font-size:11px !important;">
										<tr>
											<td>
												<!-- <font style="font-size:11px; font-style: arial;"> <xsl:value-of 
														select="document/fields/statuscoord/@caption"/> : </font> -->
											</td>
											<td>
												<b><xsl:value-of select="document/captions/author/@caption"/></b>: 
												<font><xsl:value-of select="document/fields/author"/></font>
												<font style="font-style:arial; margin-left:7px; font-weight:bold">
													<xsl:choose>
														<xsl:when test="document/fields/coordination/status = 'DRAFT'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/draft/@caption"/>
															</xsl:attribute>
															<xsl:value-of select="document/captions/draft/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'COORDINATING'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/projectactivecoord/@caption"/>
															</xsl:attribute>
															<xsl:value-of select="document/captions/nasoglasovanii/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'COORDINATED'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/alllevelcoordcomplete/@caption"/>
															</xsl:attribute>
															<xsl:value-of select="document/captions/soglasovanl/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'REJECTED'">
															<xsl:attribute name="title">
																<xsl:value-of select="concat(document/captions/projectrejected/@caption,' : ')"/>
																<xsl:variable name="counter" select="count(/request/document/fields/coordination[status='REJECTED']/blocks/entry/coordinators/entry[decision='DISAGREE'])"/>
																<xsl:for-each select="document/fields/coordination[status='REJECTED']/blocks/entry/coordinators/entry[decision='DISAGREE']">
																	<xsl:value-of select="concat(decisiondate,' ',employer/fullname)"/>
																	<xsl:if test="$counter > 1 and $counter > position()">
																		<xsl:text>, </xsl:text>
																	</xsl:if>
																</xsl:for-each>
															</xsl:attribute>
															<xsl:value-of select="document/captions/rejected/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'NEWVERSION'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/projectnewversion/@caption"/>
															</xsl:attribute>
															<xsl:value-of select="document/captions/newversion/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'SIGNING'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/projectwaitingsign/@caption"/>&#xA0;
																<xsl:value-of select="signerdisplay"/>
															</xsl:attribute>
															<xsl:value-of select="document/captions/waitingsign/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'SIGNED'">
															<xsl:attribute name="title">
																<xsl:value-of select="concat(document/captions/projectwassigned/@caption,' : ',document/fields/coordination/blocks/entry[type='TO_SIGN']/coordinators/entry/decisiondate ,' ',document/fields/coordination[status='SIGNED']/blocks/entry[type='TO_SIGN']/coordinators/entry/employer/fullname)"/> 
															</xsl:attribute>
															<xsl:value-of select="document/captions/signed/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'NOCOORDINATION'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/projectnotcoordinating/@caption"/>
															</xsl:attribute>
															<xsl:value-of
																select="document/captions/notcoordinatingproject/@caption"/>
														</xsl:when>
														<xsl:when test="document/fields/coordination/status = 'EXPIRED'">
															<xsl:attribute name="title">
																<xsl:value-of select="document/captions/projectwasdelayed/@caption"/>
															</xsl:attribute>
															<xsl:value-of select="document/captions/prosrochen/@caption"/>
														</xsl:when>
													</xsl:choose>
												</font>
												<xsl:if test="document/fields/coordination/blocks/entry[type='TO_SIGN']/coordinators/entry/comment != ''">
													<a class="doclink" href="" style="margin-left:5px">
														<xsl:attribute name="href">javascript:infoDialog('<xsl:value-of select="concat(document/fields/coordination/blocks/entry[type='TO_SIGN']/coordinators/entry/employer/fullname,': ',document/fields/coordination/blocks/entry[type='TO_SIGN']/coordinators/entry/comment)"/>','information')</xsl:attribute>Комментарий ответа
													</a>
												</xsl:if>
												<xsl:if test="document/fields/docversion != 1 and document/fields/docversion !=''">
													<font style="font-size:11px; margin-left:7px">
														<xsl:value-of select="document/captions/docversion/@caption"/>: 
														<b>
															<xsl:value-of select="document/fields/docversion"/>
														</b>
													</font>
												</xsl:if>
											</td>
										</tr>
									</table>
								</span>
							</ul>
							<form action="Provider" name="frm" method="post" id="frm"
								enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
									<br/>
									<table width="100%" border="0">
										<xsl:if test="document/fields/link/entry !=''">
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/regdocument/@caption"/> :</td>
							            		<td>
													<a class="doclink" href="{document/fields/link/entry/@url}">
														<xsl:value-of select="document/fields/link/entry"/>
													</a>
				                           		</td>   					
											</tr>
										</xsl:if>	
										<xsl:if test="document/fields/versionlink/entry !=''">
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/versionlink/@caption"/> :</td>
							            		<td>
													<a class="doclink" href="{document/fields/versionlink/entry/@url}">
														<xsl:value-of select="document/fields/versionlink/entry"/>
													</a>
				                           		</td>   					
											</tr>
										</xsl:if>	
										<!-- Поле "Ответный на входящий документ" -->
										<xsl:if test="document/fields/indoclink/entry != '' and document/fields/indoclink/entry">
											<tr>
												<td class="fc">
													<xsl:value-of select="document/captions/indoclink/@caption"/> :
												</td>
								            	<td>
						                      		<a class="doclink" href="{document/fields/indoclink/entry/@url}">
														<xsl:value-of select="document/fields/indoclink/entry"/>
													</a>
						                       	</td>   					
											</tr>
										</xsl:if>
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/signer/@caption"/> :
												</font>
												<xsl:if test="$editmode = 'edit'">
													<a>
														<xsl:attribute name="href">javascript:dialogBoxStructure('signers','false','signer','frm', 'signertbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</xsl:if>
											</td>
											<td>
												<xsl:if test="document/@status='new'">
													<table id="signertbl" style="border-spacing:0px 3px;">
														<tr>
															<td class="td_editable" style="width:600px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																&#xA0;
															</td>
														</tr>
													</table>
												</xsl:if>
												<xsl:if test="document/@status != 'new'">
													<table id="signertbl" style="border-spacing:0px 3px;">
														<tr>
															<td class="td_editable" style="width:600px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/coordination/blocks/entry[type='TO_SIGN']/coordinators/entry/employer/fullname"/>&#xA0;
															</td>
														</tr>
													</table>
												</xsl:if>
												<xsl:for-each select="document/fields/coordination/blocks/entry">
													<xsl:if test="type='TO_SIGN'">
														<input type="hidden" id='coordBlockSign' name="coordblock"
															value="{id}`tosign`0`{coordinators/entry/employer/userid}`{status}" />
													</xsl:if>
												</xsl:for-each>
												<input type="hidden" id="signercaption" value="{document/captions/signer/@caption}"/>
												<script>
													if ($("#signertbl tr").length &lt; 1){
														$("#signertbl").append('<tr><td class="td_editable" style="width:600px;">&#xA0;</td></tr>');
													}
												</script>
											</td>
										</tr>
										<!-- Корреспондент -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/corr/@caption"/>:
												</font>
												<xsl:if test="$editmode = 'edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('corrcat','false','corr','frm', 'corrtbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="corrtbl" style="border-spacing:0px 3px;">
													<tr>
														<td class="td_editable" style="width:600px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/corr"/>&#xA0;
														</td>
													</tr>
												</table>
												<input type="hidden" id="corr" name="corr" value="{document/fields/corr/@attrval}" />
												<input type="hidden" id="corrcaption" value="{document/captions/corr/@caption}"/>
											</td>
										</tr>
										<!-- Поле "Номенклатура дел" -->						
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/nomentype/@caption"/> : 
												</font>
												<xsl:if test="$editmode ='edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('n','false','nomentype','frm', 'nomentypetbl');</xsl:attribute>								
														<img src="/SharedResources/img/iconset/report_magnify.png"/>			
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="nomentypetbl" style="border-spacing:0px 3px;">
													<tr>
														<td class="td_editable" style="width:600px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/nomentype"/>&#xA0;
														</td>
													</tr>
												</table>
												<input type="hidden" id="nomentype" name="nomentype" value="{document/fields/nomentype/@attrval}"/>
												<input type="hidden" id="nomentypecaption" value="{document/captions/nomentype/@caption}"/>
											</td>
										</tr>
										<!-- вид доставки -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/deliverytype/@caption"/> : 
											</td>
											<td>
												<xsl:variable name="deliverytype" select="document/fields/deliverytype/@attrval"/>
												<select size="1" name="deliverytype" class="select_editable" style="width:611px;">
													<xsl:if test="$editmode != 'edit'">
														<xsl:attribute name="disabled">true</xsl:attribute>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
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
												<xsl:if test="document/@editmode !='edit'">
													<input type="hidden" name="deliverytype" value="{$deliverytype}"/>
												</xsl:if>
											</td>
										</tr>
										<!-- поле "Проект" -->
										<xsl:if test="not(document/fields/project/@mode = 'hide')">
											<tr>
												<td class="fc" style="padding-top:5px">
													<xsl:value-of select="document/captions/conectedproject/@caption"/> :
												</td>
												<td style="padding-top:5px">
													<xsl:variable name="project"
														select="document/fields/project/@attrval" />
													<select size="1" class="select_editable" name="project"
														style="width:611px;">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="disabled">true</xsl:attribute>
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<option value="">
																<xsl:attribute name="selected">selected</xsl:attribute>
																<xsl:value-of select="document/fields/project" />
															</option>
														</xsl:if>
														<xsl:if test="$editmode = 'edit'">
															<option value=" ">
																<xsl:attribute name="selected">selected</xsl:attribute>
																&#xA0;
															</option>
														</xsl:if>
														<xsl:for-each
															select="document/glossaries/projectsprav/query/entry">
															<option value="{@docid}">
																<xsl:if test="$project = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1" />
															</option>
														</xsl:for-each>
													</select>
												</td>
											</tr>
										</xsl:if>
										<!-- поле "Категория" -->
										<xsl:if test="not(document/fields/category/@mode = 'hide')">
											<tr>
												<td class="fc" style="padding-top:5px">
													<xsl:value-of select="document/captions/category/@caption"/> :
												</td>
												<td style="padding-top:5px">
													<xsl:variable name="category"
														select="document/fields/category/@attrval" />
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
										
										<!-- поле "Характер вопроса" <tr> <td class="fc" style="padding-top:5px"> 
											<xsl:value-of select="document/captions/har/@caption"/> : </td> <td style="padding-top:5px"> 
											<xsl:variable name="har" select="document/fields/har/@attrval"/> <select 
											name="har" class="select_editable" style="width:611px;"> <xsl:if test="$editmode 
											!= 'edit'"> <xsl:attribute name="disabled">true</xsl:attribute> <xsl:attribute 
											name="class">select_noteditable</xsl:attribute> </xsl:if> <xsl:for-each select="document/glossaries/har/query/entry"> 
											<option value="{@docid}"> <xsl:if test="$har = @docid"> <xsl:attribute name="selected">selected</xsl:attribute> 
											</xsl:if> <xsl:value-of select="viewcontent/viewtext1"/> </option> </xsl:for-each> 
											</select> </td> </tr> -->
										<!-- Краткое содержание -->
										<tr>
											<td class="fc" style="padding-top:5px">
												<xsl:value-of select="document/captions/briefcontent/@caption"/> :
											</td>
											<td style="padding-top:5px">
												<div>
													<textarea name="briefcontent" style="overflow:hidden; width:752px"
														cols="83" onkeypress="maxCountSymbols (this, 172, event)"
														rows="3" class="textarea_editable">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="onfocus">javascript: $(this).blur()</xsl:attribute>
															<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:if test="$editmode = 'edit'">
															<xsl:attribute name="onfocus">javascript: fieldOnFocus(this)</xsl:attribute>
															<xsl:attribute name="onblur">javascript: fieldOnBlur(this)</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/briefcontent"/>
													</textarea>
												</div>
												<xsl:if test="$editmode !='edit'">
													<input type="hidden" name="briefcontent"
														value="{document/fields/briefcontent}"/>
												</xsl:if>
											</td>
										</tr>
										<!-- Дополнительно <tr> <td class="fc" style="padding-top:5px"> 
											<xsl:value-of select="document/captions/more/@caption"/> : </td> <td style="padding-top:5px"> 
											<input type="checkbox" name="autosendtosign" id="autosendtosign"> <xsl:if 
											test="$editmode != 'edit'"> <xsl:attribute name="disabled">true</xsl:attribute> 
											</xsl:if> <xsl:if test="document/@status ='new'"> <xsl:attribute name="value">1</xsl:attribute> 
											</xsl:if> <xsl:if test="document/fields/autosendtosign = '1'"> <xsl:attribute 
											name="checked">checked</xsl:attribute> <xsl:attribute name="value">1</xsl:attribute> 
											</xsl:if> <xsl:value-of select="document/fields/autosendtosign/@caption"/> 
											</input> <br/> <input type="checkbox" name="autosendaftersign" id="autosendaftersign"> 
											<xsl:if test="$editmode != 'edit'"> <xsl:attribute name="disabled">true</xsl:attribute> 
											</xsl:if> <xsl:if test="document/@status ='new'"> <xsl:attribute name="value">1</xsl:attribute> 
											</xsl:if> <xsl:if test="document/fields/autosendaftersign = '1'"> <xsl:attribute 
											name="checked">checked</xsl:attribute> <xsl:attribute name="value">1</xsl:attribute> 
											</xsl:if> <xsl:value-of select="document/fields/autosendaftersign/@caption"/> 
											</input> </td> </tr> -->
									</table>
									<br />
								</div>
								<div id="tabs-2">
									<br />
									<table width="100%" border="0">
										<!-- Содержание -->
										<tr>
											<td style="padding-left:30px">
												<xsl:if test="$editmode = 'edit'">
														<script type="text/javascript">  
															$(document).ready(function($) {
												       			 CKEDITOR.config.width = "815px"
												       			 CKEDITOR.config.height = "450px"
												    		});
														</script>
													<textarea id="MyTextarea" name="contentsource">
														<xsl:if test="@useragent = 'ANDROID'">
															<xsl:attribute name="style">width:500px; height:300px</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/contentsource"/>
													</textarea>
												</xsl:if>
												<xsl:if test="$editmode != 'edit'">
													<div id="briefcontent">
														<xsl:attribute name="style">width:815px; height:450px; background:#EEEEEE; padding: 3px 5px; overflow-x:auto</xsl:attribute>
														<script>
															$("#briefcontent").html("<xsl:value-of select='document/fields/contentsource'/>")
														</script>
													</div>
													<input type="hidden" name="contentsource" value="{document/fields/contentsource}"/>
												</xsl:if>
											</td>
										</tr>
									</table>
								</div>
								<div id="tabs-3">
									<br/>
									<xsl:if test="$editmode = 'edit' and document/fields/coordination/status = 'DRAFT' or document/fields/coordination/status = 'NEWVERSION'">
										<table class="button_panel">
											<tr>
												<td>
													<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" type="button">
														<xsl:attribute name="onclick">javascript:addCoord()</xsl:attribute>
														<span>
															<img src="/SharedResources/img/classic/icons/layout_add.png"
																style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"/>
															<font style="font-size:12px; vertical-align:top">
																<xsl:value-of select="document/captions/addblock/@caption"/>
															</font>
														</span>
													</button>
												</td>
												<td>
													<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" type="button">
														<xsl:attribute name="onclick">javascript:delCoord()</xsl:attribute>
														<span>
															<img src="/SharedResources/img/classic/icons/layout_delete.png" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"/>
															<font style="font-size:12px; vertical-align:top">
																<xsl:value-of select="document/captions/removeblock/@caption"/>
															</font>
														</span>
													</button>
												</td>
											</tr>
										</table>
									</xsl:if>
									<table id="coordTableView" style="border-collapse:collapse; width:97%; margin-left:3px" class="table-border-gray">
										<tr style="text-align:center;">
											<td width="1%">
												<input type="checkbox" id="allchbox" onClick="checkAll(this);"/>
											</td>
											<td width="2%">№</td>
											<td width="12%">
												<xsl:value-of select="document/captions/type/@caption"/>
											</td>
											<td width="50%">
												<xsl:value-of select="document/captions/contributors/@caption"/>
											</td>
											<td width="9%">
												<xsl:value-of select="document/captions/waittime/@caption"/>
											</td>
											<td width="19%">
												<xsl:value-of select="document/captions/statuscoord/@caption"/>
											</td>
										</tr>
										<xsl:for-each select="document/fields/coordination/blocks/entry">
											<xsl:if test="type != 'TO_SIGN'">
												<tr class="trblockCoord">
													<td style="border-bottom: 1px solid lightgray">
														<input type="checkbox" name="chbox" id="{position()}"/>
														<xsl:for-each select="coordinators/entry">
															<br/>
														</xsl:for-each>
													</td>
													<td style="text-align:center; border-bottom: 1px solid lightgray">
														<xsl:value-of select="num"/>
														<xsl:for-each select="coordinators/entry">
															<br/>
														</xsl:for-each>
													</td>
													<td style="border-bottom: 1px solid lightgray; text-align:center">
														<xsl:choose>
															<xsl:when test="type = 'PARALLEL_COORDINATION'">
																<xsl:value-of select="/request/document/captions/parcoord/@caption"/>
															</xsl:when>
															<xsl:when test="type = 'SERIAL_COORDINATION'">
																<xsl:value-of select="/request/document/captions/sercoord/@caption"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="/request/document/captions/typenotdefined/@caption"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:for-each select="coordinators/entry">
															<br/>
														</xsl:for-each>
													</td>
													<td style="border-bottom: 1px solid lightgray">
														<table>
															<xsl:for-each select="coordinators/entry">
																<tr>
																	<td style="text-align:right; border:none; padding:5px 0px !important; vertical-align:top" nowrap="nowrap">
																		<xsl:value-of select="employer/fullname"/>
																		<p style="margin:0px">
																			<xsl:choose>
																				<xsl:when test="decision='AGREE'">
																					<xsl:value-of select="concat(decisiondate,' ')"/>
																					<b><xsl:value-of select="/request/document/captions/agree/@caption"/></b>
																				</xsl:when>
																				<xsl:when test="decision='DISAGREE'">
																					<xsl:value-of select="concat(decisiondate,' ')"/>
																					<b><xsl:value-of select="/request/document/captions/disagree/@caption"/></b>
																				</xsl:when>
																				<xsl:when test="iscurrent='true'">
																					<xsl:value-of select="/request/document/captions/awairesponse/@caption"/>
																				</xsl:when>
																			</xsl:choose>
																		</p>
																	</td>
																	<td style="border:none; word-break:break-all; vertical-align:top; padding-left:10px">
																		<div class="coord_comment_box close">
																			<div class='coord_comment_txt'>
																				<xsl:choose>
																					<xsl:when test="comment = 'null'">
																					</xsl:when>
																					<xsl:when test="string-length(comment)!= 0">
		                                                                                 <xsl:value-of select="/request/document/captions/comment/@caption"/>: <xsl:value-of select="comment"/>
																					</xsl:when>
																				</xsl:choose>
																			</div>
																			<div class='coord_comment_action'>
																	        	<a href='#' class='close doclink'>Скрыть</a><a href='#' class='open doclink'>Показать все</a>
																	   		</div>
																	   		<script>
																	   			$(".coord_comment_box").each(function(){
																	   				if($(this).height() &lt; 150){
																	   					$(this).children(".coord_comment_action").css("display","none")
																	   				}
																	   			})
																	   		</script>
																		</div>
																		
																	</td>
																</tr>
															</xsl:for-each>
														</table>
													</td>
													<td style="border-bottom: 1px solid lightgray; text-align:center">
														<xsl:choose>
															<xsl:when test="delaytime = 0">
																<xsl:value-of select="/request/document/captions/unlimtimecoord/@caption"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="delaytime"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:for-each select="coordinators/entry">
															<br/>
														</xsl:for-each>
													</td>
													<td style="border-bottom: 1px solid lightgray; text-align:center">
														<xsl:choose>
															<xsl:when test="status ='COORDINATING'">
																<xsl:value-of select="/request/document/captions/oncoordinating/@caption"/>
															</xsl:when>
															<xsl:when test="status ='COORDINATED'">
																<xsl:value-of select="/request/document/captions/complete/@caption"/>
															</xsl:when>
															<xsl:when test="status ='AWAITING'">
																<xsl:value-of select="/request/document/captions/expectbegincoord/@caption"/>
															</xsl:when>
															<xsl:when test="status ='EXPIRED'">
																<xsl:value-of select="/request/document/captions/prosrochen/@caption"/>
															</xsl:when>
															<xsl:when test="status ='UNDEFINED'">
																<xsl:value-of select="/request/document/captions/undefined/@caption"/>
															</xsl:when>
															<xsl:otherwise>
																<xsl:value-of select="/request/document/captions/undefined/@caption"/>
															</xsl:otherwise>
														</xsl:choose>
														<xsl:for-each select="coordinators/entry">
															<br/>
															<input type="hidden" value="{employer/userid}" class="{employer/userid}"/>
														</xsl:for-each>
														<input type="hidden" name="coordblock">
															<xsl:attribute name="value"><xsl:value-of select="id"/>`<xsl:choose><xsl:when test="type='PARALLEL_COORDINATION'">par</xsl:when><xsl:when
																test="type='SERIAL_COORDINATION'">ser</xsl:when></xsl:choose>`<xsl:value-of
																select="delaytime" />`<xsl:for-each select="coordinators/entry"><xsl:value-of
																select="employer/userid"/><xsl:if test="following-sibling::*">^</xsl:if></xsl:for-each>`<xsl:value-of
																select="status"/></xsl:attribute>
														</input>
													</td>
												</tr>
											</xsl:if>
										</xsl:for-each>
									</table>
									<br/>
								</div>
								<!-- Скрытые поля -->
								<xsl:for-each select="document/fields/coordination/blocks/entry">
									<xsl:if test="type='TO_SIGN'">
										<input type="hidden" id='signer' name="signer" value="{coordinators/entry/employer/userid}"/>
									</xsl:if>
								</xsl:for-each>
								<input type="hidden" name="type" value="save"/>
								<input type="hidden" name="id" value="{/request/@id}"/>
								<input type="hidden" name="key" value="{document/@docid}"/>
								<input type="hidden" name="projectdate" value="{document/fields/projectdate}"/>
								<input type="hidden" name="coordstatus" id="coordstatus" value="{document/fields/coordination/status}"/>
								<input type="hidden" name="docversion" id="docversion" value="{document/fields/docversion}"/>
								<input type="hidden" name="action" id="action"/>
								<xsl:call-template name="ECPsignFields"/>
							</form>
							<!-- Форма "Вложения" -->
							<table style="display:none" id="extraCoordTable">
							</table>
							<table style="display:none" id="notesTable">
								<tr></tr>
							</table>
							<div id="tabs-4">
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