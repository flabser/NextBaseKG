<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')" class="{@docid}" id="{@docid}{@doctype}">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<script>
				$("."+<xsl:value-of select="@docid"/>).dblclick( function(event){
	  				if (event.target.nodeName != "INPUT" &amp;&amp; event.target.nodeName != "IMG"){
	  					beforeOpenDocument();
	  					window.location = '<xsl:value-of select="@url"/>'
	  				}
				});
			</script>
			<td style="text-align:center; border:1px solid #ccc" width="3%">
				<input type="checkbox" name="chbox" id="{@docid}" value="{@doctype}"/>
			</td>
			<td width="5%" style="border:1px solid #ccc">
				<span style="float:right">
					<xsl:if test="allcontrol = 0">
						&#xA0;
						<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0"/>
					</xsl:if>
					<xsl:if test="@hasattach != 0">
						&#xA0;
						<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0" title="Вложений в документе: {@hasattach}"/>
					</xsl:if>
				</span>
			</td>
			<td width="5%" nowrap="nowrap" style="border:1px solid #ccc;">
				<div style="overflow:hidden; width:99%;">
					<xsl:if test="hasresponse='true' and //request/@id!='toconsider'">
          				<xsl:choose>
          					<xsl:when test=".[responses]">
								<a href="" style="vertical-align:top; margin-left:3px" id="a{@docid}">
									<xsl:attribute name='href'>javascript:closeResponses(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/minus.gif" id="img{@docid}"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="" style="vertical-align:top; margin-left:3px" id="a{@docid}">
									<xsl:attribute name='href'>javascript:openParentDocView(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/plus.gif" id="a{@docid}"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="not(hasresponse)">
						<div style="width:11px; display:inline-block">&#xA0;</div>
					</xsl:if>
					<a class="doclink" style="font-style:arial; width:100%; margin-left:5px" href="{@url}" title="{@viewtext}">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewnumber"/>
					</a>
				</div>
			</td>
			<td width="15%" nowrap="nowrap" style="border:1px solid #ccc">
				<div  style="overflow:hidden; width:99%;">&#xA0;
					<a  href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewdate"/>
					</a>
				</div>
			</td>
			<td width="47%" nowrap="nowrap" style="border:1px solid #ccc">
				<div style="overflow:hidden; width:99%;">&#xA0;
					<a href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewtext1"/>
					</a>
				</div>
			</td>
			<td width="25%" nowrap="nowrap" style="border:1px solid #ccc">
				<div  style="overflow:hidden; width:99%;">&#xA0;
					<a href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewtext2"/>
					</a>
				</div>
			</td>
		</tr>
		<xsl:apply-templates select="responses"/>
	</xsl:template>
	
	<xsl:template match="responses">
		<tr class="response{../@docid}">
			<script>
				color=$(".response"+<xsl:value-of select="../@docid"/>).prev().attr("bgcolor");
			 	$(".response"+<xsl:value-of select="../@docid"/>).css("background",color);
			</script>
			<td style="width:3%"/>
			<td style="width:5%"/>
			<td colspan="4" nowrap="true">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="viewtext" mode="line"/>
	
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden;" id="{@docid}{@doctype}">
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a  href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%; font-size:99%">
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:if test="@isread = 0">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:if test="@allcontrol = 0">
				<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0" style="margin-left:3px"/>&#xA0;
			</xsl:if>
			<xsl:if test="@hasattach != 0">
				<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0" style="vertical-align:top">
					<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/></xsl:attribute>
				</img> 
			</xsl:if>
			<xsl:variable name='simbol'>'</xsl:variable>
			<xsl:variable name='ecr1' select="replace(viewtext,$simbol ,'&quot;')"/>
			<xsl:variable name='ecr2' select="replace($ecr1, '&#34;' ,'&quot;')"/>
			<font id="font{@docid}{@doctype}">
				<script>
					text='<xsl:value-of select="$ecr2"/>';
					symcount= <xsl:value-of select="string-length(@viewtext)"/>;
					ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
					replaceVal="<img/>";
					text=text.replace("-->",replaceVal);
					$("#"+ids).html(text);
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
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>Мои задания</title>		
				<link rel="stylesheet" href="classic/css/outline.css"/>	
				<script language="javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
			</head>			
			<body>
				<xsl:variable name="path" select="@skin"/>
				<xsl:if test="query/@flashdocid !=''">
					<script type="text/javascript">
						$("document").ready(
							function() {
								flashentry(<xsl:value-of select="query/@flashdocid"/><xsl:value-of select="query/@flashdoctype"/>);
							}
						);
					</script>
				</xsl:if>
				<input type="hidden" id="langinput" value="{@lang}"/>
				<div id="viewcontent" style="margin-left:12px;">
					<div id="viewcontent-header" style="height:112px;">
						<xsl:call-template name="refreshstat"/>	
						<xsl:call-template name="viewinfo"/>
						<div class="button_panel">
							<script type="text/javascript">    
					       		$(function() {
									$( ".button_panel button" ).button();
			        			});
    						</script>
							<span style="float:left; margin-left:3px; margin-top:2px">
								<xsl:if test="action[.='NEW_DOCUMENT']/@enable = 'true'">
									<button>
										<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select="newDocURL"/>"; beforeOpenDocument()</xsl:attribute>
										<img src="/SharedResources/img/iconset/document_empty.png" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="action[.='NEW_DOCUMENT']/@caption"/></font>
									</button>
								</xsl:if>
								<xsl:if test="action[.='DELETE_DOCUMENT']/@enable = 'true'">
									<button>
										<xsl:attribute name="onclick">javascript:delGlossary("Avanti","glossary");</xsl:attribute>
										<img src="/SharedResources/img/classic/remove.gif" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="columns/column[@id = 'BTNDELETEDOCUMENT']/@caption"/></font>
									</button>
								</xsl:if>
								<xsl:if test="action[.='DELETE_GLOSSARY']/@enable = 'true'">
									<button>
										<xsl:attribute name="onclick">javascript:delGlossary("Avanti","glossary");</xsl:attribute>
										<img src="/SharedResources/img/classic/remove.gif" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"/>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="columns/column[@id = 'BTNDELETE']/@caption"/></font>
									</button>
								</xsl:if>
							</span>
							<!--  <span style="float:right; padding-right:10px; padding-top:5px">
									<xsl:call-template name="search"/>
								</span>-->
						</div>
						<div style="clear:both"/>
					</div>
					<div id="viewtablediv">
						<div id="tableheader">
							<table class="viewtable" id="viewtable" width="100%">
								<tr class="th">
									<xsl:if test="query/@ruleid = 'report_tasks'">
										<td style="text-align:center; height:30px" width="3%" class="thcell">
											<input type="checkbox" id="allchbox" onClick="checkAll(this)"/>					
										</td>
										<td style="text-align:center; height:30px" class="thcell">
											Название
										</td>
									</xsl:if>
									<xsl:if test="query/@ruleid != 'report_tasks'">
										<td style="text-align:center; height:30px"   width="3%" class="thcell">
											<input type="checkbox" id="allchbox" onClick="checkAll(this)"/>					
										</td>
										<td width="5%"  class="thcell"></td>
										<td width="5%" class="thcell">
											<xsl:call-template name="sortingcell">
												<xsl:with-param name="namefield">VIEWNUMBER</xsl:with-param>
												<xsl:with-param name="sortfield" select="query/sorting/field"/>
												<xsl:with-param name="sortorder" select="query/sorting/order"/>
											</xsl:call-template>
										</td>
										<td  width="15%" class="thcell">
											<xsl:call-template name="sortingcell">
												<xsl:with-param name="namefield">VIEWDATE</xsl:with-param>
												<xsl:with-param name="sortfield" select="query/sorting/field"/>
												<xsl:with-param name="sortorder" select="query/sorting/order"/>
											</xsl:call-template>
										</td>
										<td  width="47%" class="thcell">
											<xsl:call-template name="sortingcell">
												<xsl:with-param name="namefield">VIEWTEXT1</xsl:with-param>
												<xsl:with-param name="sortfield" select="query/sorting/field"/>
												<xsl:with-param name="sortorder" select="query/sorting/order"/>
											</xsl:call-template>
										</td>
										<td  width="25%" class="thcell">
											<xsl:call-template name="sortingcell">
												<xsl:with-param name="namefield">VIEWTEXT2</xsl:with-param>
												<xsl:with-param name="sortfield" select="query/sorting/field"/>
												<xsl:with-param name="sortorder" select="query/sorting/order"/>
											</xsl:call-template>
										</td>
									</xsl:if>
								</tr>
							</table>
						</div>
						<div id="tablecontent">
							<table class="viewtable" id="viewtable" width="100%">
								<xsl:if test="query/@ruleid != 'report_tasks'">
									<xsl:apply-templates select="query/entry"/>
								</xsl:if>
								<xsl:if test="query/@ruleid = 'report_tasks'">
									<tr onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
										<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
										<td style="text-align:center; border:1px solid #ccc" width="3%" >
											<input type="checkbox" name="chbox"/>
										</td>
										<td style="border:1px solid #ccc" width="92%">
											&#xA0;&#xA0;<a href="Provider?type=document&amp;id=task_report&amp;key=">Задания</a>
										</td>
									</tr>
								</xsl:if>
							</table>
							<div style="clear:both; width:100%">&#xA0;</div>
						</div>
					</div>
		 		</div>		
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>