<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	 doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request/content">
		<html>
			<head>
				<title>Support</title>
				<link rel="stylesheet" href="{$skin}/css/start.css"/>
				<script type="text/javascript" src="classic/scripts/start.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
<!-- 				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.button.js"/> -->
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
				<meta http-equiv="content-type" content="text/html; charset=utf-8" />
			</head>
			<body onKeyDown="key(event)">
				<div id="wrapper">
					<div id="header">
						<span style="float:left;margin: 5px 0 0 10%">
							<font style="color:rgb(76,76,76); font-size:28px; font-family:Arial, Helvetica, sans-serif;">Support</font>&#xA0;
							<font style="color:rgb(76,76,76); font-size:14px; font-family:Arial, Helvetica, sans-serif;"><xsl:value-of select="captions/description/@caption" /></font>
						</span>
						<span style=" float:right; margin:14px 5px 0 0">
							<font style="color:#597BAF">
								<xsl:value-of select="captions/lang/@caption"/> :
							</font>	
							<select  dojoType="dijit.form.Select" id="lang" name="lang" autoComplete="false" invalidMessage="Введеного вами языка не существует"  style="font-size:8pt; width:100px">
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
							<font style="color:#597BAF">
								<xsl:value-of select="captions/skin/@caption"/> :
							</font>
							<select  dojoType="dijit.form.Select" id="skin" name="skin" autoComplete="false" invalidMessage="Введеного вами оформлления не существует"  style="font-size:8pt; width:100px">
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
					
					<div id ="content">
						<div id="left_content" >
							<div style="margin:30px 0 0 50%;"> 
								<span style="font-size:18px" class="font">TOO "Lab of the Future"</span>
								<br />	<br/>
								<span style="padding-left:15px;">							 
									<img src="/SharedResources/img/smartdoc.png" alt="" /><br/><br/>
									<img src="/SharedResources/img/4ms_logo.png" width="145" alt="" style="vertical-align:20px;"/>
								 </span>
								<br />
								<font style="font-size:11px;">Модератор: Падалко Павел
									<br/>email: <span>p.padalko@flabs.kz <br/>XMPP(jabber) pavel@smartdoc.kz </span>
								</font>
							</div> 
						</div>
						
						<div id="right_content">
							<div id="login_view_container">
								<div id="login_view">
								<form action="Login" method="post" id="frm" name="form">
									<xsl:if test="../@userid = 'anonymous'">
										<table style="width:320px; margin:5px auto">
												<tr>
													<td style="  text-align:center; padding:25px 0 10px 0" colspan="2">
														<font class="sh font" style="font-size:24px; color:#4C4C4C">
															Авторизация															
														</font>
													</td>
												</tr>
												<tr style="height:50px">	 
													<td style="text-align:right; padding:5px 0 5px 10px">
														<font class="sh font" style="font-size:18px; color:#4C4C4C">
															<xsl:value-of select="captions/user/@caption"/>:															
														</font>
													</td>												
													<td style="text-align:left;">
														<input id="login"  name="login" data-dojo-type="dijit.form.TextBox" class="textbox" />
													</td>
												</tr>
												<tr style="height:50px">
													<td style="text-align:right; padding:5px 0 5px 10px">
														<font  class="sh font" style="font-size:18px; color:#4C4C4C">
															<xsl:value-of select="captions/password/@caption"/>: 
														</font>
													</td>
													<td>
														<input type="password" id="pwd" name="pwd" data-dojo-type="dijit.form.TextBox"  class="textbox" />
													</td>
												</tr>
												<tr>
													<td style="width:200px;">
													</td>
													<td style="padding-top:7px">
														<input dojoType="dijit.form.CheckBox" type="checkbox" id="cbx" name="noauth"/>
														<span>
															<font style="font-family:verdana; font-size:10pt; margin-left:5px; color:#4C4C4C"><xsl:value-of select="captions/anothercomp/@caption"/></font>
														</span>	
													</td>
												</tr>
												<tr>
													<td style="width:200px;">
													</td>
													<td style="padding: 5px auto">
														<button id="btn" type="button" class="buttonBlue" style="font-weight:bold; font-size:13px; margin-top:5px ">
			       		 									<xsl:attribute name="onclick">javascript:ourSubmit("default")</xsl:attribute>	
			       		 									<font style="vertical-align:3px">
			       		 										<xsl:value-of select="captions/login/@caption"/>
			       		 									</font>
			       		 									<img src="/SharedResources/img/classic/login.gif" style="border:none; margin-left:5px;"/>
			    										</button>
													</td>
												</tr>
										</table>
									</xsl:if>
									<xsl:if test="../@userid != 'anonymous'">
										<table style="width:320px; margin:50px auto">
											<tr>
												<td style="width:200px; text-align:center" colspan="2">
													<font class="sh font" style="font-size:20px; color:#4C4C4C">
														 <b><xsl:value-of select="../@username"/></b>
													</font>
												</td>
											</tr>
											<tr>
												<td style="width:350px; text-align:center; padding-top:30px">
													<button id="btn" type="button" class="buttonBlue" style="font-weight:bold; font-size:13px; background-color:#a9db80">
														<xsl:attribute name="onclick">javascript:ourSubmit("auth")</xsl:attribute>												
														<font  class="button" style="margin-right:5px; font-size:13px; font-family:verdana; vertical-align:3px ">
															<xsl:value-of select="captions/login/@caption"/>
														</font>	
														<img src="/SharedResources/img/classic/login.gif" style="border:none; margin-left:5px; margin-top:2px;  "/>
													</button>
													<button id="btnlogout" type="button" class="buttonBlue" style="font-weight:bold; font-size:13px; margin-left:5px; width:200px; background-color:#F79483">
														<xsl:attribute name="onclick">javascript:window.location.href="Logout"</xsl:attribute>	
														<xsl:attribute name="title" select="captions/logout/@caption"/>
														<font  class="button" style="margin-right:5px;  font-size:13px; font-family:verdana; vertical-align:3px">
															<xsl:value-of select="captions/logout/@caption"/>
														</font> 
														<img src="/SharedResources/img/iconset/door_in.png" style="border:none; margin-left:5px; margin-top:1px; width:18; height:18px"/>						
													</button>
												</td>
											</tr>
										</table>
									</xsl:if>
									<input type="hidden" size="30" name="login" id="login">
											<xsl:attribute name="value" select="../@userid"/>
									</input>
									<input type="hidden" size="30" name="pwd" value="" id="pwd"/>
								</form>
								</div>
							</div>
						</div>
						<br class="clear"/>
					</div>
				</div>
				<input type="hidden" name="type" value="login"/>
				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>