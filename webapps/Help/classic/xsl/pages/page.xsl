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
	<xsl:variable name="editaction" select="request/page/outline/page/action_bar/response/content/actionbar/action[@id='edit']/@mode"/>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title><xsl:value-of select="page/captions/app_title/@caption" /> | <xsl:call-template name="pagetitle"/></title>
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
								<xsl:if test="//actionbar/action[@id='edit']/@mode =  'ON' and /request/@id != 'search'">							
									<button title="{//actionbar/action[@id='new_document']/@hint}" id="btnNewdoc" style="margin-left:5px">
										<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select="//actionbar/action[@id='new_document']/@url"/>"; beforeOpenDocument()</xsl:attribute>
										<img src="/SharedResources/img/iconset/page_white_add.png" class="button_img"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//actionbar/action[@id='new_document']/@caption"/></font>
									</button>
									<button style="margin-left:5px" title="{//actionbar/action[. ='DELETE_DOCUMENT']/@hint}" id="btnDeldoc">
										<xsl:attribute name="onclick">javascript:delDocument();</xsl:attribute>
										<img src="/SharedResources/img/iconset/page_white_delete.png" class="button_img"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//actionbar/action[. ='DELETE_DOCUMENT']/@caption"/></font>
									</button>	
								</xsl:if>
								<xsl:call-template name="print"/>
<!-- 								<xsl:call-template name="addToFavs"/>		 -->
							</div>	
							<br/>
							<font style="font-weight:bold;padding-left:10px;font-size:1.3em"><xsl:value-of select="page/outline/page/current_outline_entry/response/content/entry" /></font>						
						</div>
						<div style="clear:both" />
						<div id="tablecontent" >				
							<div id="briefcontent"  style="padding-left:20px" >
								<xsl:apply-templates select="//query/entry"></xsl:apply-templates>
							</div>
							<div id="support" style="text-align:center;font-size:0.8em;padding-top:5px"><a href="http://www.flabs.kz/"   target="blank"><xsl:value-of select="page/outline/page/captions/support/@caption" /></a></div>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="//query/entry">
		<div>
			<xsl:if test="$editaction = 'ON'">
 				<input type="checkbox" name="chbox" id="{@id}" autocomplete="off" value="{@doctype}"/>
 			</xsl:if>&#176; 
		 	<a href="Provider?type=edit&amp;element=document&amp;id=articleview&amp;docid={@id}" title="{@viewtext}" class="doclink">
<!-- 				<xsl:choose> -->
<!-- 					<xsl:when test="/request/@id='search'"> -->
<!-- 						<xsl:value-of select="viewcontent/viewtext"/> -->
<!-- 					</xsl:when> -->
<!-- 					<xsl:otherwise> -->
						<xsl:value-of select="@viewtext"/>
<!-- 					</xsl:otherwise> -->
<!-- 				</xsl:choose> -->
				
			</a>
		</div>	 
		<xsl:apply-templates select="entry"/>
		 
	</xsl:template>
	
	<xsl:template match="responses">
		<xsl:apply-templates select="entry"/>
	</xsl:template>
	
	<xsl:template match="entry">
		<div style="padding-left:15px">
			<xsl:if test="$editaction = 'ON'">
				<input type="checkbox" name="chbox" id="{@id}" autocomplete="off" value="{@doctype}"/>
			</xsl:if>&#176; 
		 	<a href="Provider?type=edit&amp;element=document&amp;id=articleview&amp;docid={@id}" title="{@viewtext}" class="doclink">
				<xsl:value-of select="@viewtext"/>
			</a>
			<xsl:apply-templates select="entry"/>
	  </div>
	</xsl:template>
</xsl:stylesheet>