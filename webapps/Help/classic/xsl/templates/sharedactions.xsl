<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- кнопка показать xml документ  -->
	<xsl:template name="showxml">
		<xsl:if test="@debug=1">
			<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
				<xsl:attribute name="onclick">javascript:window.location = window.location + '&amp;onlyxml=1'</xsl:attribute>
				<span >
					<img src="/SharedResources/img/iconset/page_code.png" class="button_img"/>
					<font style="font-size:12px; vertical-align:top">XML</font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<!-- кнопка сохранения  -->
	<xsl:template name="save">
		<xsl:if test="document/actionbar/action[@id='save_and_close']/@mode = 'ON'">
			<button title="{document/actionbar/action [@id='save_and_close']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnsavedoc">
				<xsl:attribute name="onclick">javascript:SaveFormJquery('frm','frm','<xsl:value-of select="history/entry[@type eq 'page'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/disk.png" class="button_img"/>
					<font style="font-size:12px; vertical-align:top"><xsl:value-of select="document/actionbar/action [@id='save_and_close']/@caption"/></font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<!--кнопка закрыть-->
	<xsl:template name="cancel">
		<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" title="{document/captions/close/@caption}" id="canceldoc">
			<xsl:attribute name="onclick">javascript:<xsl:value-of select="document/actionbar/action[@id ='close']/js"/></xsl:attribute>
			<img src="/SharedResources/img/iconset/cross.png" class="button_img"/>
			<font style="font-size:12px; vertical-align:top"><xsl:value-of select="document/actionbar/action[@id ='close']/@caption"/></font>
		</button>
	</xsl:template>

	 <xsl:template name="print">
	 	<xsl:if test="//actionbar/action[@id='print']/@mode = 'ON'">
		 	<button style="margin-left:5px" title="{//actionbar/action[@id='print']/@caption}" id="btnPrint">
				<xsl:attribute name="onclick">javascript:window.print();</xsl:attribute>
				<img src="/SharedResources/img/classic/icons/printer.png" class="button_img"/>
				<font style="font-size:12px; vertical-align:top"><xsl:value-of select="//actionbar/action[@id='print']/@caption"/></font>
			</button>
		</xsl:if>
	 </xsl:template>

	 <xsl:template name="addToFavs">
	 	<xsl:if test="//actionbar/action[@id='favs']/@mode = 'ON'">
		 	<button style="margin-left:5px" id="btnFavs">
		 		<xsl:if test="document/fields/favourites = 1">
		 			<xsl:attribute name="title"><xsl:value-of select="document/captions/removefromfav/@caption" /></xsl:attribute>
		 			<xsl:attribute name="onclick">javascript:removeDocFromFav(this,<xsl:value-of select="document/@docid"/>,896)</xsl:attribute>
		 			<img class="button_img">
						<xsl:attribute name="src">/SharedResources/img/iconset/star_full.png</xsl:attribute>
					</img>
		 		</xsl:if>
		 		<xsl:if test="document/fields/favourites = 0">
		 			<xsl:attribute name="onclick">javascript:addDocToFav(this,<xsl:value-of select="document/@docid"/>,896)</xsl:attribute>
		 			<xsl:attribute name="title"><xsl:value-of select="document/captions/addtofav/@caption" /></xsl:attribute>
		 			<img class="button_img">
		 				<xsl:attribute name="src">/SharedResources/img/iconset/star_empty.png</xsl:attribute>
	 				</img>
		 		</xsl:if>
				<font style="font-size:12px; vertical-align:top"/>
			</button>
		</xsl:if>
	 </xsl:template>
</xsl:stylesheet>