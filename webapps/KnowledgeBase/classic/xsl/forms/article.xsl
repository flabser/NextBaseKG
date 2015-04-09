<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype"></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="lang" select="request/@lang"/>
	<xsl:variable name="editmode"><xsl:value-of select="/request/document/@editmode"/></xsl:variable>
	<xsl:template match="/request">
		<html>		
			<head>	
				<title><xsl:value-of select="document/captions/app_title/@caption" /> - <xsl:value-of select="document/fields/title" /></title>
				<!-- load scripts and css link -->
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="hotkeys"/>
				<xsl:call-template name="htmlareaeditor"/>
				<xsl:call-template name="markisread"/>
<!-- 				<xsl:if test="document/@editmode ='edit'"> -->
					<script>
						$(document).ready(function(){
																 
							LoadSubCatList(document.getElementById("category"), "pageload")
						});
						
						function LoadSubCatList(el, actiontype){
						
						 	subcatval = '<xsl:value-of select="document/fields/subcategory/@attrval" />';
						 	cat = el.value;
						 	 
							$("select[name='subcategory'] option").remove();
							$("select[name='subcategory']").append('<option value=""> </option>')	;
							
							<xsl:for-each select="document/glossaries/category/entry">
								if('<xsl:value-of select="@id"/>' == cat){
									<xsl:for-each select="responses/entry"> 
										subcatid = '<xsl:value-of select="@id" />';
										subcatvalue = '<xsl:value-of select='.' />';
										<![CDATA[
											if(actiontype == "pageload" && subcatval == subcatid){									
												$("select[name='subcategory']").append('<option value="'+ subcatid +'" selected="selected">'+ subcatvalue +"</option>");
											}else
												$("select[name='subcategory']").append('<option value="'+subcatid+'">'+ subcatvalue +"</option>");
										]]>
									</xsl:for-each>
								}
							</xsl:for-each>
						} 
					</script>
<!-- 				</xsl:if> -->
			</head>
			<body>
				<xsl:attribute name="onbeforeprint">javascript:$("#htmlcodenoteditable").html($("#txtDefaultHtmlArea").val())</xsl:attribute>
				<xsl:variable name="status" select="@status"/>	
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>
					<div class="formwrapper">
						<div class="formtitle">
						   	<div class="title">
						   		<xsl:value-of select="document/fields/title" />
							</div>
						</div>
						<!-- Сохранить и закрыть -->
						<div class="button_panel">
							<span style="float:left">								
								<xsl:call-template name="save"/>
							</span>
							
							<!-- Закрыть -->
							<span style="float:right; padding-right:15px;">								
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; "/>
						<div style="clear:both"/>
						<div id="tabs">
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded"> 
								<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
									<li class="ui-state-default ui-corner-top">
										<a href="#tabs-1">
											<xsl:value-of select="document/captions/properties/@caption"/>
										</a>										
									</li> 
									<li class="ui-state-default ui-corner-top">
										<a href="#tabs-2"><xsl:value-of select="document/captions/attachments/@caption"/></a>
										<img id="loading_attach_img" style="vertical-align: -8px; margin-left: -10px; padding-right: 3px; visibility: hidden;" src="/SharedResources/img/classic/ajax-loader-small.gif" />
									</li>
									<li class="ui-state-default ui-corner-top">
										<a href="#tabs-3"><xsl:value-of select="document/captions/additional/@caption"/></a>
									</li>
									<xsl:call-template name="docInfo" />
								</ul>							
								
								<div class="ui-tabs-panel" id="tabs-1" >
								
								<div display="block"  id="property" width="100%">									 
									<table width="100%" border="0" style="margin-top:8px">
										<!-- Название статьи -->
										<tr>
											<td class="fc"><font style="vertical-align:top"><xsl:value-of select="document/captions/topic/@caption" />: </font></td>
											<td> 											
												<input type="text" id="topic" name="topic" class="td_editable" style="width:590px">
													<xsl:if test="document/@editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
													</xsl:if>
													<xsl:attribute name="title" select="document/fields/topic/@caption" />
													<xsl:attribute name="value" select="document/fields/topic" />
												</input> 
											</td>
										</tr> 	
										
										<!-- Категория -->
										<tr>
										 	<td  class="fc"><xsl:value-of select="document/captions/category/@caption" />: </td>
											<td colspan="3" >
												<xsl:if test="document/@editmode ='edit'">
													<select size="1" name="category" style="width:600px;" id="category" onchange="javascript:LoadSubCatList(this)" class="select_editable">
														<xsl:variable name="category" select="document/fields/category/@attrval" />
														<xsl:for-each select="document/glossaries/category/entry">
															<option value="{@id}">
																<xsl:if test="$category = @id">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
															    <xsl:value-of  select="@viewtext"/>
															</option>
														</xsl:for-each>
													</select>
												</xsl:if>
												<xsl:if test="document/@editmode !='edit'">
													<div style="width:590px;" class="title">
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
													    <xsl:value-of  select="document/fields/category"/>
													</div>	
												</xsl:if>
											</td>
										</tr>
										
										<!-- Подкатегория -->
										<tr>
										 	<td  class="fc"><xsl:value-of select="document/captions/subcategory/@caption" />: </td>
											<td colspan="3" >
												<xsl:if test="document/@editmode ='edit'">
													<select size="1" name="subcategory" style="width:600px;" id="subcategory" class="select_editable">
														<xsl:variable name="subcategory" select="document/fields/subcategory/@attrval" />
														 <option value="{$subcategory}">
