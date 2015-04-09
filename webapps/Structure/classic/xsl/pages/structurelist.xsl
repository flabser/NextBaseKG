<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/page.xsl"/>
	<xsl:variable name="viewtype">Структура</xsl:variable>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="responses">
		<tr class="{concat('response',../@docid)}">
			<script>
				color=$(".response"+<xsl:value-of select="../@docid"/>).prev().attr("bgcolor");
				$(".response"+<xsl:value-of select="../@docid"/>).css("background",color);
			</script>
			<style type="text/css">
				div.Node * { vertical-align: middle }
			</style>
			<td>
			</td>
			<td colspan="4">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="viewtext" mode="line"/>
	<xsl:template match="viewtext1" mode="line"/>
	<xsl:template match="viewtext2" mode="line"/>
	<xsl:template match="*" mode="line">
		<xsl:if test="name(.) != 'userid'">	
			<div class="Node" style="height:100%" id="{@docid}{@doctype}">
				<xsl:call-template name="graft"/>
				<xsl:apply-templates select="." mode="item"/>
			</div>
			<xsl:apply-templates mode="line"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<input type="checkbox" name="chbox" style="margin:0px; padding:0px; height:13px" autocomplete="off" id="{@docid}" value="{@doctype}"/>
		<a href="{@url}" style="font-style:arial; font-size:12px; margin:0px 2px;" class="doclink" title="{userid}">
			<xsl:if test="viewtext2 = '-1'">
				<xsl:attribute name="style">font-style:arial; font-size:12px; margin:0px 2px; text-decoration:line-through !important</xsl:attribute>
			</xsl:if>
			<xsl:if test="@doctype = '888'">
				<xsl:attribute name="style">font-style:arial; font-size:17px; margin:-2px 2px; line-height:17px; vertical-align:-1px</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>	
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_corner.gif">
			<xsl:if test="following-sibling::entry">
				<xsl:attribute name="src" select="'/SharedResources/img/classic/tree_tee.gif'"/>
			</xsl:if>
		</img>
	</xsl:template>
		
	<xsl:template match="responses" mode="tree"/>

	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::* and *[@url]">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:otherwise>
		</xsl:choose>
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
				<script type="text/javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="classic/scripts/view.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
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
							$("#btnQFilter").hotnav({keysource:function(e){ return "f"; }});
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
					<div id='loadingpage' style='position:absolute; display:none'>
						<script>
							lt = ($(document).height() - 80 )/2;
							ll = ($(window).width() - 80 )/2;
							$("#loadingpage").css("top",lt);
							$("#loadingpage").css("left",ll );
							$("#loadingpage").css("z-index",1);
						</script>
						<img src='/SharedResources/img/classic/4(4).gif'/>
					</div>	
					<xsl:call-template name="header-view"/>
					<xsl:call-template name="outline-menu-view"/>					
					<span id="view" class="viewframe">
						<div id="viewcontent" style="margin-left:12px;">
							<div id="viewcontent-header" style="height:30px;">
						    	<xsl:call-template name="viewinfo"/>
								<div class="button_panel" style="margin-top:10px">
									<span style="float:left; margin-left:3px;">
		                                <xsl:if test="//actionbar/action[. = 'CUSTOM_ACTION']/@mode = 'ON'">
		                                    <button title="{//actionbar/action[. = 'CUSTOM_ACTION']/@hint}" id="btnNewdoc">
		                                        <xsl:attribute name="onclick">javascript:window.location.href="Provider?type=structure&amp;id=organization&amp;key="; beforeOpenDocument()</xsl:attribute>
		                                        <img src="/SharedResources/img/classic/icons/page_white.png" class="button_img"/>
		                                        <font class="button_text"><xsl:value-of select="//actionbar/action[. = 'CUSTOM_ACTION']/@caption"/></font>
		                                    </button>
		                                </xsl:if>
		                                <xsl:if test="//actionbar/action[. = 'DELETE_DOCUMENT']/@mode = 'ON'">
		                                    <button style="margin-left:5px" title="{//actionbar/action[. = 'DELETE_DOCUMENT']/@hint}" id="btnDeldoc">
		                                        <xsl:attribute name="onclick">javascript:delGlossary("Avanti","1");</xsl:attribute>
		                                        <img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img"/>
		                                        <font class="button_text"><xsl:value-of select="//actionbar/action[. = 'DELETE_DOCUMENT']/@caption"/></font>
		                                    </button>
		                                </xsl:if>
									</span>
								</div>
							</div>
							<div id="viewtablediv">
								<div id="tableheader" style ="top:75px; position:absolute">
									<table class="viewtable" id="viewtable" width="100%">
										<tr class="th">
											<td style="text-align:center; height:30px" width="3%" class="thcell">
												<input type="checkbox" id="allchbox" onClick="checkAll(this);" autocomplete="off"/>
											</td>
											<td class="thcell"/>
										</tr>
									</table>
								</div>
								<div id="tablecontent-for-structurelist"  style="margin-top:80px">
									<div style ="margin-left:5px">
										<xsl:for-each select="//query/entry">
											<xsl:sort select="@viewtext"/>
											<input type="checkbox" name="chbox" autocomplete="off" id="{@docid}" value="{@doctype}"/>
											<font style="font-family:Verdana,Arial,Helvetica,sans-serif; font-size:1em">
												<a href="{@url}" class="doclink">
													<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>	
												</a>
											</font>
											<table id="viewtable" style="border-collapse:collapse; border:0; font-size:0.85em">
												<xsl:apply-templates select="responses"/>
											</table>
											<br/>
										</xsl:for-each>
									</div>
									<div style="clear:both; width:100%">&#xA0;</div>
								</div>
							</div>
		 				</div>
					</span>
				</div>
				<div id="viewcontent" style="margin-left:15px;">
					<div id="viewcontent-header" style="height:50px">
						<font class="viewtitle">
							<xsl:value-of select="//captions/title/@caption"/> - <xsl:value-of select="captions/view/@caption"/>
						</font>
						<br/>
						<br/>
					</div>
					<br/>
					<br/>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>