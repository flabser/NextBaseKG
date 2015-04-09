<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype"><xsl:value-of select="request/document/captions/title/@caption"/></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes" />
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="lang" select="request/@lang"/>
	<xsl:variable name="editmode"><xsl:value-of select="/request/document/@editmode"/></xsl:variable>
	<xsl:template match="/request">
		<html>
			<head>
				<title><xsl:value-of select="document/captions/title/@caption" /></title>
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="hotkeys"/>
				
			</head>
			<body>
				<xsl:variable name="status" select="document/@status"/>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div class="formtitle">
							<div class="title">
								<xsl:if test="$status = 'new'">
									<xsl:value-of select ="document/captions/title/@caption" />
								</xsl:if>	
								<xsl:if test="$status != 'new'">
									<xsl:value-of select ="document/captions/title/@caption" /> - <xsl:value-of select="document/fields/name" />
									
								</xsl:if> 
							</div>
						</div>
						<div class="button_panel">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="save"/>
								<xsl:if test="@id='category' and document/@status !='new'">
									<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" title="{document/captions/add/@caption}" id="btnaddsubdoc" style="margin-left:5px">
										<xsl:attribute name="onclick">window.location='Provider?type=edit&amp;element=glossary&amp;id=subcategory&amp;key=&amp;parentid=<xsl:value-of select='document/@id' />'</xsl:attribute>
										<span>
											<img src="/SharedResources/img/classic/icons/page_white_add.png" class="button_img"/>
											<font style="font-size:12px; vertical-align:top"><xsl:value-of select="document/captions/add/@caption" /></font>
										</span>
									</button>
								</xsl:if>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div
							style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1">
										<xsl:value-of select="document/captions/properties/@caption"/>
									</a>
								</li>
								<xsl:call-template name="docInfo" />
							</ul>
						
							<div class="ui-tabs-panel" id="tabs-1" >
								<form action="Provider" name="frm" method="post" id="frm"
									enctype="application/x-www-form-urlencoded">
									<div display="block"  id="property">									 
										<table  border="0" style="margin-top:8px">	
										 	<xsl:if test="@id='subcategory'">
												<tr>
												 	<td  class="fc"><xsl:value-of select="document/captions/category/@caption" />: </td>
													<td>
														<xsl:if test="document/@editmode ='edit'">
															<select size="1" name="category" style="width:600px;" id="category" class="select_editable">
																<xsl:variable name="category" select="document/fields/category/@attrval" />
																
																<xsl:for-each select="document/glossaries/category/entry">
																	 <option value="{@id}">
																	 	<xsl:if test="@id = $category">
																			<xsl:attribute name="selected">selected</xsl:attribute>
																		</xsl:if>
																		   <xsl:value-of select="."/>
																	</option>
																</xsl:for-each>
															</select>
														</xsl:if>
														<xsl:if test="document/@editmode !='edit'">
															<div style="width:600px;" class="title">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															   <xsl:value-of select="document/fields/parentglos"/>
															</div>	
														</xsl:if>
													</td>
												</tr> 
											</xsl:if>
											<!-- Название на русском/ Имя -->
											<tr>
												<td class="fc"> <xsl:value-of select="document/captions/name/@caption" />: </td>
												<td>
													<input type="text" name="name" value="{document/fields/name}" size="30" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:600px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:600px</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
												
																				
										</table>
									</div>
									<input type="hidden" name="type" value="save"/>
									<input type="hidden" name="id" value="{@id}"/>
									<input type="hidden" name="key" value="{document/@docid}"/>
									<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
									<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
								</form>
							</div>
						</div>
						<div style="height:10px"/>
					</div>
				</div>
			<!-- Outline -->
				 <xsl:call-template name="formoutline"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>