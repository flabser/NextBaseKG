<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="request/history"/>
	<xsl:template match="category">
		<table class="viewtable" id="viewtable" width="100%">
		<xsl:for-each select="entry"> 
			<xsl:variable name="num" select="position()"/>
			<tr title="{@viewtext}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')" class="{@docid}" id="{@docid}{@doctype}">
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
				<td style="text-align:center;border:1px solid #ccc;width:20px;">
					<input type="checkbox" name="chbox" id="{@docid}" value="{@doctype}"/>
				</td>
				<td style="border:1px solid #ccc;width:45px;">
					<span style="float:right">
						<xsl:if test="allcontrol = 0">
							&#xA0;
							<img id="control" title="Документ снят с контроля" src="/SharedResources/img/classic/icons/tick.png" border="0"/>
						</xsl:if>
						<xsl:if test="@hasattach != 0">
							&#xA0;
							<img id="atach" src="/SharedResources/img/classic/icons/attach.png" border="0" title="Вложений в документе: {@hasattach}"/>
						</xsl:if>
					</span>
				</td>
				<td nowrap="nowrap" style="border:1px solid #ccc;width:65px;">
					<div style="overflow:hidden; width:99%;">
						<xsl:if test="hasresponse='true' and //request/@id!='toconsider'">
	          				<xsl:choose>
	          					<xsl:when test=".[responses]">
									<a href="" style="vertical-align:top; margin-left:3px" id="a{@docid}">
										<xsl:attribute name='href'>javascript:closeResponses(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
										<img border='0' src="/SharedResources/img/classic/1/minus.png" id="img{@docid}"/>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<a href="" style="vertical-align:top; margin-left:3px" id="a{@docid}">
										<xsl:attribute name='href'>javascript:openParentDocView(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
										<img border='0' src="/SharedResources/img/classic/1/plus.png" id="img{@docid}"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="not(hasresponse)">
							<span style="width:11px; display:inline-block">&#xA0;</span>
						</xsl:if>
						<a class="doclink" style="padding-left:5px;" href="{@url}" title="{@viewtext}">
							<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
							<xsl:if test="@isread = '0'">
								<xsl:attribute name="style">font-weight:bold;padding-left:5px</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="viewcontent/viewnumber"/>
						</a>
					</div>
				</td>
				<td nowrap="nowrap" style="border:1px solid #ccc;width:100px;">
					<div style="overflow:hidden; width:99%;">&#xA0;
						<a href="{@url}" class="doclink" style="width:100%">
							<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
							<xsl:if test="@isread = '0'">
								<xsl:attribute name="style">font-weight:bold;</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="viewcontent/viewdate"/>
						</a>
					</div>
				</td>
				<td nowrap="nowrap" style="border:1px solid #ccc;width:280px;">
					<div style="overflow:hidden; width:99%;">&#xA0;
						<a href="{@url}" class="doclink">
							<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
							<xsl:if test="@isread = '0'">
								<xsl:attribute name="style">font-weight:bold</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="viewcontent/viewtext1"/>
						</a>
					</div>
				</td>
				<td nowrap="nowrap" style="border:1px solid #ccc;min-width:250px;">
					<div style="display:block;overflow:hidden;max-height:2.3em;width:99%;" title="{viewcontent/viewtext2}">
						<a href="{@url}" class="doclink">
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
		</xsl:for-each>
		</table>
	</xsl:template>
	
	<xsl:template match="query/entry[@doctype !=887]">
		<xsl:variable name="num" select="position()"/>
		<tr title="{@viewtext}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')" class="{@docid}" id="{@docid}{@doctype}">
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
			<td style="text-align:center;border:1px solid #ccc;width:20px;">
				<input type="checkbox" name="chbox" id="{@docid}" value="{@doctype}"/>
			</td>
			<td style="border:1px solid #ccc;width:45px;">
				<span style="float:right">
					<xsl:if test="allcontrol = 0">
						&#xA0;
						<img id="control" title="Документ снят с контроля" src="/SharedResources/img/classic/icons/tick.png" border="0"/>
					</xsl:if>
					<xsl:if test="@hasattach != 0">
						&#xA0;
						<img id="atach" src="/SharedResources/img/classic/icons/attach.png" border="0" title="Вложений в документе: {@hasattach}"/>
					</xsl:if>
				</span>
			</td>
			<td nowrap="nowrap" style="border:1px solid #ccc;width:65px;">
				<div style="overflow:hidden; width:99%;">
					<xsl:if test="hasresponse='true' and //request/@id!='toconsider'">
          				<xsl:choose>
          					<xsl:when test=".[responses]">
								<a href="" style="vertical-align:top; margin-left:3px" id="a{@docid}">
									<xsl:attribute name='href'>javascript:closeResponses(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/1/minus.png" id="img{@docid}"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="" style="vertical-align:top; margin-left:3px" id="a{@docid}">
									<xsl:attribute name='href'>javascript:openParentDocView(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/1/plus.png" id="img{@docid}"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<xsl:if test="not(hasresponse)">
						<span style="width:11px; display:inline-block">&#xA0;</span>
					</xsl:if>
					<a class="doclink" style="padding-left:5px;" href="{@url}" title="{@viewtext}">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold;padding-left:5px</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewnumber"/>
					</a>
				</div>
			</td>
			<td nowrap="nowrap" style="border:1px solid #ccc;width:100px;">
				<div style="overflow:hidden; width:99%;">&#xA0;
					<a href="{@url}" class="doclink" style="width:100%">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold;</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewdate"/>
					</a>
				</div>
			</td>
			<td nowrap="nowrap" style="border:1px solid #ccc;width:280px;">
				<div style="overflow:hidden; width:99%;">&#xA0;
					<a href="{@url}" class="doclink">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewtext1"/>
					</a>
				</div>
			</td>
			<td nowrap="nowrap" style="border:1px solid #ccc;min-width:250px;">
				<div style="display:block;overflow:hidden;max-height:2.3em;width:99%;" title="{viewcontent/viewtext2}">
					<a href="{@url}" class="doclink">
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
				<img id="control" title="Документ снят с контроля" src="/SharedResources/img/classic/icons/tick.png" border="0" style="margin-left:3px"/>&#xA0;
			</xsl:if>
			<xsl:if test="@hasattach != 0">
				<img id="atach" src="/SharedResources/img/classic/icons/attach.gif" border="0" style="vertical-align:top">
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
	
</xsl:stylesheet>