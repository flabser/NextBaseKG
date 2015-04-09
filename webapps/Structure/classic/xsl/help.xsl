<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:template match="/request/history">
	</xsl:template>
	<xsl:template match="/request/content">
		<html style="overflow:auto">
			<head>
				<title>Справка</title>
				<script language="javascript" src="classic/scripts/form.js"/>
				<link rel="stylesheet" href="classic/css/actionbar.css"/>
				<link rel="stylesheet" href="classic/css/form.css"/>
				<link rel="stylesheet" href="classic/css/outline.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.slider.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.progressbar.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.autocomplete.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.tabs.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.button.js"/>
				<script type="text/javascript">    
					$(function(){
						$("button").button();
					});
    			</script>
			</head>
			<body style="font-family: Verdana, arial, helvetica, sans-serif; padding:0px; margin:0px">
				<div  style="position:absolute;  top:0px; left:0px; width:100%; height:70px; border-bottom:1px solid rgba(190,213,224,0.89); background:url('classic/img/yellow_background.jpg');">
				    <span style="float:left">
						<img alt="" src ="classic/img/structure-logo.png" style="margin:5px 5px 0px 10px"/>
						<font style="font-size:1.5em; vertical-align:15px; color:#555555">4MS Structure </font>
					</span>
					<span style="float:right; padding:5px 5px 5px 0px" >
						<a id="currentuser" target="_parent" title="Посмотреть свойства текущего пользователя" href=" Provider?type=edit&amp;element=userprofile&amp;id=userprofile" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
							<font><xsl:value-of select="/request/@username"/></font>
						</a>
						<a target="_parent" href="Logout" id="logout" title="{outline/fields/logout/@caption}" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
							<font style="margin-left:15px;"><xsl:value-of select="captions/logout/@caption"/></font> 
						</a>
						<a target="_parent" id="helpbtn" href="Provider?type=page&amp;id=help_summary" title="Помощь" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
							<font style="margin-left:15px;"><xsl:value-of select="captions/helpcaption/@caption"/></font> 
						</a>
					</span>				
				</div>
				<div style="width:100%; position:absolute; top:80px;">
					<button style="float:right; margin-right:5px">
						<xsl:attribute name="onclick">javascript:window.history.back()</xsl:attribute>
						<img src="/SharedResources/img/iconset/cross.png" class="button_img" style="width:16px; vertical-align:top"/>
						<font style="font-size:12px; margin-left:5px; vertical-align:7px">Закрыть</font>
					</button>
				</div>
				<div class="help_bar" style="margin:380px auto 0px; width:500px; text-align:center">
					<font style="color:#444; font-size:18px">Страница помощи временно недоступна</font>
					<!-- <span style="margin-left:5px">
						<b>Категория :</b>
						<xsl:value-of select="content/category"/>
						<button style="float:right">
							<xsl:attribute name="onclick">javascript:CancelForm(&quot;<xsl:value-of select="/request/history/entry[@type eq 'view'][last()]"/>&quot;)</xsl:attribute>
							<img src="/SharedResources/img/iconset/cross.png" class="button_img" style="width:16px; vertical-align:top"/>
							<font style="font-size:12px; margin-left:5px; vertical-align:7px">Закрыть</font>
						</button>
					</span>  -->
				</div>
				<div style="font-family:verdana; margin-top:100px">
					<xsl:for-each select="content/*">
						<xsl:choose>
							<xsl:when test="name() = 'topic'">
								<div style="font-family:verdana; font-size:15pt; text-align:left; width:80%; margin-top:15px; margin-left:5px">
									<b><xsl:value-of select="."/></b>
									<br/>
								</div>
							</xsl:when>
							<xsl:when test="name() = 'image'">
								<br/>
								<center>
									<img name="helpimg" src="{.}" style="margin-left:35px; width:65%; border: 1px solid black"/>
								</center>
								<br/>
							</xsl:when>
							<xsl:when test="name() = 'imagetitle'">
								<br/>
								<center>
									<b style="font-size:13px">
										<xsl:value-of select="."/>
									</b>
								</center>
								<br/>
							</xsl:when>
							<xsl:when test="name() = 'chapter'">
								<div style="font-family:verdana; font-size:14px; text-align:left; width:90%; margin-top:10px; margin-left:35px">
									<xsl:value-of select="."/>
								</div>
							</xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<hr color="#d3d3d3" style="position:absolute; bottom:50px; width:100%; right:1px"/>
					<table>
						<xsl:for-each select="seealso">
							<tr>
								<td width="10%">
									<a href="{.}">
										<xsl:value-of select="."/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<table width="80%" border="0" style="margin-top:8px; font-size:10.8pt;">
						<xsl:for-each select="glossary/link2">
							<tr>
								<td width="10%">
									<a href="{substring-after(.,'$')}">
										<xsl:value-of select="substring-before(.,'$')"/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>