<!-- 															<xsl:if test="$category = @id"> -->
																<xsl:attribute name="selected">selected</xsl:attribute>
<!-- 															</xsl:if> -->
														    <xsl:value-of  select="document/fields/subcategory"/>
														</option>
													</select>
												</xsl:if>
												<xsl:if test="document/@editmode !='edit'">
													<div style="width:590px;" class="title">
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
													    <xsl:value-of  select="document/fields/subcategory"/>&#xA0;
													</div>	
												</xsl:if>
											</td>
										</tr>
										<!-- Краткое содержание -->
										<tr>
											<td class="fc"><xsl:value-of select="document/captions/content/@caption"/> : </td>
											<td>
												<div id="htmlcodenoteditable" class="textarea_noteditable" style="width:610px; height:150px; display:block">
													<xsl:if test="$editmode = 'edit'">
														<xsl:attribute name="style">width:610px; height:150px; display:none</xsl:attribute>
													</xsl:if>
												</div>
												<script>	
													$("#htmlcodenoteditable").html("<xsl:value-of select="document/fields/briefcontent"/>");
												</script>
												<xsl:if test="$editmode = 'edit'">
													<textarea id="txtDefaultHtmlArea" name="briefcontent" cols="93" rows="25" class="ckeditor">
														<xsl:attribute name="onfocus">javascript: $(this).blur()</xsl:attribute>
														<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
														<xsl:value-of select="document/fields/briefcontent"/>
													</textarea>														
												</xsl:if>
												<xsl:if test="$editmode != 'edit'">
													<input type="hidden" name="briefcontent" value="{document/fields/briefcontent}"/>
												</xsl:if>
												<script>
													if($(window).width() > 1200){
														$("#txtDefaultHtmlArea").width("910px").height("350px");
														$("#htmlcodenoteditable").width("910px");	
													}else{
														$("#txtDefaultHtmlArea").width("610px").height("350px");
													}
												</script>
												</td>
										</tr>
										<!-- Читатели-->
										<tr>
											<td class="fc"><font style="vertical-align:top"><xsl:value-of select="document/captions/readers/@caption"/>: 
												<xsl:if test="document/@editmode = 'edit'">
													<a accesskey="3" style="cursor:pointer">
														<xsl:attribute name="onclick">javascript:addMemberGroup('executersandgroups','true','readers','frm', 'readerstbl');</xsl:attribute>								
														<img src="/SharedResources/img/classic/picklist.gif"/>
													</a>
												</xsl:if>
												</font>
											</td>
											<td>
												<table id="readerstbl" width="500px">
													<xsl:for-each select="document/fields/readers/entry[@attrval != '']">
														<tr>
															<td style="border:1px solid #ccc; margin-top:2px" class="td_editable">
																<xsl:value-of select="." />&#xA0;
																<input type="hidden" id="readers" name="readers"> 
																	<xsl:attribute name="value" select="@attrval"/>
																</input>
																<xsl:if test="$editmode='edit'">
																	<img onclick="delmember(this)" src="/SharedResources/img/iconset/cross.png" style="width:15px; height:15px; margin-right:3px; margin-top:1px; float:right; cursor:pointer"/>
																</xsl:if>
															</td>
														</tr>
													</xsl:for-each>
                                                    <xsl:if test="document/@status = 'new'">
                                                        <tr>
                                                            <td style="border:1px solid #ccc; margin-top:2px" class="td_editable">
                                                                [all]&#xA0;
                                                                <input type="hidden" id="readers" name="readers" value="[all]">
                                                                </input>
                                                                <xsl:if test="$editmode='edit'">
                                                                    <img onclick="delmember(this)" src="/SharedResources/img/iconset/cross.png" style="width:15px; height:15px; margin-right:3px; margin-top:1px; float:right; cursor:pointer"/>
                                                                </xsl:if>
                                                            </td>
                                                        </tr>
                                                    </xsl:if>

													<xsl:if test="(count(document/fields/readers/entry)= 1 and document/fields/readers/entry/@attrval = '')">
														<tr>
															<td style="border:1px solid #ccc; margin-top:2px" class="td_editable">
																&#xA0;
															</td>
														</tr>
													</xsl:if>
												</table> 
												<input type="hidden" id="readerscaption" value="{document/captions/readers/@caption}"/>
											</td>
										</tr>	
										<!-- Редакторы -->
										<tr>
											<td class="fc"><font style="vertical-align:top"><xsl:value-of select="document/captions/editors/@caption" />: 
												<xsl:if test="document/@editmode = 'edit'">
													<a style="cursor:pointer">
														<xsl:attribute name="title" select="concat(document/captions/editors/@caption, '')" />
														<xsl:attribute name="onclick">javascript:addMemberGroup('executersandgroups','true','editors','frm', 'editorstbl');</xsl:attribute>								
														<img src="/SharedResources/img/classic/picklist.gif" />
													</a>
												</xsl:if>
												</font>
											</td>
											<td>
												<table id="editorstbl" width="500px">
													<tr>
														<td style="border:1px solid #ccc; margin-top:2px" class="td_editable">
															<xsl:value-of select="document/fields/docauthor" />&#xA0;
															<input type="hidden" id="editors" name="editors"> 
																<xsl:attribute name="value" select="document/fields/docauthor/@attrval"/>
															</input>
														</td>
													</tr>
													<xsl:for-each select="document/fields/editors/entry[@attrval != ''][@attrval != //document/fields/docauthor/@attrval]">
														<tr>
															<td style="border:1px solid #ccc; margin-top:2px" class="td_editable">
																<xsl:value-of select="." />&#xA0;
																<input type="hidden" id="editors" name="editors"> 
																	<xsl:attribute name="value" select="@attrval" />
																</input>
																<xsl:if test="$editmode='edit'">
																	<img onclick="delmember(this)" src="/SharedResources/img/iconset/cross.png" style="width:15px; height:15px; margin-right:3px; margin-top:1px; float:right; cursor:pointer"/>
																</xsl:if>
															</td>
														</tr>
													</xsl:for-each>
													<input type="hidden" id="editorscaption" value="{document/captions/editors/@caption}"/>
												</table> 
											</td>
										</tr>	  						
										</table>
										<input type="hidden" name="type" value="save"/>
										<input type="hidden" name="id" value="{@id}"/>
										<input type="hidden" name="key" value="{document/@docid}"/>
										<input type="hidden" name="doctype" value="{document/@doctype}"/>
										<input type="hidden" name="parentdoctype" value="896"/>
										<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
									</div>
								</div>
								
							</form>	
							<div id="tabs-2">
								<div display="block"  id="property" width="100%">
									<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
										<input type="hidden" name="type" value="rtfcontent"/>
										<input type="hidden" name="formsesid" value="{formsesid}"/> 
										 
										<!-- Секция "Вложения" -->
										<div display="block" id="att" style="width:100%">
											<xsl:call-template name="attach"/>
										</div>
									</form>	
								</div>
							</div>
							<div id="tabs-3">
								<xsl:call-template name="docinfo"/>
<!-- 								<div display="block"  id="property" width="100%"> -->
<!-- 								</div> -->
							</div>
						</div>
					</div>
				</div>
				<!-- Outline -->
				 <xsl:call-template name="formoutline"/>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="lang_splitter">
		<xsl:param name="param"/>&#xA0;
		<xsl:variable name="kaz_part" select="substring-before($param, '/*')" /> 
   		<xsl:variable name="rus_part" select="substring-after($param, '/*')" /> 
		<xsl:choose>
			<xsl:when test="$lang = 'KAZ'">
				<xsl:value-of select="$kaz_part"/>
			</xsl:when>
			<xsl:otherwise>
			 	<xsl:value-of select="$rus_part"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>