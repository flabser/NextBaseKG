<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/page.xsl"/>
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:variable name="lang" select="request/@lang"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title><xsl:value-of select="//captions/app_title/@caption" /> - <xsl:call-template name="pagetitle"/></title>
				<xsl:call-template name="cssandscripts" />
			 	<xsl:call-template name="hotkeys" />
			</head>
			<body>
				<xsl:call-template name="flashentry"/>
				<div id="blockWindow" style="display:none"/>
				<div id="wrapper">	
					<div id='loadingpage' style='position:absolute; display:none'>
						<script>
							lw = $("#loadingpage").width();
							lh = $("#loadingpage").height();
							lt = ($(window).height() - lh )/2;
							ll = ($(window).width() - lw )/2;
							$("#loadingpage").css("top",lt);
							$("#loadingpage").css("left",ll + 95);
							$("#loadingpage").css("z-index",1);
						</script>
						<img src='/SharedResources/img/classic/4(4).gif'/>
					</div>	
					<xsl:call-template name="header-view"/>			
					<xsl:call-template name="outline-menu-view"/>
					<span id="view" class="viewframe">
						<div id="viewcontent">
						<div id="viewcontent-header" style="height:68px; position:relative;">
							<xsl:call-template name="pageinfo"/>
							<div class="button_panel" style="margin-top:8px">
								<span style="float:left; margin-left:15px; margin-top:2px">
									<xsl:if test="//action[@id='RECOVER_RECYCLEBIN']/@mode = 'ON'">
										<button style="margin-right:5px" title="{//action[@id='RECOVER_RECYCLEBIN']/@hint}" id="restore">
											<xsl:attribute name="onclick">javascript:undelGlossary("KnowledgeBase");</xsl:attribute>
											<img src="/SharedResources/img/classic/icons/page_white_database.png" class="button_img"/>
											<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//action[@id='RECOVER_RECYCLEBIN']/@caption"/></font>
										</button>
									</xsl:if>
									<xsl:if test="//action[@id='CLEAR_RECYCLEBIN']/@mode = 'ON'">
										<button style="margin-right:5px" title="{//action[@id='CLEAR_RECYCLEBIN']/@hint}" id="btnDeldoc">
											<xsl:attribute name="onclick">delDocumentCompletely();</xsl:attribute>
											<img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img"/>
											<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//action[@id='CLEAR_RECYCLEBIN']/@caption"/></font>
										</button>
									</xsl:if>
								</span>
								<span style="float:right; padding-right:10px;">
								</span>
							</div>						
							<div style="clear:both"/>
							<div id="QFilter" style="width:auto; background: #eeeeee; border:1px solid #ccc; border-bottom:none; height:25px; margin-top:5px; margin-left:2px; display:none; position:absolute; top:83px; right:0px; left:12px">
								<xsl:if test="@useragent != 'IE'">
									<xsl:attribute name="style">width:auto; background: #eeeeee; border:1px solid #ccc; height:25px; border-bottom:none; margin-top:3px; margin-left:2px; display:none; position:absolute; top:83px; right:0px; left:12px</xsl:attribute>
								</xsl:if>
								<xsl:if test="query/filtered/condition[fieldname != ''][value != '0']">
									<xsl:attribute name="style">width:auto; background: #eeeeee; border:1px solid #ccc; height:25px; margin-top:5px; display:block;margin-left:2px;</xsl:attribute>
									<xsl:if test="@useragent != 'IE'">
										<xsl:attribute name="style">width:auto; background: #eeeeee; border:1px solid #ccc; height:25px; margin-top:3px;  display:block;margin-left:2px;</xsl:attribute>
									</xsl:if>
								</xsl:if>
							</div>						
						</div>
						<div id="viewtablediv">
						<div id="tableheader">
							<table class="viewtable" id="viewtable" width="100%">
								<tr class="th">
									<td style="text-align:center; height:30px" width="35px" class="thcell">
										<input type="checkbox" id="allchbox" autocomplete="off" onClick="checkAll(this);"/>					
									</td>
									<td class="thcell">
										<xsl:value-of select="//captions/name/@caption"/>
									</td>
								</tr>
							</table>
						</div>
						<div id="tablecontent" style="top:118px; position:absolute">
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
	
	<xsl:template match="query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr class="{@docid}" id="{@docid}{@doctype}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="viewtable_dblclick_open"/>
			<td style="text-align:center; border:1px solid #ccc" width="35px" >
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
	
</xsl:stylesheet>