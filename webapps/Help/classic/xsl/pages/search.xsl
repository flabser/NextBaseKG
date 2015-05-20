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
						<div id="viewcontent-header" style="height:68px; position:relative;">
							<xsl:call-template name="pageinfo"/>
							<div class="button_panel" style="top:15px; position:absolute; left:0px; right:0px">
								<table style="width:100%; top:30px; position:absolute">
	    							<tr>
	    								<td style="width:40%; padding-left:13px">
	    									<xsl:if test="//actionbar/action[@id='custom']/@mode =  'ON'">							
												<button id ="backtodocuments">
													<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select="history/entry[@type = 'page'][last()]"/>";</xsl:attribute>
													<img src="/SharedResources/img/iconset/back_2.png" class="button_img"/>
													<font style="font-size:12px; vertical-align:top">
														<xsl:value-of select="//actionbar/action[@id='custom']/@caption"/>
													</font>
												</button>	
											</xsl:if>
	    								</td>	
	    								<td style="width:50%">
	    								</td>    								
	    							</tr>
	    						</table>	  
							</div>							
							<div style="clear:both"/>							
						</div>
						<div id="viewtablediv" style="top:20px">
							<div id="tableheader" style="top:90px">
								<table class="viewtable" id="viewtable" width="100%" style="">
									<tr class="th">
										<td style="text-align:center;height:30px; width:35px;" class="thcell">
											<input type="checkbox" id="allchbox" autocomplete="off" onClick="checkAll(this)"/>					
										</td>
										<td style="text-align:center;height:30px;width:35px;" class="thcell">
										</td>
										<td style="text-align:center;height:30px;width:35px;" class="thcell">
										<!-- 	<img src="/SharedResources/img/iconset/hslider.png" title="Приоритет заявки"/> -->
										</td>
										<td style="text-align:center;height:30px; width:150px;" class="thcell">
												<xsl:value-of select="page/captions/project/@caption"/>
										</td>
										<td style="min-width:160px;" class="thcell">
											<xsl:value-of select="page/captions/viewtext/@caption"/>	
											<!-- <xsl:call-template name="sortingcell">
												<xsl:with-param name="namefield">VIEWTEXT</xsl:with-param>
												<xsl:with-param name="sortfield" select="page/view_content/query/sorting/field"/>
												<xsl:with-param name="sortorder" select="page/view_content/query/sorting/order"/>
											</xsl:call-template>	 -->
										</td>
										 
										<td style="width:200px;" class="thcell">
											<xsl:value-of select="page/captions/viewdate/@caption"/>
											<!-- <xsl:call-template name="sortingcell">
												<xsl:with-param name="namefield">VIEWDATE</xsl:with-param>
												<xsl:with-param name="sortfield" select="page/view_content/query/sorting/field"/>
												<xsl:with-param name="sortorder" select="page/view_content/query/sorting/order"/>
											</xsl:call-template> -->
										</td>
										<td style="width:50px;" class="thcell">										 
										</td>
									</tr>
								</table>
							</div>
							<div id="tablecontent" style="top:125px" autocomplete="off">							
								<table class="viewtable" id="viewtable" width="100%">								
									<xsl:apply-templates select="//query/entry"/>									
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
	<xsl:template match="//query/entry">
		<xsl:variable name="num" select="position()"/>
		
		<tr title="{@viewtext}" class="{@docid}" id="{@docid}{@doctype}">
			<td style="text-align:center;border:1px solid #ccc;width:35px;">
				<input type="checkbox" name="chbox" id="{@id}" autocomplete="off" value="{@doctype}"/>
			</td>	
			<td style="text-align:right;border:1px solid #ccc;width:34px;">
