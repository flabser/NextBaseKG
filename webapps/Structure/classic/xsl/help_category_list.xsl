<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="templates/view.xsl"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:template match="/request/history">
	</xsl:template>
	<xsl:template match="/request/content">
		<html>
			<head>
				<title>Справка </title>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<link rel="stylesheet" href="classic/css/actionbar.css" />
				<link rel="stylesheet" href="/SharedResources/css/reset.css" />
			</head>
			<body style="font-family: Verdana, arial, helvetica, sans-serif">
				<div class="help_bar">
					<span>
						<img style="margin: 20px 0 0 5px" src="classic/img/4ms-logo.png" />
						<font
							style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:30px">
							Помощь
						</font>
						<a style="float:right; margin: 45px 5px 0 0">
							<xsl:attribute name="href">javascript:CancelForm('')</xsl:attribute>
							<img src="/SharedResources/img/iconset/cross.png" style="border:0;"></img>
							<font class="button"
								style="font-family:verdana; font-size:1.0em; margin-left:5px">Закрыть</font>
						</a>
					</span>
				</div>
				<div>
					<table
						style="font-family:arial; font-size:18px; width:85%; margin-top:5%; margin-left:5%">
						<tr style="height:65px">
							<td style="width:200px;">
								<a href="Provider?type=page&amp;id=help_documents">
									Общие вопросы
								</a>
								<br />
								<font style="font-size:14px;">
									&#xA0;&#xA0;&#xA0;настройка системы, советы по поиску,
									расширенный поиск,
									<br />
									&#xA0;&#xA0;&#xA0;правила регистрации документов в системе,
									типы документов
								</font>
							</td>
							 <td> <a href="Provider?type=page&amp;id=help_documents"> Регистрация
								документов </a> <br/> <font style="font-size:14px;"> правила регистрации 
								документов в системе, типы документов </font> </td> 

						</tr>
					<tr style="height:65px"> <td width="50%"> <a href="Provider?type=page&amp;id=help_projects">
							Регистрация проектов </a> <br/> <font style="font-size:14px;"> правила регистрации 
							проектов в системе, виды проектов, действия пользователя с проектами </font> 
							</td> <td> <a href="Provider?type=page&amp;id=help_mydocuments"> Категория
							- Мои документы </a> <br/> <font style="font-size:14px;"> описание возможностей 
							базы документов "мои документы", действия пользователей с документами </font> 
							</td> </tr> 
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>