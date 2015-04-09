<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/page.xsl"/>
	<xsl:variable name="viewtype">Вид</xsl:variable>
    <xsl:variable name="pageid" select="request/@id"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="//query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr class="{@docid}" id="{@docid}{@doctype}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="viewtable_dblclick_open"/>
			<td style="text-align:center; border:1px solid #ccc" width="3%">
				<input type="checkbox" name="chbox" id="{@id}" value="{@doctype}" autocomplete="off">
					<xsl:if test="/request/@id = 'group'">
						<xsl:attribute name="id" select="@docid"/>
					</xsl:if>
				</input>
			</td>
			<td nowrap="nowrap" style="border:1px solid #ccc">
				<div style="display:block; overflow:hidden; width:93%;">&#xA0;
					<a href="{@url}" title="{@viewtext}" class="doclink">
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
                        <xsl:if test="$pageid = 'organizations'">
                            <xsl:attribute name="href">Provider?type=structure&amp;id=organization&amp;key=<xsl:value-of select="@docid"/></xsl:attribute>
                            <xsl:value-of select="viewtext"/>
                        </xsl:if>
                        <xsl:if test="$pageid != 'organizations'">
						    <xsl:value-of select="viewcontent/viewtext1"/>
                        </xsl:if>
					</a>
				</div>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('4MS Structure - ',//captions/title/@caption)"/>
				</title>
				<link type="text/css" rel="stylesheet" href="classic/css/outline.css"/>
				<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.button.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/scrollTo/scrollTo.js"/>
				<script type="text/javascript" src="classic/scripts/outline.js?ver=1"/>
				<script type="text/javascript" src="classic/scripts/view.js?ver=1"/>
				<script type="text/javascript" src="classic/scripts/form.js?ver=1"/>
				<script type="text/javascript" src="classic/scripts/page.js?ver=1"/>
				<script type="text/javascript">
					$(document).ready(function(){
						$(".button_panel button").button();
						$(document).bind('keydown', function(e){
 							if (e.ctrlKey) {
 								switch (e.keyCode) {
								   case 78:
										<!-- клавиша n -->
								     	e.preventDefault();
								     	$("#btnNewdoc").click();
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
    					outline.type = '<xsl:value-of select="@type"/>'; 
						outline.viewid = '<xsl:value-of select="@id"/>';
						outline.element = 'project';
						outline.command='<xsl:value-of select="current/@command"/>';
						outline.curPage = '<xsl:value-of select="current/@page"/>'; 
						outline.category = '';
						outline.filterid = '<xsl:value-of select="@id"/>';
						refresher();  
					});
				<![CDATA[
					$(document).ready(function(){
						$("#btnNewdoc").hotnav({keysource:function(e){ return "n"; }});
						$("#btnDeldoc").hotnav({keysource:function(e){ return "d"; }});
						$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
						$("#logout").hotnav({keysource:function(e){ return "q"; }});
						$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
					});
					]]>
				</script>
			</head>			
			<body>
				<xsl:call-template name="flashentry"/>
				<div id="blockWindow" style="display:none"/>
				<div id="wrapper">
					<xsl:call-template name="loadingpage"/>
					<xsl:call-template name="header-view"/>
					<xsl:call-template name="outline-menu-view"/>
					<span id="view" class="viewframe">
						<div id="viewcontent" style="margin-left:12px;">
							<div id="viewcontent-header" style="height:73px;">
								<xsl:call-template name="viewinfo"/>
								<div class="button_panel" style="margin-top:8px">
									<span style="float:left; margin-left:3px; margin-top:2px">
		                                <xsl:if test="//actionbar/action[. = 'CUSTOM_ACTION']/@mode = 'ON'">
											<button title="{//actionbar/action[. = 'CUSTOM_ACTION']/@caption}" id="btnNewdoc">
												<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select='//actionbar/action[. = "CUSTOM_ACTION"]/@url' />"; beforeOpenDocument()</xsl:attribute>
												<img src="/SharedResources/img/classic/icons/page_white.png" class="button_img"/>
												<font class="button_text"><xsl:value-of select="//actionbar/action[. = 'CUSTOM_ACTION']/@caption"/></font>
											</button>
										</xsl:if>
		                                <xsl:if test="//actionbar/action[. = 'DELETE_DOCUMENT']/@mode = 'ON'">
											<button title="{//captions/btnDelete/@caption}" style="margin-left:5px">
												<xsl:attribute name="onclick">javascript:delDocument();</xsl:attribute>
												<img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img"/>
												<font class="button_text"><xsl:value-of select="//captions/btnDelete/@caption"/></font>
											</button>
										</xsl:if>
									</span>
									<span style="float:right; padding-right:10px;"/>
								</div>
								<div style="clear:both"/>
								<div style="clear:both"/>
							</div>
							<div id="viewtablediv">
								<div id="tableheader" style ="top:75px; position:absolute">
									<table class="viewtable" id="viewtable" width="100%">
										<tr class="th">
											<td style="text-align:center; height:30px" width="3%" class="thcell">
												<input type="checkbox" id="allchbox" onClick="checkAll(this);" autocomplete="off"/>
											</td>
											<td class="thcell">
											    <xsl:value-of select="page/captions/viewtext/@caption"/>
											</td>
										</tr>
									</table>
								</div>
								<div id="tablecontent" style="margin-top:8px">
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