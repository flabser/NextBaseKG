<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype" select="request/document/fields/title"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
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
			</head>
			<body>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div  class="formtitle">
							<div style="float:left" class="title">
				  				<xsl:call-template name="doctitle"/><span id="whichreadblock">Прочтен</span>										
				   		 	</div>
				    		<div style="float:right; padding-right:5px"></div>
						</div>		
						<div class="button_panel">
							<span style="vertical-align:12px; float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="get_document_accesslist"/>
								<xsl:call-template name="save"/>
								<xsl:call-template name="ECPsign"/>
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
										<xsl:if test="document/fields/link/entry !=''">
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/projectdoc/@caption"/> :</td>
							            		<td>
													<a class="doclink" href="{document/fields/link/entry/@url}">
														<xsl:value-of select="document/fields/link/entry"/>
													</a>
				                           		</td>   					
											</tr>
										</xsl:if>	
										<!-- поля "Исходящий номер" и "Дата исходящего"	-->
										<tr>
											<td  class="fc">
												<xsl:value-of select="document/captions/vn/@caption"/> № :
											</td>
									    	<td>
						                    	<input type="text" name="vn" value="" size="10" class="td_noteditable" onfocus="javascript:$(this).blur()" readonly="readonly" style="width:100px;">
					                    			<xsl:attribute name="value" select="document/fields/vn"/>
						                    	</input>
						                        &#xA0;
						                        <xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
						                       	<input type="text" class="td_noteditable" value="{document/fields/dvn}" readonly="readonly" onfocus="javascript: $(this).blur()" style="width:80px;"/>
						                   </td>   					
										</tr>
										<!-- Поле "Корреспондент" -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/corr/@caption"/> : 
												</font>
												<xsl:if test="$editmode = 'edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('corrcat','false','corr','frm', 'corrtbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="corrtbl">
													<xsl:for-each select="document/fields/corr">
														<tr>
															<td class="td_editable" style="width:600px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>&#xA0;
																<span style='float:right; border-left:1px solid #ccc; width:20px; padding-right:10px; padding-left:2px; padding-top:1px; color:#ccc; font-size:11px'><font><xsl:value-of select="document/fields/corr/@attrval"/></font></span>
																<input type="hidden" id="corr" name="corr" value="{./@attrval}"/>
															</td>
														</tr>
													</xsl:for-each>
													<xsl:if test="not(document/fields/corr)">
														<tr>
															<td class="td_editable" style="width:600px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																&#xA0;
															</td>
														</tr>
													</xsl:if>
												</table>
												<input type="hidden" id="corrcaption" value="{document/captions/corr/@caption}"/>
											</td>
										</tr>
										<!-- поле "Подписал" -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/signedby/@caption"/> : 
												</font>
												<xsl:if test="$editmode ='edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('signers','false','signedby','frm', 'signedbytbl');</xsl:attribute>								
														<img src="/SharedResources/img/iconset/report_magnify.png"/>			
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="signedbytbl" >
													<tr>
														<td class="td_editable" style="width:600px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/signedby"/>&#xA0;
														</td>
													</tr>
												</table>
												<input type="hidden" id="signedby" name="signedby">
													<xsl:attribute name="value" select="document/fields/signedby/@attrval"/>
												</input>
												<input type="hidden" id="signedbycaption"  value="{document/captions/signedby/@caption}"/>	
											</td>
										</tr>
										<!-- Поле "Внутренние исполнители" 
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/intexec/@caption"/> : 
												</font>
												<xsl:if test="$editmode ='edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','true','intexec','frm', 'intexectbl');</xsl:attribute>								
														<img src="/SharedResources/img/iconset/report_magnify.png"/>			
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="intexectbl">
													<xsl:if test="not(document/fields/intexec/entry)">
														<tr>
															<td class="td_editable" style="width:600px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/intexec"/>&#xA0;
															</td>
														</tr>
													</xsl:if>
													<xsl:for-each select="document/fields/intexec/entry">
														<tr>
															<td class="td_editable" style="width:600px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>&#xA0;
															</td>
														</tr>
													</xsl:for-each>
												</table>
												<xsl:for-each select="document/fields/intexec/entry">
													<input type="hidden" name="intexec" value="{@attrval}"/>
												</xsl:for-each>
												<xsl:if test="not(document/fields/intexec/entry)">
													<input type="hidden" id="intexec" name="intexec" value="{document/fields/intexec/@attrval}"/>
												</xsl:if>
												<input type="hidden" id="intexeccaption" value="{document/fields/intexec/@caption}"/>
											</td>
										</tr>-->
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
										<!--  поле "Проект"   -->
										
										<xsl:if test="not(document/fields/project/@mode = 'hide')">
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/conectedproject/@caption"/> :</td>
												<td>
													<xsl:variable name="project" select="document/fields/project/@attrval"/>
													<select size="1" name="project" style="width:612px;" class="select_editable">
														<xsl:if test="$editmode !='edit'">
															<xsl:attribute name="disabled"/>
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
															<option value="">
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
										<!--  поле "Характер вопроса"  
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/har/@caption"/> :
											</td>
											<td>
												<xsl:variable name="har" select="document/fields/har/@attrval"/>
												<select name="har" class="select_editable" style="width:612px;">
													<xsl:if test="$editmode !='edit'">
														<xsl:attribute name="disabled"/>
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
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
										<!-- Поле "Вид доставки" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/deliverytype/@caption"/> :
											</td>
											<td>
												<select name="deliverytype" style="width:612px;" class="select_editable">
													<xsl:if test="$editmode !='edit'">
						                        		<xsl:attribute name="disabled"/>
						                        		<xsl:attribute name="class">select_noteditable</xsl:attribute>
						                        		<option value="">
															<xsl:attribute name="selected">selected</xsl:attribute>
															<xsl:value-of select="document/fields/deliverytype"/>
														</option>
						                        	</xsl:if>
													<xsl:variable name="deliverytype" select="document/fields/deliverytype/@attrval"/>
													<xsl:for-each select="document/glossaries/deliverytype/query/entry">
														<option value="{@docid}">
															<xsl:if test="$deliverytype = @docid">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="viewcontent/viewtext1"/>
														</option>
													</xsl:for-each>
												</select>	
											</td>
										</tr>
										<!-- Поле "Тип документа" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/vid/@caption"/> :
											</td>
											<td>
												<xsl:variable name="vid" select="document/fields/vid/@attrval"/>
												<select name="vid" class="select_editable" style="width:612px;">
													<xsl:if test="$editmode !='edit'">
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
										<!-- Поле "Язык документа" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/lang/@caption"/> :
											</td>
											<td>
												<select name="lang" class="select_editable" style="width:612px;">
													<xsl:if test="$editmode !='edit'">
						                    			<xsl:attribute name="disabled">disabled</xsl:attribute>
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
														Казахский
													</option>
													<option value="3">
														<xsl:if test="document/fields/lang = '3'">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>
														Казахский,русский
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
										<!-- Поле "Краткое содержание" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/summary/@caption"/> :
											</td>
											<td>
												<textarea name="briefcontent" rows="3" class="textarea_editable" style="width:760px">
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
										<!-- поле "Является ответным на входящий документ" -->
										<!-- <tr>
											<td class="fc">
												<xsl:value-of select="document/captions/vnin/@caption"/> :
											</td>
									       	<td>
						                    	<input type="text" name="vnin" class="td_editable" value="{document/fields/vnin}" style="width:149px;">
						                        	<xsl:attribute name="readonly">readonly</xsl:attribute>
						                        	<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
						                        	<xsl:attribute name="class">td_noteditable</xsl:attribute>
						                        </input>
						                 	</td>   					
										</tr>
										Поле "Ответный входящий документ"
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/backvnish/@caption"/> :
											</td>
							            	<td>
					                      		<input type="text" name="backvnish" value="{document/fields/backvnish}" class="td_noteditable" style="width:149px;">
					                       			<xsl:attribute name="readonly">readonly</xsl:attribute>
					                       			<xsl:attribute name="onfocus">$(this).blur()</xsl:attribute>
					                       			<xsl:attribute name="class">td_noteditable</xsl:attribute>
					                           	</input>
					                       	</td>   					
										</tr> -->
										<!-- Поле "Номер бланка" -->
										<tr>
											<td  class="fc">
												<xsl:value-of select="document/captions/blanknumber/@caption"/> :
											</td>
							            	<td>
					                       		<input type="text" name="blanknumber" value="{document/fields/blanknumber}" style="width:149px;" onkeypress="javascript:Numeric(this)" class="td_editable">
					                       			<xsl:if test="$editmode !='edit'">
					                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
					                           			<xsl:attribute name="class">td_noteditable</xsl:attribute>
					                           			<xsl:attribute name="onfocus">$(this).blur()</xsl:attribute>
					                            	</xsl:if> 
					                           		<xsl:if test="$editmode = 'edit'">
														<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
														<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
													</xsl:if>
					                       		</input>
					                       	</td>   					
										</tr>
										<!-- Поля "количество листов" и "количество экземпляров" -->
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/np/@caption"/><xsl:value-of select="document/fields/np2/@caption"/> :
											</td>
											<td>
												<input type="text" name="np" id="np" value="{document/fields/np}" onkeypress="javascript:Numeric(this)" style="width:62px;" class="td_editable">
													<xsl:if test="$editmode !='edit'">
							                   			<xsl:attribute name="readonly">readonly</xsl:attribute>
							                   			<xsl:attribute name="onfocus">$(this).blur()</xsl:attribute>
							                   			<xsl:attribute name="class">td_noteditable</xsl:attribute>
							                   		</xsl:if>                    			              		
													<xsl:if test="$editmode = 'edit'">
														<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
														<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
													</xsl:if>
												</input>	
												/
												<input type="text" name="np2" value="{document/fields/np2}" style="width:61px;" id="np2" onkeypress="javascript:Numeric(this)" class="td_editable">
													<xsl:if test="$editmode !='edit'">
					                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
					                           			<xsl:attribute name="onfocus">$(this).blur()</xsl:attribute>
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
								<input type="hidden" name="type" value="save"/>
								<input type="hidden" name="id" value="out"/>
								<input type="hidden" name="din" value="{document/fields/din}"/>
								<xsl:if test="document/@status !='new'">
									<input type="hidden" name="key" value="{document/@docid}"/>
									<input type="hidden" name="doctype" value="{document/@doctype}"/>
								</xsl:if>
								<xsl:call-template name="ECPsignFields"/>
								<div id="tabs-2">
									<br/>
									<table width="100%" border="0">
									<!-- Поле "Содержание" -->
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
												<!-- <textarea id="txtDefaultHtmlArea" name="contentsource" cols="125" rows="25">
											 		<script>
														$("#txtDefaultHtmlArea").width("758px");
													</script>
											 		<xsl:value-of select="document/fields/contentsource"/>
												 </textarea> -->
											</td>
										</tr>
									</table>
								</div>
							</form>
							<div id="tabs-3">
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