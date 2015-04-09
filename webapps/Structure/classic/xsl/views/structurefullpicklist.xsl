<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/page.xsl"/>	
	<xsl:variable name="viewtype">Структура</xsl:variable>
	<xsl:output method="html" />
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="responses">
		<tr>
			<xsl:attribute name="class">response<xsl:value-of select="../@docid"/></xsl:attribute>
			<script>
				color=$(".response"+<xsl:value-of select="../@docid"/>).prev().attr("bgcolor");
				$(".response"+<xsl:value-of select="../@docid"/>).css("background",color);
			</script>
			<style type="text/css">
				div.Node * { vertical-align: middle }
			</style>
			<td>
			</td>
			<td colspan="4">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="viewtext" mode="line"/>
	
	<xsl:template match="*" mode="line">
		<xsl:if test="name(.) != 'userid'">	
			<div class="Node" style="height:100%; cursor:pointer;">
				
				<xsl:if test="userid != ''">
					<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
					<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
				
				<xsl:call-template name="graft"/>
				<xsl:apply-templates select="." mode="item"/>
			</div>
			<xsl:apply-templates mode="line"/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<xsl:if test="./descendant::entry">
			<a href="" style="vertical-align:top; margin-left:3px" id="treedep{@docid}{@doctype}">
				<xsl:attribute name='href'>javascript:toggleDepTreeStructure(<xsl:value-of select="count(./descendant::entry)"/>, "close", <xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>)</xsl:attribute>
				<img border='0' src="/SharedResources/img/classic/minus.gif" id="treedepimg{@docid}{@doctype}"/>
			</a>
		</xsl:if>
		<input type="checkbox" name="chbox" class="chbox" style="margin:2px; padding:0px;">
			<xsl:attribute name="id" select="userid"/>
			<xsl:attribute name="value" select="viewtext"/>
			<xsl:if test="not(userid)">
				<xsl:attribute name="onclick">javascript:checkDepInp(this,<xsl:value-of select="count(./descendant::entry)"/>)</xsl:attribute>
			</xsl:if>
		</input>
		<font href="" style="font-style:arial; font-size:12px; margin:0px 2px;">
			<xsl:if test="userid != ''">
				<xsl:attribute name="onclick">javascript:selectItemPicklist(this,event)</xsl:attribute>
				<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="title" select="userid"/>
			<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>	
		</font>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when test="following-sibling::*">
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
			<xsl:when test="following-sibling::* and *[@url]">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="/request">
		<div style="width:100%; text-align:left">
			<xsl:for-each select="query/entry">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
				<a href="" style="vertical-align:1px; margin-left:7px" id="treeorg{@doctype}{@docid}">
					<xsl:attribute name='href'>javascript:toggleOrgTreeStructure(<xsl:value-of select="@doctype"/><xsl:value-of select="@docid"/>)</xsl:attribute>
					<img border='0' src="/SharedResources/img/classic/minus.gif" id="treeorgimg{@doctype}{@docid}"/>
				</a>
				<input type="checkbox" name="chbox" id="">
<!-- 					<xsl:attribute name="id" select="@docid"/> -->
					<xsl:attribute name="value" select="@doctype"/>
					<xsl:attribute name="onclick">checkallOrg(this,<xsl:value-of select="@doctype"/><xsl:value-of select="@docid"/>)</xsl:attribute>
				</input>
				<font style="font-family: Verdana,Arial,Helvetica,sans-serif; font-size:0.9em">
					<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>	
				</font>
				<table class="treetablestructure{@doctype}{@docid}" style="border-collapse:collapse; border:0; font-size:0.85em; text-align:left; width:100%">
					<xsl:apply-templates select="responses"/>
				</table>
				<div style="width:100%; clear:both"/>
			</xsl:for-each>
		</div>
	</xsl:template>
</xsl:stylesheet>