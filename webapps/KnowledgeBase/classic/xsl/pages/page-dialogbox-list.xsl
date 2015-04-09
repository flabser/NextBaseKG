<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request/history"/>	
	
	<xsl:template name="list"></xsl:template>	
	
	<xsl:template match="/request[@id = 'project-list']">
		<xsl:for-each select="page/script_result/response/content/project">	
			<div style="display:block; width:100%; text-align:left" name="itemStruct">
				<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
				<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
	    		<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="milestone/@docid"/>')</xsl:attribute>
				<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
				<input class='projectinfo' type="hidden" name="{@docid}" id="{@id}" value="{@name}"/> 
				<input type="checkbox" name="chbox" id="{milestone/@docid}" value="{@name}#`{@url}#`{milestone}#`{milestone/@url}">
					<xsl:if test="userid =''">
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>	
					<font class="font" title="{@name}" style="font-family:verdana; font-size:13px; margin-left:2px">
						<xsl:if test="docid =''">
							<xsl:attribute name="color">gray</xsl:attribute>
						</xsl:if> 
						<xsl:value-of select="@name"/>
					</font>
				</input>
			</div>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>