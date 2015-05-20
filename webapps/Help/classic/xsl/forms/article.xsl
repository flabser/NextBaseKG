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
				<title><xsl:value-of select="document/captions/app_title/@caption" /> - <xsl:value-of select="document/captions/formtitle/@caption" /></title>
				<!-- load scripts and css link -->
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="hotkeys"/>
				<xsl:call-template name="htmlareaeditor"/>
				<xsl:call-template name="markisread"/>
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
									<xsl:call-template name="docInfo" />
								</ul>							
								
								<div class="ui-tabs-panel" id="tabs-1" >
								
								<div display="block"  id="property" width="100%">									 
									<table width="100%" border="0" style="margin-top:8px">
										<!-- Категория -->
										<tr>
										 	<td  class="fc"><xsl:value-of select="document/captions/category/@caption" />: </td>
											<td colspan="3" >
												<xsl:if test="document/@editmode ='edit'">
													<select size="1" name="category" style="width:600px;" id="category" class="select_editable">
														<xsl:variable name="category" select="document/fields/category/@attrval" />
														<xsl:for-each select="document/glossaries/category/entry">
															<option value="{@id}">
																<xsl:if test="$category = @id">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
															    <xsl:value-of  select="."/>
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
										<!-- Название проекта -->
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
										<!-- Краткое содержание -->
										<tr>
											<td class="fc"><xsl:value-of select="document/captions/content/@caption"/> : </td>
                                            <td>
                                                <xsl:if test="$editmode = 'edit'">
                                                    <textarea id="MyTextarea" name="briefcontent">
                                                        <xsl:if test="@useragent = 'ANDROID'">
                                                            <xsl:attribute name="style">width:500px; height:300px</xsl:attribute>
                                                        </xsl:if>
                                                        <xsl:value-of select="document/fields/briefcontent"/>
                                                    </textarea>
                                                </xsl:if>
                                                <xsl:if test="$editmode != 'edit'">
                                                    <div id="briefcontent">
                                                        <xsl:attribute name="style">width:500px; height:300px; background:#EEEEEE; padding: 3px 5px; overflow-x:auto</xsl:attribute>
                                                        <script>
                                                            $("#briefcontent").html("<xsl:value-of select='document/fields/briefcontent'/>")
                                                        </script>
                                                    </div>
                                                    <input type="hidden" name="briefcontent" value="{document/fields/briefcontent}"/>
                                                </xsl:if>
                                            </td>
										</tr>
										 
										<!-- Связанные документы -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top"><xsl:value-of select="document/captions/linked_docs/@caption"/>: </font>
													<xsl:if test="$editmode = 'edit'">
													<a accesskey="3" class="picklist-button">
														<xsl:attribute name="title" select="concat(document/captions/linked_docs/@caption,'')" />
														<xsl:attribute name="onclick">javascript:dialogBoxStructure('articlelist','true','linked_docs','frm', 'articletbl');</xsl:attribute>								
														<img src="/SharedResources/img/classic/picklist.gif" />
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="articletbl" >
													<xsl:for-each select="document/fields/linked_docs/entry">
														<tr>
															<td  style="border:1px solid #ccc;width:600px" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>
															</td>
															<td>
																<a target='blank' href='{@url}'><img src='/SharedResources/img/iconset/world_go.png' /></a>
															</td>
														</tr>
													</xsl:for-each>
													
												</table> 
												 
											</td>
										</tr>	
										<!-- Комментарий   -->
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/linked_docs_comment/@caption" />: 
												</font>
											</td>
											<td> 	 									
												<textarea  id="linked_docs_comment" name="linked_docs_comment" class="td_editable" style="max-width:590px; width:590px;height:50px">
													<xsl:if test="document/@editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="class">td_noteditable</xsl:attribute>
													</xsl:if>
													<xsl:attribute name="title" select="document/fields/linked_docs_comment/@caption" />
													<xsl:value-of select="document/fields/linked_docs_comment/entry" />
												</textarea> 											 
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