<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	 doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request/content">
		<html>
			<head>
				<title><xsl:value-of select="content/org"/> - 4ms workflow</title>
				<link rel="stylesheet" href="classic/css/start.css"/>
				<script type="text/javascript" src="classic/scripts/start.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<link type="text/css" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" rel="stylesheet"/>
			</head>
			<body onKeyDown="key(event)">
				<div id="wrapper">
					<div id="leftdiv"/>
					<div id="rightdiv">
						<div id="header">
							<div style="width:400px; margin:120px auto 40px; text-align:center">
								<img src="/SharedResources/logos/{content/img}"/>
								<br/>
									<font class="sh"><xsl:value-of select="captions/documentmanager/@caption"/>&#xA0;<xsl:value-of select="content/org"/></font>
								</div>
							</div>
							<div id="authfields">	
								<form action="Login" method="post" id="frm" name="form">
									<xsl:if test="../@userid = 'anonymous'">
										<table style="width:320px; margin:0px auto">
											<tr>
												<td style="width:140px; text-align:right">
													<font class="sh" style="font-size:10.2pt">
														<xsl:value-of select="captions/user/@caption"/> :
													</font>
												</td>
												<td>
													<input type="text" name="login" id="login" value="" style="width:185px; height: 16px; padding: 3px 3px 3px 5px;"/>
												</td>
											</tr>
											<tr>
												<td style="width:140px; text-align:right">
													<font class="sh" style="font-size:10.2pt">
														<xsl:value-of select="captions/password/@caption"/> :
													</font>
												</td>
												<td>
													<input type="password" name="pwd" value="" id="pwd" style="width:185px; margin-top:7px; height: 16px; padding: 3px 3px 3px 5px;"/>
												</td>
											</tr>
											<tr>
												<td style="width:200px;">
												</td>
												<td>
													<input type="checkbox" id="cbx" name="noauth" style="margin-top:8px;"/>
													<span>
														<font style="font-family:verdana; font-size:10pt; margin-left:5px"><xsl:value-of select="captions/anothercomp/@caption"/></font>
													</span>	
												</td>
											</tr>
											<tr>
												<td style="width:200px;">
												</td>
												<td style="padding-top:8px">
													<a style="color:#000000;">
														<xsl:attribute name="href">javascript:ourSubmit("default")</xsl:attribute>												
														<font class="button" style="margin-right:5; font-family:verdana; vertical-align:3px; font-size:10pt"><xsl:value-of select="captions/login/@caption"/></font>	
														<img src="/SharedResources/img/classic/login.gif" style="border:none; margin-left:5px"/>
													</a>	
												</td>
											</tr>
										</table>
									</xsl:if>
									<xsl:if test="../@userid != 'anonymous'">
										<table style="width:350px; margin:0px auto">
											<tr>
												<td style="text-align:center">
													<font style="font-size:1.2em">
														 <b><xsl:value-of select="../@username"/></b>
													</font>
													<br/>
													<br/>
												</td>
											</tr>
											<tr>
												<td style="text-align:center">
													<a style="color:#000000">
														<xsl:attribute name="href">javascript:ourSubmit("auth")</xsl:attribute>												
														<font  class="button" style="margin-right:5px; vertical-align:3px; font-size:10pt; font-family:verdana;">
															<xsl:value-of select="captions/login/@caption"/>
														</font>	
														<img src="/SharedResources/img/classic/login.gif" style="border:none; margin-left:5px;"/>
													</a>&#xA0;&#xA0;
													<a style="color:#000000" target="_parent"  href="Logout">
														<xsl:attribute name="title" select="captions/logout/@caption"/>
														<font  class="button" style="margin-right:5px; vertical-align:3px; font-size:10pt; font-family:verdana;">
															<xsl:value-of select="captions/logout/@caption"/>
														</font> 
														<img src="/SharedResources/img/iconset/door_in.png" style="border:none"/>						
													</a>
												</td>
											</tr>
										</table>
										<input type="hidden" size="30" name="login" id="login">
											<xsl:attribute name="value" select="../@userid"/>
										</input>
										<input type="hidden" size="30" name="pwd" value="" id="pwd"/>
								</xsl:if>
							</form>
						</div>
					</div>
				</div>
				<input type="hidden" name="type" value="login"/>
				<div id="footer">
					<span style=" float:left; margin-left:5px">
						<img src="classic/img/4ms.png"/>&#xA0;
						<a class="actionlink" target="blank" href="http://4ms.kz" style="color: #444444 ; font-size:11px; "><font style="margin-left:5px;font-size:11px; ">4MS workflow</font></a>  
						<font>&#xA0;&#xA0;<xsl:value-of select="content/version"/>&#xA0;&#xA0;&#169;&#xA0;&#xA0;2012&#xA0;</font>							
						<a title="Справка" style="margin-left:1em">
							<xsl:attribute name="href">Provider?type=static&amp;id=help_category_list</xsl:attribute>
					   		<img src="/SharedResources/img/classic/help.png"/>										
			        	</a>&#xA0;&#xA0;
					</span>		
					<span style=" float:right; margin-right:5px">
						<font><xsl:value-of select="captions/lang/@caption"/> :</font>	
						<select name="lang" id="lang" style="font-size:8pt;">
							<xsl:variable name='chinese' select="captions/chinese/@caption"/>
							<xsl:variable name='currentlang' select="../@lang"/>
							<xsl:attribute name="onchange">javascript:changeSystemSettings(this)</xsl:attribute>
							<xsl:for-each select="glossaries/langs/entry">
								<option value="{id}">
									<xsl:if test="$currentlang = id">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:if test="id = 'CHN'">
										<xsl:value-of select="$chinese"/>
									</xsl:if>
									<xsl:if test="id != 'CHN'">
										<xsl:value-of select="name"/>
									</xsl:if>
								</option>
							</xsl:for-each>
						</select>&#xA0;
						<font> <xsl:value-of select="captions/skin/@caption"/> :</font>
						<select name="skin" id="skin" style="font-size:8pt;">
							<xsl:variable name='currentskin' select="../@skin"/>
							<xsl:attribute name="onchange">javascript:changeSystemSettings(this)</xsl:attribute>
							<xsl:for-each select="glossaries/skins/entry">
								<option value="{id}">
									<xsl:if test="$currentskin = id">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="name"/>
								</option>
							</xsl:for-each>
						</select>
					</span>									
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>