<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="responses">
		<xsl:apply-templates mode="line"/>
	</xsl:template>
	<xsl:template match="*" mode="line">
		<xsl:if test="name(.) != 'userid'">
			<xsl:if test="@doctype = 889">
				<div style="display:block; width:100%; text-align:left" name="itemStruct">
					<xsl:if test="userid !=''">
						<xsl:attribute name="onclick">selectItem(this)</xsl:attribute>
						<xsl:attribute name="ondblclick">addCoordinator('<xsl:value-of select="userid"/>',this)</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
					<xsl:apply-templates select="." mode="item"/>
				</div>
			</xsl:if>
			<xsl:if test="@doctype = 892">
				<div style="display:block; width:100%; text-align:left" name="itemStruct">
					<xsl:if test="userid !=''">
						<xsl:attribute name="onclick">selectItem(this)</xsl:attribute>
						<xsl:attribute name="ondblclick">addCoordinator('<xsl:value-of select="userid"/>',this)</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
					<xsl:apply-templates select="." mode="item"/>
				</div>
			</xsl:if>
			<xsl:apply-templates mode="line"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="viewtext" mode="line"/>
	
	<xsl:template match="entry" mode="item">
		<input class='chbox' type='hidden' name='chbox' value="{@viewtext}" id="{userid}"/>
		<font class="font" title="{userid}" style="font-family:verdana; font-size:13px; margin-left:2px">
			<xsl:if test="userid =''">
				<xsl:attribute name="color">gray</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="viewtext"/> 
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