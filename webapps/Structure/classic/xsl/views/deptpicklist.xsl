<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="responses">
		<xsl:apply-templates mode="line"/>
	</xsl:template>
	<xsl:template match="*" mode="line">
		<xsl:if test="name(.) = 'entry' ">	
			<xsl:if test="@doctype = 888">
				<div style="display:block; width:100%; text-align:left" name="itemStruct">
					<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
					<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
					<xsl:attribute name="onclick">javascript:selectItemPicklist(this,event)</xsl:attribute>
					<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
					<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
					<xsl:apply-templates select="." mode="item"/>
				</div>
			</xsl:if>
			<xsl:apply-templates mode="line"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<input class='chbox' type='hidden' name='chbox' id="{@docid}" value="{@viewtext}"/>
		<input type="checkbox" name="chbox" value="{@viewtext}" id="{@docid}">
			<xsl:if test="userid =''">
				<xsl:attribute name="disabled">disabled</xsl:attribute>
			</xsl:if>
		</input>	
		<font class="font"  style="font-family:verdana; font-size:13px; margin-left:2px">
			<xsl:value-of select="@viewtext"/> 
		</font>
	</xsl:template>
	
	<xsl:template match="/request">
		<span width='100%' id='picklistCoorder'>
			<xsl:for-each select="query/entry">
				<xsl:apply-templates select="responses"/>
			</xsl:for-each>
		</span>
	</xsl:template>
</xsl:stylesheet>