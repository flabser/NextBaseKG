<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:variable name="doctype" select="request/document/captions/organization/@caption"/>
	<xsl:variable name="threaddocid" select="document/@docid" />
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="status" select="request/document/@status"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('4ms Structure - ',document/captions/organization/@caption)"/>
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
                                <xsl:call-template name="adminsave"/>
                                <xsl:if test="//actionbar/action[@id='save_and_close']/@mode='ON'">
                                    <xsl:if test="$status !='new'">
                                        <button title="{document/captions/newdept/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnnewdep" style="margin-left:5px">
                                            <xsl:attribute name="onclick">javascript:window.location.href="Provider?type=structure&amp;id=department&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
                                            <span>
                                                <img src="/SharedResources/img/classic/icons/package_add.png" class="button_img"/>
                                                <font class="button_text"><xsl:value-of select="document/captions/newdept/@caption"/></font>
                                            </span>
                                        </button>
                                        <button title="{document/captions/newemp/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnnewemp" style="margin-left:5px">
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
							</ul>
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
									<div display="block" id="property">
										<br/>
										<table width="100%" border="0">
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/name/@caption"/> :</td>
												<td>
													<input type="text" name="fullname" value="{document/fields/fullname}" size="30" class="td_editable" style="width:600px">
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
													<input type="text" name="shortname" value="{document/fields/shortname}" size="30" class="td_editable" style="width:300px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/bin/@caption"/> :</td>
												<td>
													<input type="text" name="bin" value="{document/fields/bin}" size="30" class="td_editable" autocomplete="off" onkeyup="javascript:validationfield(this)" style="width:300px">
														<xsl:attribute name="title">Поле должно содержать 12 цифр</xsl:attribute>
														<xsl:attribute name="pattern">^\d{12}$</xsl:attribute>
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/adress/@caption"/> :</td>
												<td>
													<input type="text" name="address" value="{document/fields/address}" size="30" class="td_editable" style="width:300px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/mainorg/@caption"/> :</td>
												<td>
													<input type="checkbox" name="mainorg" value="1">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc"><xsl:value-of select="document/captions/comment/@caption"/> :</td>
												<td>
													<textarea class="textarea_editable" rows="4" name="comment" value="{document/fields/comment}" cols="45" style="width:300px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/comment"/>
													</textarea>
												</td>
											</tr>
										</table>
									</div>
									<input type="hidden" name="type" value="save"/>
									<input type="hidden" name="id" value="organization"/>
									<xsl:if test="document/@status != 'new'">
										<input type="hidden" name="key" value="{document/@docid}"/>
									</xsl:if>
									<input type="hidden" name="doctype" value="{document/@doctype}"/>
								</form>
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