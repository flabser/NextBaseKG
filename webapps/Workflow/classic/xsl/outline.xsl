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
				<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
				<link type="text/css" rel="stylesheet" href="classic/css/outline.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
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
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
				<script type="text/javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="classic/scripts/view.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<script type="text/javascript">
					function onLoadActions(){
						<xsl:choose>
							<xsl:when test="currentview/@type='search'">
								outline.type = 'search'; 
								outline.curPage = '<xsl:value-of select="currentview/@page" />'; 
								outline.curlangOutline = '<xsl:value-of select="@lang"/>';
								outline.keyword = '<xsl:value-of select="currentview/@keyword" />';
								refreshAction(); 
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
						$(document).bind('keydown', function(e){
 							if (e.ctrlKey) {
 								switch (e.keyCode) {
								   case 85:
								   		<!-- клавиша u -->
								     	e.preventDefault();
								     	window.location.href=$("#currentuser").attr("href")
								      	break;
								   case 81:
								   		<!-- клавиша q -->
								     	e.preventDefault();
								     	window.location.href=$("#logout").attr("href")
								      	break;
								   case 72:
								   		<!-- клавиша h -->
								     	e.preventDefault();
								     	window.location.href=$("#helpbtn").attr("href")
								      	break;
								   default:
								      	break;
								}

	    					}
    					});
				<![CDATA[
					jQuery(document).ready(function(){
						jQuery("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
						$("#logout").hotnav({keysource:function(e){ return "q"; }});
						$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
					});
					]]>
					}
				</script>
			</head>
			<body onload="javascript:onLoadActions()" style="cursor:wait" onUnload="javascript:endLoadingOutline()">
				<div id="blockWindow"/>
				<div id="wrapper">
					<div id='loadingpage' style='position:absolute;'>
						<script>
							lw = $("#loadingpage").width();
							lh = $("#loadingpage").height();
							lt = ($(window).height() - lh )/2;
							ll = ($(window).width() - lw )/2;
							$("#loadingpage").css("top",lt - 55);
							$("#loadingpage").css("left",ll + 95);
							$("#loadingpage").css("z-index",1);
						</script>
						<img src='/SharedResources/img/classic/4(4).gif'/>
					</div>	
					<div id="outline">
						<div id="outline-header" >
							<img alt="" src ="classic/img/logo_small.png" style="height:50px; margin-top:5px"/>
							<br/>
							<font style="font-size:0.80em; color:#1D5987; position:relative; top:14px">
								<xsl:value-of select="outline/fields/documentmanager/@caption"/>&#xA0;<xsl:value-of select="outline/fields/orgtitle"/>
							</font>
							<br/>
						</div>
						<div id="outline-container">
							<xsl:for-each select="outline/entry">
								<div style="margin-bottom:10px;">
									<span style="height:10px; margin-top:5px; width:240px">								
										<img src="/SharedResources/img/classic/minus.gif" style="margin-left:6px; cursor:pointer" alt="">
											<xsl:attribute name="onClick">javascript:ToggleCategory(this)</xsl:attribute>
										</img>
										<font style="font-family:arial; font-size:0.9em; margin-left:5px">											
											<xsl:value-of select="@hint"/>
										</font>
									</span>
									<div style="clear:both;"/>
									<div class="outlineEntry">
										<xsl:for-each select="entry">
											<div class="entry" style="width:250px">
												<div class="viewlink" style="height:18px">
													<xsl:if test="@current = '1'">
														<xsl:attribute name="class">viewlink_current</xsl:attribute>										
													</xsl:if>	
													<div style="float:left">
														<xsl:choose>
															<xsl:when test="following-sibling::entry">
																<img alt="" src="/SharedResources/img/classic/tree_tee_big.gif"/>
															</xsl:when>
															<xsl:otherwise>
																<img alt="" src="/SharedResources/img/classic/tree_corner_big.gif"/>
															</xsl:otherwise>
														</xsl:choose>	
														<a href="{@url}" style="width:90%; vertical-align:top;">
															<xsl:if test="../@id = 'filters'">
																<xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;filterid=<xsl:value-of select="@id"/></xsl:attribute>
															</xsl:if>
															<font class="viewlinktitle">	
																 <xsl:value-of select="@caption"/>
															</font>
														</a>
													</div>
													<xsl:if test="../@id = 'mydocs'">
														<span style=" text-align:left; float:right; ">
															<font class="countSpan" style="vertical-align:top">
																<xsl:if test="@id!=''">	
																	<xsl:attribute name="id" select="@id"/>
																</xsl:if>	
																<xsl:if test="string-length(@count)!=0">
																	<xsl:value-of select="@count"/>
																</xsl:if>												
															</font>
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
					<div style="border-left:3px solid;  width:2px; height:100%; position:absolute; left:274px; border-color:#CCCCCC"/>
					<span id="view" class="viewframe{outline/category[entry[@current=1]]/@id}">
						<div id="noserver" style="display:none; text-align:center; margin-top:10%">
							<font style='font-size:1.5em'>Отсутствует соединение с сервером</font>
							<br/>
							<img style="margin-top:10%" src='/SharedResources/img/classic/noserver.gif'/>
						</div>
					</span>
					<div class="clearfloat"/>
					<div class="empty"/>
				</div>
				<div id="footer">
					<div style="padding:2px 10px 0px 10px; color: #444444; width:600px; margin-top:5px; float:left">
						<a target="_parent" id="logout"  href="Logout" title="{outline/fields/logout/@caption}">
							<img src="/SharedResources/img/iconset/door_in.png" style="width:15px; height:15px" alt=""/>						
							<font style="margin-left:5px;font-size:11px; vertical-align:3px"><xsl:value-of select="outline/fields/logout/@caption"/></font> 
						</a>&#xA0;
						<a target="_parent" title="Посмотреть свойства текущего пользователя"  id="currentuser" href="Provider?type=document&amp;id=userprofile" style="color: #444444 ;   font: 85%/2 Arial">
							<img src="/SharedResources/img/iconset/user_edit.png" border="none" style="width:15px; height:15px" alt=""/>								
							<font style="margin-left:5px;font-size:11px; vertical-align:3px">
								<xsl:value-of select="currentuser"/>
							</font>
						</a>
					</div>
					<div style="padding:5px 20px 0px 10px; font-color: #444444; width:300px; float:right">
						<div id="langview" style=" float:right; margin-top:1px">
							<a class="actionlink" target="blank" href="http://4ms.kz" style="color: #444444 ; font-size:11px; "><font style="margin-left:5px;font-size:11px; vertical-align:3px">4MS workflow © 2012</font></a>  
						</div>
					</div>
				</div>
				<div id="gadget" display="none" style="display:none; width:264px; height:194px; background:url(classic/img/BLUE-base.png) no-repeat ; font-size:12px">
 					<table style="width:220px; height:154px; border-collapse:collapse; margin-top:5px; margin-left:18px; font-size:12px; font-family:Segoe UI, Tahoma;" valign="top">
						<xsl:for-each select="outline/entry[1]/entry">
							<tr id="str" style="height:10px">
								<td id="td1" style="height:10px">
									<span class="span" style="color:lightgray; height:10px">
										<a id="glink" target="blank" href="Avanti/{@url}">
											<xsl:value-of select="@caption"/>
										</a>
									</span>
								</td>
								<td id="td2" style="color:blue;">
									<xsl:value-of select="@count"/>
								</td>
								<td id="td3" style="color:orange;">
									0
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>