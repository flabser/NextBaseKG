<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="request/history"/>
	<xsl:template match="responses">
		<tr name="child" class="response{entry/@docid}" id="{entry/@docid}{@doctype}">
			<td nowrap="true" id="parentdoccell">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="//viewcontent" mode="line"/>
	<xsl:template match="sorting"/>
	
	
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden; width:99%" id="{concat(@docid,@doctype)}">
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%; font-size:99%">
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:if test="viewcontent/viewtext3 = '0'">
				<img id="control" title="Документ снят с контроля" src="/SharedResources/img/classic/icons/tick.png" border="0" style="margin-left:3px"/>&#xA0;
			</xsl:if>
			<xsl:if test="@hasattach != '0'">
				<img id="atach" src="/SharedResources/img/classic/icons/attach.png" border="0" title="Вложений в документе: {@hasattach}"/>
			</xsl:if>
			<xsl:variable name='simbol'>'</xsl:variable>
			<xsl:variable name='ecr1'><xsl:value-of select="replace(viewcontent/viewtext,$simbol ,'&quot;')"/></xsl:variable>	
			<xsl:variable name='ecr2'><xsl:value-of select="replace($ecr1, '&#34;' ,'&quot;')"/></xsl:variable>	
			<font id="font{@docid}{@doctype}">
				<xsl:value-of select="viewcontent/viewtext"/>
			</font>
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