<!-- 				<xsl:if test="viewcontent/viewtext1 = 'reset'"> -->
<!-- 					<img id="control" title="Документ снят с контроля" src="/SharedResources/img/classic/icons/tick.png" border="0" /> -->
<!-- 				</xsl:if> -->
				<xsl:if test="@hasattach != 0">
					<img id="atach" src="/SharedResources/img/classic/icons/attach.png" title="Вложений в документе: {@hasattach}"/>
				</xsl:if>
			</td>
			<td style="text-align:center ;border:1px solid #ccc; width:35px;">
				<a  href="{@url}" title="{viewcontent/viewtext}" class="doclink">
					<xsl:if test="@isread = 0">
						<xsl:attribute name="style">font-weight:bold;</xsl:attribute>
					</xsl:if> 
					<xsl:value-of select="viewcontent/viewtext3"/>
				</a>
			</td>	
			<td style="text-align:left; border:1px solid #ccc; width:150px; padding-left:10px; word-wrap:break-word">
				<a  href="{@url}" title="{viewcontent/viewtext}" class="doclink">
					<xsl:if test="@isread = 0">
						<xsl:attribute name="style">font-weight:bold;</xsl:attribute>
					</xsl:if> 
					<xsl:value-of select="viewcontent/viewtext2"/>
				</a>
			</td>			  
			<td  style="border:1px solid #ccc; min-width:160px;">								
				<div style="width:100%; overflow:hidden; word-wrap:break-word">
					<xsl:if test="hasresponse='true'">
	       				<xsl:choose>
	       					<xsl:when test=".[responses]">
								<a href="" style="vertical-align:top; margin-right:6px" id="a{@docid}">
									<xsl:attribute name='href'>javascript:closeResponses(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/1/minus.png" id="img{@docid}"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="" style="vertical-align:top; margin-right:6px" id="a{@docid}">
									<xsl:attribute name='href'>javascript:openParentDocView(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/1/plus.png" id="img{@docid}"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="not(hasresponse)">
						<span style="width:22px; display:inline-block"></span>
					</xsl:if>
					<a href="{@url}" title="{viewcontent/viewtext}" class="doclink">
						<xsl:if test="@isread = 0">
							<xsl:attribute name="style">font-weight:bold;</xsl:attribute>
						</xsl:if> 
						<xsl:variable name='simbol'>'</xsl:variable>
						<xsl:variable name='ecr1' select="replace(viewcontent/viewtext,$simbol ,'&quot;')"/>
						<xsl:variable name='ecr2' select="replace($ecr1, '&#34;' ,'&quot;')"/>
						<font id="font{@docid}{@doctype}" >					 
							<script>
								control = '<xsl:value-of select = "viewcontent/viewtext1" />'
								text='<xsl:value-of select="$ecr2"/>';
								symcount= <xsl:value-of select="string-length(@viewtext)"/>;
								ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
		  						replaceVal='<img class="arrow"/>';
		 						text=text.replace("->",replaceVal); 
		 						if(control == 'reset'){
									//text = $(text).find(":").first().after('<img class="control" />')
									replaceControl =': <img height="14" class="control"/>';
		 							text=text.replace(":",replaceControl); 
								} 
								$("#"+ids).html(text);
								$("#"+ids+" > .arrow").attr("src","/SharedResources/img/classic/arrow_blue.gif");
								$("#"+ids+" > .arrow").attr("style","vertical-align:middle");
								$("#"+ids+" > .control").attr("src","/SharedResources/img/classic/icons/tick.png");
								$("#"+ids+" > .control").attr("style","vertical-align:top");
							</script>
						</font>
					</a>
				</div>
			</td>
			<td  style="border:1px solid #ccc; width:160px;">
				<a  href="{@url}" class="doclink" style="padding-left:10px;">
					<xsl:if test="@isread = 0">
						<xsl:attribute name="style">font-weight:bold; padding-left:20px;</xsl:attribute>
					</xsl:if> 
					<xsl:value-of select="viewcontent/viewdate"/>
				</a>
			</td>
			<td style="border:1px solid #ccc; border-left:none; width:30px; text-align:center">
				<img class="favicon" style="cursor:pointer; width:18px; height:18px" src="/SharedResources/img/iconset/star_empty.png">
				<xsl:attribute name ="title"><xsl:value-of select ="//page/captions/addtofav/@caption"></xsl:value-of></xsl:attribute>
					<xsl:if test="@favourites = 1">
						<xsl:attribute name="onclick">javascript:removeDocFromFav(this,<xsl:value-of select="@docid"/>,<xsl:value-of select="@doctype"/>)</xsl:attribute> 
						<xsl:attribute name="src">/SharedResources/img/iconset/star_full.png</xsl:attribute> 
					<xsl:attribute name ="title"><xsl:value-of select ="//page/captions/removefromfav/@caption"></xsl:value-of></xsl:attribute>
					</xsl:if>
					<xsl:if test="@favourites = 0 or not(@favourites)"> 
						<xsl:attribute name="onclick">javascript:addDocToFav(this,<xsl:value-of select="@docid"/>,<xsl:value-of select="@doctype"/>)</xsl:attribute>
						<xsl:attribute name="src">/SharedResources/img/iconset/star_empty.png</xsl:attribute> 
					<xsl:attribute name ="title"><xsl:value-of select ="//page/captions/addtofav/@caption"></xsl:value-of></xsl:attribute>
					</xsl:if>
				</img>
			</td>
		</tr>
		<xsl:apply-templates select="responses"/>
	</xsl:template>
	
	<xsl:template match="responses">
		<tr class="response{../@docid}">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<td/>
			<td/>  
			<td/>  
			<td/>  
			<td colspan="3" nowrap="true">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden; height:22px" id="{@docid}{@doctype}">
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>
	
	<xsl:template match="viewcontent" mode="line"></xsl:template>
	
	<xsl:template match="entry" mode="item">
		<xsl:if test="@form = 'projectDoc'">				
			<xsl:call-template name="viewtable_dblclick_open"/>
			<span style="width:15px;">
				<input type="checkbox" name="chbox" id="{@docid}" value="{@doctype}"/>
			</span>
		</xsl:if>
		<a  href="{@url}" title="{viewcontent/viewtext}" class="doclink" style="font-style:Verdana,​Arial,​Helvetica,​sans-serif; width:100%; font-size:97%; margin-left:2px">
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:if test="@isread = 0">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if> 
			<xsl:if test="@hasattach != 0">
				<img id="atach" src="/SharedResources/img/classic/icons/attach.png" border="0" style="vertical-align:top; margin-left:2px; margin-right:4px">
					<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/></xsl:attribute>
				</img> 
			</xsl:if>			
			<xsl:variable name='simbol'>'</xsl:variable>
			<xsl:variable name='ecr1' select="replace(viewcontent/viewtext,$simbol ,'&quot;')"/>
			<xsl:variable name='ecr2' select="replace($ecr1, '&#34;' ,'&quot;')"/>
			<font id="font{@docid}{@doctype}" style="line-height:19px">
				<script>
					text='<xsl:value-of select="$ecr2"/>';
					symcount= <xsl:value-of select="string-length(@viewtext)"/>;
					ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
					<!-- replaceVal="<img/>";
					text=text.replace("->",replaceVal); -->
					$("#"+ids).text(text);
					$("#"+ids+" > img").attr("src","/SharedResources/img/classic/arrow_blue.gif");
					$("#"+ids+" > img").attr("style","vertical-align:middle");
				</script>
			</font>
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when test="following-sibling::entry">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_tee.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_corner.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="responses" mode="tree"/>

	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::entry and entry[@url]">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="parent::responses">
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:if>
				<xsl:if test="parent::entry">
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>