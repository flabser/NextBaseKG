<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
		indent="yes" />
	<xsl:variable name="skin" select="request/@skin" />
	<xsl:variable name="useragent" select="/request/@useragent" />
	<xsl:template match="/request">
		<html>
			<head>
				<title>NextBase - WorkSpace </title>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
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
				<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" />
			</head>
			<body>
				
				<div style="position:absolute; top:0px; bottom:0px; left:0px; right:0px; min-height:600px; z-index:2">
					<div style="width:100%; height:80px; background:url(classic/img/body.png)">
						<span style="padding-left:10px; text-align:left;">
							
							<font style="font-size:2.7em; color:white; font-family:Roboto, Arial, Tahoma; margin-left:12px; vertical-align:-53px"><xsl:value-of select="content/content/org"/></font>
							<div style="margin-top:10px;">
								<form action="Login" method="post" id="frm" name="form">
									<xsl:if test="@userid !='anonymous'">
										<div style="width:700px; position:absolute; top:5px; right:5px; font-size:12px;text-align:right"
										border="0">
												<font class="sh" style="font-size:15px; vertical-align:bottom"><xsl:value-of select="@username" /></font>
												<div style="margin-left:10px; width:120px; height:16px; padding: 3px 2px 2px 2px; margin-top:5px" class="ui-button ui-widget ui-state-default  ui-button-text-only ui-corner-all">
													<xsl:attribute name="onclick">javascript:window.location.href='Logout'</xsl:attribute>
													<font class="button" style=" font-size:11px; margin-top:5px ">
														Выйти...
													</font>
												</div>
											</div>
									</xsl:if>
									<xsl:if test="@userid = 'anonymous'">
										<table style="width:450px; position:absolute; top:5px; right:5px; font-size:12px; border-collapse:collapse"
											border="0">
											<tr>
												<td style="width:140px;">
													<font class="sh" style="font-size:13px">
														<xsl:value-of select="content/captions/user/@caption" />:
													</font>
												</td>
												<td style="width:140px;">
													<font class="sh" style="font-size:13px; margin-left:10px">
														<xsl:value-of select="content/captions/password/@caption" />:
													</font>
												</td>
												<td >
												</td>
											</tr>
											<tr>
												<td>
													<input type="text" name="login" id="login" value="" style="width:170px; height: 15px;  margin-top:5px; padding: 2px 2px 2px 4px;" >
														<xsl:attribute name="onKeyDown">javascript:key(event)</xsl:attribute>
													</input>
												</td>
												<td>
													<input type="password" name="pwd" value="" id="pwd" style="width:170px; margin-top:5px; margin-left:10px ;height: 15px; padding: 2px 2px 2px 4px; ">
														<xsl:attribute name="onKeyDown">javascript:key(event)</xsl:attribute>
													</input>
												</td>
												<td style="width:100px">
													<div style="margin-left:15px; width:60px; height:16px; padding: 3px 2px 2px 2px; margin-top:5px" class="ui-button ui-widget ui-state-default  ui-button-text-only ui-corner-all">
															<xsl:attribute name="onclick">javascript:ourSubmit("default")</xsl:attribute>
															<font class="button" style=" font-size:11px; margin-top:5px ">
																<xsl:value-of select="content/captions/login/@caption" />
															</font>
													</div>
												</td>
											</tr>
											<tr>
												<td style="width:200px;">
													<input type="checkbox" id="cbx" name="noauth"
														style="vertical-align:1px; margin-left:0px" value="1"/>
														<font
															style=" font-size:12px; margin-left:3px; vertical-align:3px">
															<xsl:value-of select="content/captions/anothercomp/@caption" />
														</font>
												</td>
												<td>
													
												</td>
												<td>
												</td>
											</tr>
										</table>
									</xsl:if>
									<input type="hidden" name="type" value="login"/>
								</form>
							</div>
						</span>
					</div>
					<div class="apps-wrapper" style="margin:30px auto 10px; padding:10px 10px;">
						<xsl:if test="@userid = 'anonymous'">
							<ul class="apps-list-ul">
								<a class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
									<xsl:attribute name="style">background:#eee; border: 1px solid #ccc; color:#cdcdcd; ;</xsl:attribute>
									<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
									<div class="ui-button-text">
										<xsl:if test="logo = ''">
											<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
												<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
													 <xsl:value-of select="apptype"/>
												</font>
											</div>
											<div style="position:absolute; bottom:20px; left:0px; right:0px;text-align:center">
												<font style="font: 16px Verdana, Geneva, sans-serif;">
													<xsl:value-of select="description"/>
												</font>
											</div>
										</xsl:if>
									</div>
								</a>
								<a class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
									<xsl:attribute name="style">background:#eee; border: 1px solid #ccc; color:#cdcdcd; ;</xsl:attribute>
									<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
									<div class="ui-button-text">
										<xsl:if test="logo = ''">
											<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
												<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
													<xsl:value-of select="apptype"/> 
												</font>
											</div>
											<div style="position:absolute; bottom:20px; left:0px; right:0px; text-align:center">
												<font style="font: 16px Verdana, Geneva, sans-serif;">
													<xsl:value-of select="description"/>
												</font>
											</div>
										</xsl:if>
									</div>
								</a>
								<a class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
									<xsl:attribute name="style">background:#efefef;opacity:0.85; border: 1px dashed #ccc; color:#cdcdcd; ;</xsl:attribute>
									<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
									<div class="ui-button-text">
										<xsl:if test="logo = ''">
											<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
												<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
													 <xsl:value-of select="apptype"/>
												</font>
											</div>
											<div style="position:absolute; bottom:20px; left:0px; right:0px;text-align:center">
												<font style="font: 16px Verdana, Geneva, sans-serif;">
													<xsl:value-of select="description"/>
												</font>
											</div>
										</xsl:if>
									</div>
								</a>
							</ul>
						</xsl:if>
						<xsl:if test="@userid != 'anonymous'">
							<ul class="apps-list-ul">
								<xsl:for-each select="content/glossaries/apps/entry">
									<a href="javascript:$.noop()" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
										<xsl:if test="@mode = 'off'">
											<xsl:attribute name="style">background:#eee; border: 1px solid #ccc; color:#cdcdcd; ;</xsl:attribute>
											<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
										</xsl:if>
										<xsl:if test="@mode = 'on'">
											<xsl:attribute name="onclick">javascript:window.location.href= window.location.protocol + "//" + window.location.host + "/<xsl:value-of select="redirect"/>"</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="title"><xsl:value-of select="description"/> - <xsl:value-of select="orgname"/></xsl:attribute>
										<div class="ui-button-text">
											<xsl:if test="logo != ''">
												<div style="padding-top:25px; height:50px; width:100%; text-align:left">
													<img src="/SharedResources/logos/{logo}" style="max-height:64px; max-width:64px; float:left; margin: 0px 15px 7px 5px;"> 
														<xsl:if test="@mode = 'off'">
															<xsl:attribute name="style">opacity:0.5</xsl:attribute>
															<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
														</xsl:if>
													</img>
													<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
														 <xsl:value-of select="apptype"/>
													</font>
												</div>
												<div style="position:absolute; bottom:20px;left:0px; right:0px;text-align:center">
													<font style="font: 16px Verdana, Geneva, sans-serif;">
														<xsl:value-of select="description"/>
													</font>
												</div>
												
											</xsl:if>
											<xsl:if test="logo = ''">
												<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
													<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
														 <xsl:value-of select="apptype"/>
													</font>
												</div>
												<div style="position:absolute; bottom:20px; left:0px; right:0px;text-align:center">
													<font style="font: 16px Verdana, Geneva, sans-serif;">
														<xsl:value-of select="description"/>
													</font>
												</div>
											</xsl:if>
										</div>
									</a>
								</xsl:for-each>
							</ul>
						</xsl:if>
					</div>
				</div>
				<div style="position:absolute; bottom:5px; left:5px; font-size:10px; right:0px">
					<font style="vertical-align:-20px">v. <xsl:value-of select="content/content/version"/> &#160; build : <xsl:value-of select="content/content/build"/></font>
					<img src="" style="float:right">
						<xsl:attribute name="src">/SharedResources/logos/<xsl:value-of select="content/content/img"/></xsl:attribute>
						<xsl:if test="@userid != 'anonymous'">
							<xsl:attribute name="class">gray</xsl:attribute>
						</xsl:if>
					</img>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>