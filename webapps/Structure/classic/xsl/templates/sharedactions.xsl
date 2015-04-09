<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- кнопка показать xml документ  -->
	<xsl:template name="showxml">
		<xsl:if test="@debug=1">
			<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
				<xsl:attribute name="onclick">javascript:window.location = window.location + '&amp;onlyxml=1'</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_code.png" class="button_img"/>
					<font class="button_text">XML</font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<!-- кнопка сохранения  -->
	<xsl:template name="save">
		<xsl:if test="document/actions/action [.='SAVE']/@enable = 'true'">
			<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnsavedoc">
				<xsl:attribute name="onclick">javascript:SaveFormJquery('frm','frm','<xsl:value-of select="history/entry[@type eq 'view'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/disk.png" class="button_img"/>
					<font class="button_text"><xsl:value-of select="document/actions/action [.='SAVE']/@caption"/></font>
				</span>
			</button>
		</xsl:if>
			
	</xsl:template>
	
	<!--кнопка закрыть-->
	<xsl:template name="cancel">
		<button title ="{document/captions/close/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="canceldoc">
			<xsl:attribute name="onclick">javascript:CancelForm(&quot;<xsl:value-of select="history/entry[@type eq 'page'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>&quot;,&quot;<xsl:value-of select="document/fields/grandparform"/>&quot;)</xsl:attribute>
			<span>
				<img src="/SharedResources/img/classic/icons/cross.png" class="button_img"/>
				<font class="button_text"><xsl:value-of select="document/captions/close/@caption"/></font>
			</span>
		</button>
	</xsl:template>
	
	<xsl:template name="cancelwithjson">
		<button title ="{document/captions/close/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="canceldoc">
			<xsl:attribute name="onclick">javascript:<xsl:value-of select="document/actionbar/action[@id = 'close']/js"/></xsl:attribute>
			<span>
				<img src="/SharedResources/img/classic/icons/cross.png" class="button_img"/>
				<font class="button_text"><xsl:value-of select="document/captions/close/@caption"/></font>
			</span>
		</button>
	</xsl:template>
    <xsl:template name="adminsave">
        <xsl:if test="//actionbar/action[@id='save_and_close']/@mode='ON'">
            <button title ="{document/captions/saveclose/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnsavedoc">
                <xsl:attribute name="onclick">javascript:SaveFormJquery(&quot;<xsl:value-of select="history/entry[@type eq 'page'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>&quot;)</xsl:attribute>
                <span>
                    <img src="/SharedResources/img/classic/icons/disk.png" class="button_img"/>
                    <font class="button_text"><xsl:value-of select="document/captions/saveclose/@caption"/></font>
                </span>
            </button>
        </xsl:if>
    </xsl:template>
	<xsl:template name="ECPsign">
	<!--  	<xsl:if test="document/@sign != '1'">
			<button>
				<xsl:attribute name="onclick">edsApp.sign('<xsl:value-of select="@id"/>', this); return false;</xsl:attribute>
				<img src="/SharedResources/img/iconset/page_edit.png" class="button_img"/>
				<font style="font-size:12px; vertical-align:top">Добавить ЭЦП</font>
			</button>
		</xsl:if>-->
	</xsl:template>
</xsl:stylesheet>