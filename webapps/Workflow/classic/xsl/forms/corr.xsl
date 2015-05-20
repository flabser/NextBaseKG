<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:variable name="doctype" select="request/document/captions/corresp/@caption"/>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin" />
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
								<xsl:call-template name="doctitleGlossary"/>
							</div>
						</div>
						<div class="button_panel">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="save"/>
								<xsl:if test="document/actionbar/action[@id='add_addressee']/@mode = 'ON'">
									<button title ="{document/actionbar/action[@id='add_addressee']//@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnnewkr" style="margin-right:5px" autocomplete="off">
										<xsl:attribute name="onclick">javascript:window.location.href="Provider?type=edit&amp;element=glossary&amp;id=addressee&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
										<span>
											<img src="/SharedResources/img/classic/icons/page_white_add.png" class="button_img"/>
											<font class="button_text"><xsl:value-of select="document/actionbar/action [@id='add_addressee']/@caption"/></font>
										</span>
									</button>
								</xsl:if>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancel"/>
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
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-2">
										<xsl:value-of select="document/captions/integration/@caption"/>
									</a>
								</li>
							</ul>
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div class="ui-tabs-panel" id="tabs-1">
										<div display="block" id="property">
											<br/>
											<table width="80%" border="0">
												<tr>
													<td width="30%" class="fc"><xsl:value-of select="document/captions/name/@caption"/> :</td>
													<td>
														<input type="text" name="name" value="{document/fields/name}" size="50" class="td_editable" style="width:600px">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
												<tr>
													<td width="30%" class="fc"><xsl:value-of select="document/captions/shortname/@caption"/> :</td>
													<td>
														<input type="text" name="shortname" value="{document/fields/shortname}" size="50" class="td_editable" style="width:300px">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
												<tr>
													<td class="fc"><xsl:value-of select="document/captions/code/@caption"/> :</td>
													<td>
														<input type="text" name="code" id="code" value="{document/fields/code}" size="10" class="td_editable" style="width:300px">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:attribute name="onkeydown">javascript:numericfield(this)</xsl:attribute>
														</input>
													</td>
												</tr>
												<tr>
													<td width="30%" class="fc"><xsl:value-of select="document/captions/category/@caption"/> :</td>
													<td>
														<select name="corrcat" class="select_editable" style="width:310px">
															<xsl:attribute name="onchange">javascript:setValHiddenFields(this)</xsl:attribute>
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
																<xsl:attribute name="class">select_noteditable</xsl:attribute>
															</xsl:if>
															<script>
																$(document).ready(function(){setValHiddenFields($("[name=corrcat]"))});
															</script>
															<xsl:variable name="corrcat" select="document/captions/corrcat/@caption"/>
															<xsl:for-each select="document/glossaries/corrcatlist/query/entry">
																<option value="{@docid}">
																	<xsl:if test="$corrcat=@docid">
																		<xsl:attribute name="selected">selected</xsl:attribute>
																	</xsl:if>
																	<xsl:value-of select="viewcontent/viewtext1"/>
																</option>
															</xsl:for-each>
														</select>
													</td>
												</tr>
											</table>
										</div>
										<input type="hidden" name="type" value="save"/>
										<input type="hidden" name="parentdocid" value="{document/fields/corrcat/@attrval}"/>
										<input type="hidden" name="parentdoctype" value="894"/>
										<input type="hidden" name="id" value="corr"/>
										<input type="hidden" name="key" value="{document/@docid}"/>
								</div>
								<div id="tabs-2">
										<div display="block" id="property">
											<br/>
											<table width="80%" border="0">
												<tr>
													<td width="30%" class="fc"><xsl:value-of select="document/captions/typeofintegration/@caption"/> :</td>
													<td>
														<table>
												<tr>
													<td>
														<input type="radio" name="typeofintegration" value="0" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/typeofintegration = '0'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:if test="$status  = 'new'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/captions/notused/@caption"/>
														</input>
													</td>
												</tr>
												<tr>
													<td>
														<input type="radio" name="typeofintegration" value="1" autocomplete="off">
															<xsl:if test="$editmode !='edit'">
																<xsl:attribute name="disabled">disabled</xsl:attribute>
															</xsl:if>
															<xsl:if test="document/fields/typeofintegration = '1'">
																<xsl:attribute name="checked">checked</xsl:attribute>
															</xsl:if>
															XML &amp; SMTP
														</input>
													</td>
												</tr>
											</table>
													</td>
												</tr>
												<tr>
													<td width="30%" class="fc"><xsl:value-of select="document/captions/corrid/@caption"/> :</td>
													<td>
														<input type="text" name="corrid" value="{document/fields/corrid}" size="50" class="td_editable" style="width:300px">
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
														<input type="text" name="email" id="email" value="{document/fields/email}" size="10" class="td_editable" style="width:300px">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
														</input>
													</td>
												</tr>
											</table>
										</div>
								</div>
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