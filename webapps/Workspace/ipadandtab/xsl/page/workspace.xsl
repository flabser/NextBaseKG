<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="utf-8" indent="no" />

	<xsl:template match="/request">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<html>
			<head>
				<title>NextBase - WorkSpace </title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
				<link type="text/css" rel="stylesheet" href="/SharedResources/css/normalize.css" />
				<link type="text/css" rel="stylesheet" href="ipadandtab/css/main.css" />
				<link type="text/css" rel="stylesheet" href="ipadandtab/css/nav-ws.css" />
			</head>
			<body>
				<xsl:if test="@userid = 'anonymous'">
					<xsl:attribute name="class">anonymous</xsl:attribute>
				</xsl:if>
				<xsl:call-template name="header" />
				<section class="app-list nav-ws">
					<xsl:if test="@userid = 'anonymous'">
						<xsl:call-template name="apps-maybe" />
					</xsl:if>
					<xsl:if test="@userid != 'anonymous'">
						<xsl:apply-templates select="//availableapps" mode="ws" />
					</xsl:if>
				</section>
				<footer class="footer">
					<span class="vers">
						<xsl:value-of select="concat('v. ', page/response/content/serverversion, ' build: ', content/content/build)" />
					</span>
					<img class="logo" src="/SharedResources/logos/{page/response/content/img}">
						<xsl:if test="@userid != 'anonymous'">
							<xsl:attribute name="class">logo gray</xsl:attribute>
						</xsl:if>
					</img>
				</footer>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="header">
		<header class="header">
			<div class="brand">
				<xsl:value-of select="page/response/content/org" />
			</div>
		</header>
		<div class="sign-in">
			<xsl:if test="@userid != 'anonymous'">
				<span class="username">
					<xsl:value-of select="@username" />
				</span>
				<a href="Logout" class="btn-logout">
					<xsl:value-of select="page/captions/logout/@caption" />
				</a>
			</xsl:if>
			<xsl:if test="@userid = 'anonymous'">
				<form action="Login" method="post" name="form">
					<input type="hidden" name="type" value="login" />
					<fieldset class="fieldset">
						<ol class="fieldset-container">
							<li class="control-group">
								<label class="control-label" for="login">
									<xsl:value-of select="page/captions/user/@caption" />
								</label>
								<input type="text" name="login" id="login" value="" required="required" />
							</li>
							<li class="control-group">
								<label class="control-label" for="pwd">
									<xsl:value-of select="page/captions/password/@caption" />
								</label>
								<input type="password" name="pwd" id="pwd" value="" required="required" />
							</li>
						</ol>
						<div class="sign-in-fieldset-bottom">
							<button type="submit" class="btn-submit">
								<xsl:value-of select="page/captions/login/@caption" />
							</button>
							<label class="noauth">
								<input type="checkbox" id="cbx" name="noauth" value="1" />
								<xsl:value-of select="page/captions/anothercomp/@caption" />
							</label>
						</div>
					</fieldset>
				</form>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template name="apps-maybe">
		<div class="ws-apps unavailable">
			<a class="ws-app" href="#">
				<div class="ws-app-logo"></div>
				<div class="ws-app-name"></div>
				<div class="clearfix"></div>
			</a>
			<a class="ws-app" href="#">
				<div class="ws-app-logo"></div>
				<div class="ws-app-name"></div>
				<div class="clearfix"></div>
			</a>
			<a class="ws-app" href="#">
				<div class="ws-app-logo"></div>
				<div class="ws-app-name"></div>
				<div class="clearfix"></div>
			</a>
		</div>
	</xsl:template>

	<xsl:template match="availableapps" mode="ws">
		<div class="ws-apps">
			<xsl:apply-templates select="query/entry" mode="ws" />
		</div>
	</xsl:template>

	<xsl:template match="entry" mode="ws">
		<a class="ws-app" href="/{viewcontent/viewtext}/{viewcontent/viewtext1}">
			<div class="ws-app-logo">
				<img src="/SharedResources/logos/{viewcontent/viewtext2}" />
			</div>
			<div class="ws-app-name">
				<xsl:value-of select="viewcontent/viewtext" />
			</div>
			<div class="clearfix"></div>
			<div class="ws-app-name2">
					<xsl:value-of select="viewcontent/viewtext4" />
				</div>
			<div class="clearfix"></div>
		</a>
	</xsl:template>

</xsl:stylesheet>
