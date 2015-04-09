<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:variable name="actionbar" select="//actionbar"/>
	<xsl:variable name="query" select="//query"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr class="{@docid}" id="{@docid}{@doctype}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="viewtable_dblclick_open"/>
			<td style="text-align:center; border:1px solid #ccc" width="3%" >
				<input type="checkbox" name="chbox" id="{@docid}" autocomplete="off" value="{@doctype}"/>
			</td>
			<td nowrap="nowrap" style="border:1px solid #ccc">
				<div style="overflow:hidden; width:99%;">&#xA0;
					<a href="{@url}" title="{@viewtext}" class="doclink">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="@viewtext"/>
					</a>
				</div>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Workflow документооборот - ', page/captions/recyclebin/@caption)"/>
				</title>
				<link type="text/css" rel="stylesheet" href="classic/css/outline.css"/>
				<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.widget.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.core.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.effects.core.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.mouse.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.draggable.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.position.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.button.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.dialog.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/scrollTo/scrollTo.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/tiptip/jquery.tipTip.js"/>
				<script type="text/javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="classic/scripts/view.js"/>
				<script type="text/javascript" src="classic/scripts/page.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<script type="text/javascript">
					$(document).ready(function(){
						$(".button_panel button").button();
						hotkeysnav();
					})
					function hotkeysnav(){
						$(document).bind('keydown', function(e){
 							if (e.ctrlKey) {
 								switch (e.keyCode) {
								   case 74:
										<!-- клавиша j -->
								     	e.preventDefault();
								     	$("#restore").click();
								     	break;
								   case 68:
								   		<!-- клавиша d -->
								     	e.preventDefault();
								     	$("#btnDeldoc").click();
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
    					$("#restore .ui-button-text").hotnav({keysource:function(e){return "j";}});
						$("#btnDeldoc .ui-button-text").hotnav({keysource:function(e){return "d";}});
						$("#currentuser").hotnav({ keysource:function(e){return "u";}});
						$("#logout").hotnav({keysource:function(e){return "q";}});
						$("#helpbtn").hotnav({keysource:function(e){return "h";}});
					}
				</script>
			</head>			
			<body>
				<xsl:call-template name="flashentry"/>
				<div id="blockWindow" style="display:none"/>
				<div id="wrapper">
					<xsl:call-template name="loadingpage"/>
					<xsl:call-template name="header-page"/>
					<xsl:call-template name="outline-menu-page"/>
					<span id="view" class="viewframe{outline/category[entry[@current=1]]/@id}">
						<div id="viewcontent" style="margin-left:12px;">
							<div id="viewcontent-header" style="height:73px;">
								<xsl:call-template name="pageinfo"/>
								<div class="button_panel" style="margin-top:8px">
									<span style="float:left; margin-left:3px; margin-top:2px">
										<xsl:if test="$actionbar/action[@id='RECOVER_RECYCLEBIN']/@mode = 'ON'">
											<button style="margin-right:5px" title="{//action[@id='RECOVER_RECYCLEBIN']/@hint}" id="restore">
												<xsl:attribute name="onclick">javascript:undelGlossary("Avanti");</xsl:attribute>
												<img src="/SharedResources/img/classic/icons/page_white_database.png" class="button_img"/>
												<font class="button_text"><xsl:value-of select="//action[@id='RECOVER_RECYCLEBIN']/@caption"/></font>
											</button>
										</xsl:if>
										<xsl:if test="$actionbar/action[@id='CLEAR_RECYCLEBIN']/@mode = 'ON'">
											<button style="margin-right:5px" title="{//action[@id='CLEAR_RECYCLEBIN']/@hint}" id="btnDeldoc">
												<xsl:attribute name="onclick">javascript:delDocument();</xsl:attribute>
												<img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img"/>
												<font class="button_text"><xsl:value-of select="//action[@id='CLEAR_RECYCLEBIN']/@caption"/></font>
											</button>
										</xsl:if>
									</span>
									<span style="float:right; padding-right:10px;"/>
								</div>
								<div style="clear:both"/>
								<div style="clear:both"/>
							</div>
							<div id="viewtablediv">
								<div id="tableheader">
									<table class="viewtable" id="viewtable" width="100%">
										<tr class="th">
											<td style="text-align:center; height:30px" width="3%" class="thcell">
												<input type="checkbox" id="allchbox" autocomplete="off" onClick="checkAll(this);"/>					
											</td>
											<td class="thcell">
												<xsl:value-of select="page/captions/name/@caption"/>
											</td>
										</tr>
									</table>
								</div>
								<div id="tablecontent" style="top:108px; position:absolute">
									<table class="viewtable" id="viewtable" width="100%">
										<xsl:apply-templates select="//query/entry"/>
									</table>
									<div style="clear:both; width:100%">&#xA0;</div>
								</div>
							</div>
		 				</div>
					</span>
				</div>				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>