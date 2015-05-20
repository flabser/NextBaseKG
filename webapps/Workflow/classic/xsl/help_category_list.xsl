<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="templates/view.xsl"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:template match="/request/history"></xsl:template>
	<xsl:template match="/request/content">
		<html>
			<head>
				<title>Справка </title>
				<script language="javascript" src="classic/scripts/form.js"/>
				<link rel="stylesheet" href="classic/css/actionbar.css"/>
				<link rel="stylesheet" href="classic/css/main.css"/>
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
				<div id="header-view">
					<span style="float:left">
						<img alt="" src ="classic/img/4ms-logo_small.png" style="margin:10px 5px 0px 10px"/>
						<font style="font-size:1.5em; vertical-align:10px; color:#555555">4MS Workflow - Помощь</font>
					</span>
					<span style="float:right; padding:5px 5px 5px 0px" >
						<a id="currentuser" target="_parent" title="Посмотреть свойства текущего пользователя" href=" Provider?type=edit&amp;element=userprofile&amp;id=userprofile" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
							<font><xsl:value-of select="/request/@username"/></font>
						</a>
						<a target="_parent" href="Logout" id="logout" title="{outline/fields/logout/@caption}" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
							<font style="margin-left:15px;">Завершить работу</font> 
						</a>
						
					</span>				
				</div>
				<button style="float:right; margin-top:10px">
					<xsl:attribute name="onclick">javascript:window.history.back()</xsl:attribute>
					<img src="/SharedResources/img/iconset/cross.png" class="button_img" style="width:16px; vertical-align:top"/>
					<font style="font-size:12px; margin-left:5px; vertical-align:7px">Закрыть</font>
				</button>
				<div>
					<table style="font-family:arial; font-size:16px !important; width:85%; margin-top:5%; margin-left:5%">
						<tr style="height:65px">
							<td style="width:200px;">
								<a href="Provider?type=static&amp;id=help_documents">
									Общие вопросы
								</a>
								<br/>
								<font style="font-size:14px;">
									&#xA0;&#xA0;&#xA0;настройка системы, советы по поиску,
									расширенный поиск,
									<br />
									&#xA0;&#xA0;&#xA0;правила регистрации документов в системе,
									типы документов
								</font>
							</td>
							 <td> <a href="Provider?type=static&amp;id=help_documents"> Регистрация 
								документов </a> <br/> <font style="font-size:14px;"> правила регистрации 
								документов в системе, типы документов </font> </td> 

						</tr>
					<tr style="height:65px"> <td width="50%"> <a href="Provider?type=static&amp;id=help_projects"> 
							Регистрация проектов </a> <br/> <font style="font-size:14px;"> правила регистрации 
							проектов в системе, виды проектов, действия пользователя с проектами </font> 
							</td> <td> <a href="Provider?type=static&amp;id=help_mydocuments"> Категория 
							- Мои документы </a> <br/> <font style="font-size:14px;"> описание возможностей 
							базы документов "мои документы", действия пользователей с документами </font> 
							</td> </tr> 
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>