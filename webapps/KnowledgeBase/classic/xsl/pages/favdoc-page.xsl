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
				<title><xsl:value-of select="//captions/app_title/@caption" /> - <xsl:value-of select="//captions/title/@caption" /></title>
				<xsl:call-template name="cssandscripts" />
			 	<xsl:call-template name="hotkeys"/>
				
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
							<div class="button_panel" style="top:15px; position:absolute; left:0px; right:0px">
								<table style="width:100%; top:30px; position:absolute">
	    							<tr>
	    								<td style="width:40%; padding-left:13px">
											<button id="btnDeldoc" title="{//captions/removefromfavsbutton/@caption}" style="margin-right:5px">
												<xsl:attribute name="onclick">javascript:removeFromFavs()</xsl:attribute>
												<img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img"/>
												<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//captions/removefromfavsbutton/@caption"/></font>
											</button>
										</td>
										<td style="width:50%">
	    								</td>   								
	    							</tr>
	    						</table>	    						
							</div>							
							<div style="clear:both"/>							
						</div>
					<div id="viewtablediv" style ="top:10px">
						<div id="tableheader">
								<table class="viewtable" id="viewtable" width="100%" style="">
									<tr class="th">
										 <td style="text-align:center; height:30px; width:35px;" class="thcell">
											<input type="checkbox" id="allchbox" autocomplete="off" onClick="checkAll(this)"/>					
										</td> 
										<td style="min-width:160px;" class="thcell">
											<xsl:value-of select ="//captions/viewtext/@caption"/>
										</td>
									</tr>
								</table>
							</div>
							<div id="tablecontent" autocomplete="off">							
								<table class="viewtable" id="viewtable" width="100%">								
									<xsl:for-each select="//query/entry">
										<xsl:variable name="num" select="position()"/>
										<tr title="{@viewtext}" class="{@docid}" id="{@docid}{@doctype}">
											 <td style="text-align:center; border:1px solid #ccc; width:35px;">
												<input type="checkbox" name="chbox" id="{@id}" autocomplete="off" value="{@doctype}"/>
											</td>	 
											<td  style="border:1px solid #ccc; min-width:160px;">
												<a href="{@url}" class="doclink" style="margin-left:25px;">
													<xsl:if test="@isread = 0">
														<xsl:attribute name="style">font-weight:bold; padding-left:25px;</xsl:attribute>
													</xsl:if> 
													<xsl:value-of select="viewcontent/viewtext"/>
												</a>
											</td>
											<td style="border:1px solid #ccc; border-left:none; width:30px; text-align:center">
												<img class="favicon" style="cursor:pointer; width:18px; height:18px" src="/SharedResources/img/iconset/star_empty.png">
													<xsl:attribute name ="title"><xsl:value-of select="//captions/removefromfav/@caption"/></xsl:attribute>
													<xsl:if test="@favourites = 1">
														<xsl:attribute name="onclick">javascript:removeDocFromFav(this,<xsl:value-of select="@docid"/>,<xsl:value-of select="@doctype"/>)</xsl:attribute> 
														<xsl:attribute name="src">/SharedResources/img/iconset/star_full.png</xsl:attribute> 
													</xsl:if>
													<xsl:if test="@favourites = 0 or not(@favourites)"> 
														<xsl:attribute name="onclick">javascript:addDocToFav(this,<xsl:value-of select="@docid"/>,<xsl:value-of select="@doctype"/>)</xsl:attribute>
														<xsl:attribute name="src">/SharedResources/img/iconset/star_empty.png</xsl:attribute> 
													</xsl:if>
												</img>
											</td>
										</tr>
									</xsl:for-each>									
								</table>
								<div style="clear:both; width:100%">&#xA0;</div>
							</div>
							<div style="clear:both"/>	
						</div>
						</div>
					</span>
				
				</div>
				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>