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
		<!-- TODO: Auto-generated template -->
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
					<span id="view" class="viewframe">
						<div id="viewcontent">
							<div id="viewcontent-header" style="  display:block">
								<div class="button_panel" >
									 <button id="btnDeldoc" title="{page/captions/removefromfavsbutton/@caption}" style="margin-right:5px">
										<xsl:attribute name="onclick">javascript:removeFromFavs()</xsl:attribute>
										<img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="page/captions/removefromfavsbutton/@caption"/></font>
									</button>
								</div>	
								<br/>
								<font style="font-weight:bold;padding-left:10px;font-size:1em"><xsl:value-of select="page/outline/page/current_outline_entry/response/content/entry" /></font>						
							</div>
						 	<div id="tablecontent" >				
								<div id="briefcontent"  style="padding-left:5px;padding-top:10px" >
									<xsl:apply-templates select="//query/entry"></xsl:apply-templates>
								</div>
								<div id="support" style="text-align:center;font-size:0.8em;padding-top:5px"><a href="http://www.flabs.kz/"   target="blank"><xsl:value-of select="page/outline/page/captions/support/@caption" /></a></div>
							</div>
						</div>
					</span>
				
				</div>
				
			</body>
		</html>
	</xsl:template>
	<xsl:template match="//query/entry">
		<span>
			<input type="checkbox" name="chbox" id="{@docid}" autocomplete="off" value="{@doctype}"/>&#176; 
		 	<a href="Provider?type=edit&amp;element=document&amp;id=articleview&amp;docid={@id}" title="{viewcontent/viewtext}" class="doclink">
				<xsl:value-of select="viewcontent/viewtext1"/>
			</a>
		</span>	 
		<br/>
	</xsl:template>
</xsl:stylesheet>