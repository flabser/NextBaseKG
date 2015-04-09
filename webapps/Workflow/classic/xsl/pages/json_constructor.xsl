<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:variable name="actionbar" select="//actionbar"/>
	<xsl:variable name="query" select="//query"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="page/view_content/query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr class="{@docid}" id="{@docid}{@doctype}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="viewtable_dblclick_open"/>
			 <td style="text-align:center; border:1px solid #ccc" width="3%" >
				<input type="checkbox" name="chbox" id="{@id}" autocomplete="off" value="{@doctype}"/>
			</td> 
			<xsl:if test ="/request/@id= 'favdocs'">
				<!-- Attachment -->
				<td style="border:1px solid #ccc; width:60px; padding:3px;text-align:center;">
					<table style="width:auto; border-collapse:collapse">
						<tr class="notviewtr">
							<td style="max-width:35px; width:35px; padding-left:3px; text-align:center">
								<xsl:choose>
									<xsl:when test="coordstatus='354'">
										<img id="control" title="Проект был отклонен" src="/SharedResources/img/classic/icons/exclamation.png" style="height:14px; width:14px"/>
									</xsl:when>
									<xsl:when test="coordstatus='356'">
										<img id="control" title="Проект подписан" src="/SharedResources/img/classic/icons/pencil.png" style="height:14px; width:14px"/>
									</xsl:when>
								</xsl:choose>
							</td>
							<td style="width:34px; padding-left:4px;">
								<xsl:if test="@hasattach != 0">
									<img id="atach" src="/SharedResources/img/classic/icons/attach.png" title="Вложений в документе: {@hasattach}"/>
								</xsl:if>
							</td>
						</tr>
					</table>
				</td>
				<!-- Date -->
				<td  style="border:1px solid #ccc; width:160px;">
					<div style="overflow:hidden; width:100%; padding-left:5px">
						<a href="{@url}" class="doclink" style="width:100%; margin-left:5px">
							<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
							<xsl:if test="@isread = '0'">
								<xsl:attribute name="style">font-weight:bold; margin-left:5px</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="viewcontent/viewdate"/>
						</a>
					</div>
				</td>
			</xsl:if>
			<td nowrap="nowrap" style="border:1px solid #ccc">
				<div style="display:block; overflow:hidden; width:93%;">&#xA0;
					<a href="{@url}" title="{@viewtext}" class="doclink">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:if test ="/request/@id = 'favdocs'">
							<xsl:value-of select="viewcontent/viewtext"/>
						</xsl:if>
						<xsl:if test ="/request/@id != 'favdocs'">
							<xsl:value-of select="viewcontent/viewtext1"/>
						</xsl:if>
					</a>
				</div>
			</td>
			<xsl:if test="../@ruleid = 'favdocs'">
				<td  nowrap="nowrap" style="border:1px solid #ccc; border-left:none; width:30px; text-align:center">
					<img class="favicon" style="cursor:pointer; width:19px; height:19px" src="/SharedResources/img/iconset/star_empty.png">
						<xsl:attribute name="onclick">javascript:addDocToFav(this,<xsl:value-of select="@docid"/>,<xsl:value-of select="@doctype"/>)</xsl:attribute>
						<xsl:attribute name="title" select="//page/captions/addtofav/@caption"/>
						<xsl:if test="@favourites = '1'">
							<xsl:attribute name="onclick">javascript:removeDocFromFav(this,<xsl:value-of select="@docid"/>,<xsl:value-of select="@doctype"/>)</xsl:attribute> 
							<xsl:attribute name="src">/SharedResources/img/iconset/star_full.png</xsl:attribute> 
							<xsl:attribute name="title" select="//page/captions/removefromfav/@caption"/>
						</xsl:if>
					</img>
				</td>
			</xsl:if>
		</tr>
	</xsl:template>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					Workflow документооборот - <xsl:value-of select="page/captions/viewnamecaption/@caption"/>
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
				<script type="text/javascript" src="/SharedResources/jquery/js/tiptip/jquery.tipTip.js"/>
				<script type="text/javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="classic/scripts/view.js"/>
				<script type="text/javascript" src="classic/scripts/page.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<script type="text/javascript">
					$(document).ready(function(){
						$(".button_panel button").button()
						<xsl:value-of select="page/dyn_elements/response/content/js"/> 
					});
				</script>
			</head>			
			<body>
				<xsl:call-template name="flashentry"/>
				<div id="blockWindow" style="display:none"/>
				<div id="wrapper">
					<xsl:call-template name="loadingpage"/>
					<xsl:call-template name="header-page"/>
					<div class="button_panel" style="padding:10px">
						<button style="margin-right:5px" title="{$actionbar/action[@id='new_document']/@hint}" id="somebutton">
							<img src="/SharedResources/img/classic/icons/page_white.png" class="button_img"/>
							<font style="font-size:12px; vertical-align:top">
								Выполнить
							</font>
						</button>
						<button style="margin-right:5px" title="{$actionbar/action[@id='new_document']/@hint}" id="somebutton2">
							<img src="/SharedResources/img/classic/icons/page_white.png" class="button_img" />
							<font style="font-size:12px; vertical-align:top">
								Выполнить somebutton2
							</font>
						</button>
					</div>
					<div id="somediv" style="width:500px; height:100px; border:1px solid #ccc; overflow:auto">
						
					</div><br/>
					<div  id="somediv2" style="width:500px; height:100px; border:1px solid #ccc; overflow:auto">
					</div>
				</div>				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>