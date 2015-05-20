<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/page.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:variable name="lang" select="request/@lang"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title><xsl:value-of select="page/captions/app_title/@caption" /> - <xsl:call-template name="pagetitle"/></title>
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
					<div id="view" class="viewframe">
						<div id="viewcontent-header" style="  display:block">
							<div class="button_panel" >
								<xsl:if test="//actionbar/action[@id='edit']/@mode =  'ON'">							
									<button title="{//actionbar/action[@id='new_document']/@hint}" id="btnNewdoc" style="margin-left:5px">
										<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select="//actionbar/action[@id='new_document']/@url"/>&amp;parentdocid=<xsl:value-of select="page/view_content/response/content/query/@docid" />"; beforeOpenDocument()</xsl:attribute>
										<img src="/SharedResources/img/iconset/page_white_add.png" class="button_img"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//actionbar/action[@id='new_document']/@caption"/></font>
									</button>
									<button title="{//actionbar/action[@id='edit']/@hint}" id="btnEdit" style="margin-left:5px">
										<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select="page/view_content/response/content/query/url"/>"; beforeOpenDocument()</xsl:attribute>
										<img src="/SharedResources/img/iconset/page_white_edit.png" class="button_img"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//actionbar/action[@id='edit']/@caption"/></font>
									</button>
								</xsl:if>
								<xsl:call-template name="print"/>
								<xsl:call-template name="addToFavs"/>	
							</div>	
							
							<div style="padding-left:10px;font-size:0.9em;margin-top:5px;margin-bottom:10px">
<!-- 								<a href="Provider?type=page&amp;id=articlebycategory&amp;category={page/view_content/response/content/query/category/@id}&amp;page=1" class="links"><xsl:value-of select="page/view_content/response/content/query/category" /></a> -->
								<xsl:apply-templates select="page/view_content/response/content/query/hierarchy"/>
							</div>	
							
							<font style="font-weight:bold;padding-left:10px;font-size:1.3em"><xsl:value-of select="page/view_content/response/content/query/topic" /></font>
						</div>
						<div style="clear:both" />
						<div id="tablecontent" >	
										
							<div id="briefcontent" >
								<span id="briefcontenttext"  />
								<xsl:if test="page/view_content/response/content/query/linked_docs/entry">	
									<br/><b><xsl:value-of select="page/captions/linkeddocs/@caption" />:</b>
									<xsl:for-each select="page/view_content/response/content/query/linked_docs/entry">
										<br/>
										<span style="padding-left:10px">&#8226;&#32;<a  class="links"  href="{@url}"><xsl:value-of select="."/></a></span>
									</xsl:for-each>
								</xsl:if>
							</div>
							 <script>
							 	$("#briefcontenttext").html("<xsl:value-of select='page/view_content/response/content/query/briefcontent' />")
							 </script>
							 
							<div id="support" style="text-align:center;font-size:0.8em;padding-top:5px">
								<a href="http://www.flabs.kz/" class="links"  target="blank"><xsl:value-of select="page/outline/page/captions/support/@caption" /></a>
							</div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="page/view_content/response/content/query/hierarchy">
		 <xsl:apply-templates select="entry"/>
	</xsl:template>
	<xsl:template match="entry">
		<a href="{@url}" class="links"><xsl:value-of select="@viewtext" /></a>
		<xsl:if test="following-sibling::entry">
			<font style="font-size:0.6em"> > </font> 
		</xsl:if>
		
	</xsl:template>
</xsl:stylesheet>