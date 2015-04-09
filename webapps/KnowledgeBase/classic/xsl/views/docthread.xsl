<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="ruleID" select="request/@id"/>
	<xsl:template match="request/history"/>
	
	<xsl:template match="responses"> 
		<xsl:value-of select="$ruleID" />			 
		<tr name="child" class="response{entry/@docid}" id="{entry/@docid}{@doctype}">
			<td/>
			<td  nowrap="true" id="parentdoccell{entry/@docid}" style="padding-left:9px">
				<script>
					docid='<xsl:value-of select="entry/@docid" />'
					parentTrCountCell=$("#parentdoccell"+docid).parent("tr").prev("tr").children("td").length;
					$("#parentdoccell"+docid).attr("colspan",parentTrCountCell-1);
				</script>
				<xsl:apply-templates mode="line"/>						
			</td>
		</tr> 
	</xsl:template>

	<xsl:template match="viewtext" mode="line"/>
	 
	
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden; width:99%" id="{@docid}{@doctype}">
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%; font-size:99%">
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			
			<xsl:if test="@hasattach != 0">
				<img id="atach" src="/SharedResources/img/classic/icons/attach.png" border="0" title="Вложений в документе: {@hasattach}"/>
			</xsl:if>
			<xsl:value-of select="."/>
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when  test="following-sibling::entry">
				<img style="vertical-align:top" src="/SharedResources/img/classic/tree_tee.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img style="vertical-align:top" src="/SharedResources/img/classic/tree_corner.gif"/>
			</xsl:otherwise>
		</xsl:choose>
		<span style="width:15px;">
			<input type="checkbox" name="chbox" id="{@docid}" value="{@doctype}"/>
		</span>
	</xsl:template>
	
	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::entry and entry[@url]">
				<img style="vertical-align:top" src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img style="vertical-align:top" src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	 
</xsl:stylesheet>