<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request/history"/>	
	
	<xsl:template name="indivperson">
		
	</xsl:template>	
		
	<xsl:template match="/request/page[@id = 'executersandgroups']">	
		<xsl:variable name="queryid"><xsl:value-of select="/request/@id"/></xsl:variable>
		<xsl:variable name="lastgroupentry" select="view_content/query/entry[@doctype=900][last()]/viewcontent/viewtext1"/>		
		<xsl:for-each select="view_content/query/entry">
				<div style="display:block; width:100%; text-align:left" name="itemStruct">
					<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
					<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
					<xsl:if test="@doctype = '889'">
						<xsl:attribute name="ondblclick">javascript:addMemberSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
					</xsl:if>						
					<xsl:if test="@doctype = '900'">
						<xsl:attribute name="ondblclick">javascript:addMemberSingleOk('<xsl:value-of select="@docid"/>', '<xsl:value-of select="viewcontent/viewtext1"/>')</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
					<input type="checkbox" name="chbox" id="{@docid}" value="{viewcontent/viewtext1}">
						<xsl:if test="@doctype = '889'">
							 <xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
						</xsl:if>						
						<xsl:if test="@doctype = '900'">
							 <xsl:attribute name="id"><xsl:value-of select="viewcontent/viewtext1"/></xsl:attribute>
						</xsl:if>						
						<font class="font" title="{viewcontent/viewtext1}" style="font-family:verdana; font-size:13px; margin-left:2px">
							<xsl:if test="docid =''">
								<xsl:attribute name="color">gray</xsl:attribute>
							</xsl:if>
                            <xsl:if test="@doctype = '889'">
                                <xsl:value-of select="viewcontent/viewtext"/>
                            </xsl:if>
                            <xsl:if test="@doctype = '900'">
                                <xsl:value-of select="viewcontent/viewtext1"/>
                            </xsl:if>

						</font>
					</input>
				</div>
				<xsl:if test="./viewcontent/viewtext1 = $lastgroupentry">
					<div style="height:1px; background:#dedede; margin:5px 0px"></div>
				</xsl:if>
			</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="/request/query[@ruleid = 'customers']">	
		<xsl:variable name="queryid"><xsl:value-of select="/request/@id"/></xsl:variable>		
			<xsl:for-each select="descendant::entry">				
				<xsl:sort select="@viewtext"/>
				<div style="display:block; width:100%; text-align:left" name="itemStruct">
					<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
					<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
				    <xsl:choose>
				    	<xsl:when test="$queryid = 'executers'">
				    		<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
				    	</xsl:when>
				    	<xsl:otherwise>
				    		<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
				    	</xsl:otherwise>
				    </xsl:choose>						
					<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
					<input type="checkbox" name="chbox" id="{@docid}" value="{viewcontent/viewtext1}">
						<xsl:if test="userid =''">
							<xsl:attribute name="disabled">disabled</xsl:attribute>
						</xsl:if>	
						<xsl:if test="$queryid = 'executers'" >
							 <xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
						</xsl:if>						
						<font class="font" title="{viewcontent/viewtext1}" style="font-family:verdana; font-size:13px; margin-left:2px">
							<xsl:if test="docid =''">
								<xsl:attribute name="color">gray</xsl:attribute>
							</xsl:if> 
							<xsl:value-of select="viewcontent/viewtext1"/>
						</font>
					</input>
				</div>
			</xsl:for-each>
	</xsl:template>
	<xsl:template match="/request/query[@ruleid != 'customers'][@ruleid != 'executersandgroups']">	
		<xsl:variable name="queryid"><xsl:value-of select="/request/@id"/></xsl:variable>		
			<xsl:for-each select="descendant::entry">				
				<xsl:sort select="viewcontent/viewtext1"/>
					<div style="display:block; width:100%; text-align:left" name="itemStruct">
						
						<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
						<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
						
					    <xsl:choose>
					    	<xsl:when test="$queryid = 'executers'">
					    		<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
					    	</xsl:when>
					    	<xsl:otherwise>
					    		<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
					    	</xsl:otherwise>
					    </xsl:choose>						
						
						<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
<!-- 						<input class='chbox' type="hidden" name="chbox1" id="{@id}" value="{@viewtext}"/> -->
						<input type="checkbox" name="chbox" id="{@docid}" value="{viewcontent/viewtext1}">
							<xsl:if test="userid =''">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>	
							<xsl:if test="$queryid = 'executers'" >
								 <xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							</xsl:if>						
							<font class="font" title="{@viewtext}" style="font-family:verdana; font-size:13px; margin-left:2px">
								<xsl:if test="docid =''">
									<xsl:attribute name="color">gray</xsl:attribute>
								</xsl:if> 
								<xsl:value-of select="viewcontent/viewtext1"/>
							</font>
						</input>
					</div>
			</xsl:for-each>
	</xsl:template>
	
	</xsl:stylesheet>