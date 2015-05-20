<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="useragent" select="/request/@useragent"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title> 4ms workflow - <xsl:value-of select="outline/*/entry[@current]/@caption"/></title>
				<link type="text/css" rel="stylesheet" href="classic/css/outline.css"/>
				<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.button.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<script type="text/javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="classic/scripts/view.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<link rel="stylesheet" href="/SharedResources/dojo/dijit/themes/soria/soria.css" media="screen" />
				<link rel="stylesheet" href="/SharedResources/dojo/dijit/themes/dijit.css" media="screen" />
				<script src="/SharedResources/dojo/dojo/dojo.js" data-dojo-config="async:true, parseOnLoad:true"></script>
				<script type="text/javascript">
					function onLoadActions(){
						<xsl:choose>
							<xsl:when test="currentview/@type='search'">
								outline.type = 'search'; 
								outline.curPage = '<xsl:value-of select="currentview/@page" />'; 
								outline.curlangOutline = '<xsl:value-of select="@lang"/>';
								doSearch('<xsl:value-of select="currentview/@keyword" />');								
							</xsl:when>
							<xsl:when test="current/@type='edit'">
								outline.type = '<xsl:value-of select="current/@type" />'; 
								outline.viewid = '<xsl:value-of select="current/@id" />';
								outline.docid = <xsl:value-of select="current/@key" />;
								outline.element = 'project';
								outline.command='<xsl:value-of select="current/@command" />';
								outline.curPage = '<xsl:value-of select="current/@page" />'; 
								outline.curlangOutline = '<xsl:value-of select="@lang"/>';
								outline.category = '';
								refreshAction(); 
							</xsl:when>
							<xsl:otherwise>
								outline.type = '<xsl:value-of select="currentview/@type" />'; 
								outline.viewid = '<xsl:value-of select="currentview/@id" />';
								outline.command='<xsl:value-of select="currentview/@command" />';
								outline.curPage = '<xsl:value-of select="currentview/@page" />'; 
								outline.curlangOutline = '<xsl:value-of select="@lang"/>';
								outline.filterid = '<xsl:value-of select="currentview/@id"/>';
								refreshAction(); 
							</xsl:otherwise>
						</xsl:choose>
						$(document).bind('keydown', 'xml',function (event){
							if (event.ctrlKey &amp;&amp; event.shiftKey) {
    							if (event.keyCode ==49 ){
    								javascript:openXMLdoc();
    							}
    							if (event.keyCode ==50 ){
    								javascript:openXMLdocView(outline.viewid);
    							}
    						}
						});
					}
				</script>
				<script id="scr">
					require(["dijit/layout/AccordionContainer", "dijit/layout/BorderContainer", 
							"dijit/layout/ContentPane", "dojo/parser","dijit/form/Button","dijit/form/TextBox", 
							"dijit/form/SimpleTextarea","dijit/layout/TabContainer","dijit/layout/ContentPane","dijit/form/DateTextBox" ,
							"dijit/form/FilteringSelect","dijit/form/Select","dijit/form/CheckBox","dojo/data/ItemFileReadStore","dijit/Tree","dijit/Menu"]);
				</script>
				<style>
					html, body {
					    height: 100%;
					    margin: 0;
					    overflow: hidden;
					    padding: 0;
					    font-family:Verdana,Arial,Helvetica,sans-serif;
					    font-size:13px
					}
					#wrapper {
					    height: 100%;
					}
					#appLayout {
					   position:absolute;
					   top:0px;
					   left:0px;
					   width:100%;
					   bottom:0px;
					}
					#footer {
					}
					#footer a{
						text-decoration:none;
					}
					#footer a:hover{
						text-decoration:underline;
					}
					#header {
					   position:absolute;
					   left:0px;
					   width:100%;
					   top:0px;
					   height:60px;
					   padding:1em 0.5em;
					}
					#outline {
					    width: 22%;
					}
					#view {
						height: 100%;
					}
					#viewtable{
						border-collapse:collapse;
						margin-top:20px;
						width:100%;
					}
					#viewtable tr td{
						border:1px solid #CCCCCC;
						height:25px;
						padding-left:5px;
					}
					#viewtable tr:hover{
						background:#eeeeee;
					}
					#viewtableheader td{
						text-align:center;
						font-weight:bold;
						background:#DEDEDE;
					}
					#nav a{
						color:#105CB6;
						text-decoration:none;
						font-size:14px;
					}
					#nav a:hover{
						text-decoration:underline;
					}
					#nav b{
						font-size:16px;
						text-decoration:none;
					}
				</style>
			</head>
			<body class="soria"  onload="javascript:onLoadActions()" style="cursor:wait" onUnload="javascript:endLoadingOutline()">
				<div id="wrapper">
					<div id="appLayout" data-dojo-type="dijit.layout.BorderContainer" data-dojo-props="design:'headline'">
						<div id="outline" class="dijitAccordionContainer dijitContainer dijitLayoutContainer dijitBorderContainer-child dijitBorderContainer-dijitAccordionContainer dijitBorderContainerPane dijitAlignLeft" data-dojo-type="dijit.layout.AccordionContainer" data-dojo-props="region:'leading', splitter:true, minSize:100, maxSize:600" style="width:275px">
							<div class="dijitAccordionInnerContainer">
							
								<xsl:for-each select="outline/entry[node()]">
									<div data-dojo-type="dijit.layout.ContentPane" title="{@hint}" class="dijitAccordionInnerContainer dijitAccordionInnerContainerSelected ">
										<div class="dijitTree dijitTreeContainer">
											<div class="dijitInline dijitTreeIndent"></div>
												
												<xsl:for-each select="entry">
												<div class="dijitTreeIsRoot dijitTreeNode" >
													<div dojoattachpoint="rowNode" class="dijitTreeRow">
														<a href="{@url}" style="width:90%; vertical-align:top;">
															<xsl:if test="../@id = 'filters'">
																<xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;filterid=<xsl:value-of select="@id" /></xsl:attribute>
															</xsl:if>
															<span class="viewlinktitle">
																<xsl:value-of select="@caption" />
															</span>
														</a>
														<xsl:if test="../@id = 'mydocs'">
															<span class="countSpan" style="vertical-align:top">
																<xsl:if test="@id!=''">
																	<xsl:attribute name="id" select="@id" />
																</xsl:if>
																<xsl:if test="string-length(@count)!=0">
																	<xsl:value-of select="@count" />
																</xsl:if>
															</span>
														</xsl:if>
													</div>
												</div>
												</xsl:for-each>
												
											</div>
										</div>
									</xsl:for-each>
							</div>
						</div>
						<div id="view" data-dojo-type="dijit.layout.ContentPane" data-dojo-props="region: 'center'">
						</div>
						<div data-dojo-type="dijit.layout.ContentPane" data-dojo-props="region: 'bottom'" style="height:20px">
							<a class="actionlink" target="_parent"  href="Logout" title="{outline/fields/logout/@caption}">
								<img src="/SharedResources/img/classic/icons/door_in.png" style="width:15px; height:15px" alt=""/>						
								<font style="margin-left:5px;font-size:11px; vertical-align:3px"><xsl:value-of select="outline/fields/logout/@caption"/></font> 
							</a>&#xA0;
							<a class="actionlink" target="_parent" title="Посмотреть свойства текущего пользователя" href="Provider?type=document&amp;id=userprofile" style="color: #444444 ;   font: 85%/2 Arial">
								<img src="/SharedResources/img/classic/icons/user_edit.png" border="none" style="width:15px; height:15px" alt=""/>								
								<font style="margin-left:5px;font-size:11px; vertical-align:3px">
									<xsl:value-of select="currentuser"/>
								</font>
							</a>
							<a class="actionlink" target="blank" href="http://4ms.kz" style="color: #444444 ;   font: 85%/2 Arial; float:right"><font style="margin-left:5px;vertical-align:3px; font-size:11px; ">4MS workflow © 2012</font></a>  
						</div>
					</div>
				</div>
				
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>