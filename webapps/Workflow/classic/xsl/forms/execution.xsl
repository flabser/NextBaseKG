<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype"><xsl:value-of select="request/document/captions/doctypemultilang/@caption"/></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="editmode">
		<xsl:choose>
			<xsl:when test="/request/document/fields/parentdoccontrol = 'false'">
				noaccess
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/request/document/@editmode"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
	<xsl:variable name="filename" select="document/fields/pdocrtfcontent"/>
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Workflow документооборот - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="markisread"/>
				<script type="text/javascript">
					$(document).ready(function(){hotkeysnav()})
   					<![CDATA[
   						function hotkeysnav() {
							$(document).bind('keydown', function(e){
			 					if (e.ctrlKey) {
			 						switch (e.keyCode) {
									   case 66:
									   		<!-- клавиша b -->
									     	e.preventDefault();
									     	$("#canceldoc").click();
									      	break;
									   case 69:
									   		<!-- клавиша e -->
									     	e.preventDefault();
									     	$("#btnexecution").click();
									      	break;
									   case 71:
									  		<!-- клавиша g -->
									     	e.preventDefault();
									     	$("#btngrantaccess").click();
									      	break;
									   case 87:
									  		<!-- клавиша w -->
									     	e.preventDefault();
									     	$("#btnremind").click();
									      	break;
									   case 83:
									   		<!-- клавиша s -->
									     	e.preventDefault();
									     	$("#btnsavedoc").click();
									      	break;
									   case 84:
									   		<!-- клавиша t -->
									     	e.preventDefault();
									     	$("#btnnewkr").click();
									      	break;
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
									   case 73:
									   		<!-- клавиша i -->
									     	e.preventDefault();
									     	window.location.href=$("#helpbtn").attr("href")
									      	break;
									   default:
									      	break;
									}
			   					}
							});
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btncoordyes").hotnav({keysource:function(e){ return "y"; }});
							$("#btngrantaccess").hotnav({keysource:function(e){ return "g"; }});
							$("#btnremind").hotnav({keysource:function(e){ return "w"; }});
							$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
							$("#btnexecution").hotnav({keysource:function(e){ return "e"; }});
							$("#btnnewkr").hotnav({keysource:function(e){ return "t"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
							$("#btnnewish").hotnav({keysource:function(e){ return "i"; }});
						}
					]]>
				</script>
				<xsl:call-template name="markisread"/>
			</head>
			<body>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div class="formtitle">
							<div style="float:left" class="title">
								<font><xsl:value-of select="$doctype"/>&#xA0;<xsl:value-of select="document/captions/createdate/@caption"/>&#xA0;<xsl:value-of select="document/fields/finishdate"/></font><span id="whichreadblock">Прочтен</span>
							</div>
						</div>	
						<div class="button_panel">
							<span style="vertical-align:12px; float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="get_document_accesslist"/>
								<xsl:call-template name="save"/>
								 <xsl:if test="//actionbar/action[@id='NEW_DOCUMENT']/@mode= 'ON'">
									<button  class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" title="{//actionbar/action[@id='NEW_DOCUMENT']/@title}" >
										<xsl:attribute name="onclick">location.href='Provider?type=edit&amp;element=document&amp;id=task&amp;docid=&amp;parentdocid=<xsl:value-of select="document/fields/parentdocid"/>&amp;parentdoctype=<xsl:value-of select="document/fields/parentdoctype"/>'</xsl:attribute>
										<span>
											<img src="/SharedResources/img/classic/icons/page_white.png" class="button_img"/>
											<font class="button_text">
												<xsl:value-of select="//actionbar/action[@id='NEW_DOCUMENT']/@caption"/>
											</font>
										</span>
									</button>
								</xsl:if>
							</span>
							<span style="float:right">
				            	<xsl:call-template name="cancelwithjson"/>
				            </span>
		           		</div>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1"><xsl:value-of select="document/captions/properties/@caption"/></a>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-2"><xsl:value-of select="document/captions/attachments/@caption"/></a>
									<img id="loading_attach_img" style="vertical-align:-8px; margin-left:-10px; padding-right:3px; visibility:hidden" src="/SharedResources/img/classic/ajax-loader-small.gif"></img>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-3"><xsl:value-of select="document/captions/additional/@caption"/></a>
								</li>
								<span style="float:right; font-size:11px; font-weight:normal;">
									<b class="text"><xsl:value-of select="document/captions/author/@caption"/>: </b> 
									<font class="text" style="padding-right:7px;"><xsl:value-of select="document/fields/author"/></font>
									<xsl:if test="document/fields/isold = '1'">
										<font class="text">
											Устаревший
										</font>
									</xsl:if>
								</span>
							</ul>
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded"> 				
									<div display="block"  id="property">
										<br/>
										<table width="100%" border="0">
										<tr>
											<td class="fc">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/executor/@caption"/> : 
												</font>
												<xsl:if test="$editmode ='edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','true','executor','frm', 'intexecutbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="intexecuttbl">
													<tr>
														<td class="td_noteditable" style="width:600px;">
															<xsl:value-of select="document/fields/executor"/>&#xA0;
														</td>
													</tr>
												</table>
												<input type="hidden" id="executor" name="executor" value="{document/fields/executor/@attrval}"/>					
												<input type="hidden" id="executorcaption" value="{document/captions/executor/@caption}"/>					
											</td>
										</tr>
										<xsl:if test="document/fields/grandpardocid !=''">
											<tr>
												<td class="fc">
													<font style="vertical-align:top">
														Головной документ :
													</font>
												</td>
												<td>
													<a href="" class="doclink">
														<xsl:attribute name="href">Provider?type=document&amp;id=<xsl:value-of select="document/fields/grandparform"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/></xsl:attribute>
														<font>
															<xsl:value-of select="document/captions/pdocviewtext/@caption"/>
														</font>
													</a>
													<xsl:if test="$filename!=''">
														<a href="">
															<xsl:attribute name="href">Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
															<img src="/SharedResources/img/classic/icons/attach.png" style="margin-left:5px"/>
														</a>
													</xsl:if>
												</td>
											</tr>
										</xsl:if>
										<!-- Дата исполнения -->
										<tr>
											<td class="fc"><xsl:value-of select="document/captions/finishdate/@caption"/> :</td>
											<td>
												<input type="text" name="finishdate" value="{document/fields/finishdate}" readonly="readonly" id="finishdate" class="td_noteditable" style="width:150px;"/>
											</td>
										</tr>
										<!-- Содержание отчета -->
										<tr>
												<td class="fc">
													<xsl:value-of select="document/captions/report/@caption"/> :
												</td>							
												<td>
													<div>
														<textarea name="report" id="report" style="width:760px; margin-top:8px; margin-bottom:15px" rows="15" onfocus="fieldOnFocus(this)" onblur="fieldOnBlur(this)" tabindex="1" class="textarea_editable">
															<xsl:if test="document/@editmode != 'edit'">
																<xsl:attribute name="onfocus">javascript:$(this).blur()</xsl:attribute>
																<xsl:attribute name="class">textarea_noteditable</xsl:attribute>
															</xsl:if>	
															<xsl:if test="document/@editmode = 'edit'">
																<xsl:attribute name="onfocus">javascript:fieldOnFocus(this)</xsl:attribute>
																<xsl:attribute name="onblur">javascript:fieldOnBlur(this)</xsl:attribute>
																<xsl:attribute name="onkeydown">javascript:resetquickanswerbutton()</xsl:attribute>
															</xsl:if>	
															<xsl:value-of select="document/fields/report"/>
														</textarea>	
														<xsl:if test="document/@editmode = 'edit'">	
															<br/>
															<a href="javascript:$.noop()" class="button-auto-value">
																<xsl:attribute name ="title"><xsl:value-of select ="document/captions/executed/@caption"/></xsl:attribute>
																<xsl:attribute name="onclick">javascript:addquickanswer('report','<xsl:value-of select ="document/captions/executed/@caption"/>',this)</xsl:attribute>
																<xsl:attribute name="onmouseover">javascript:previewquickanswer('report','<xsl:value-of select ="document/captions/executed/@caption"/>',this)</xsl:attribute>
																<xsl:attribute name="onmouseout">javascript:endpreviewquickanswer('report','<xsl:value-of select ="document/captions/executed/@caption"/>',this)</xsl:attribute>
																<xsl:value-of select ="document/captions/executed/@caption"/>
															</a>
															
															<a href="javascript:$.noop()" class="button-auto-value" style="margin-left:10px">
																<xsl:attribute name ="title"><xsl:value-of select ="document/captions/noted/@caption"/></xsl:attribute>
																<xsl:attribute name="onclick">javascript:addquickanswer('report','<xsl:value-of select ="document/captions/noted/@caption"/>',this)</xsl:attribute>
																<xsl:attribute name="onmouseover">javascript:previewquickanswer('report','<xsl:value-of select ="document/captions/noted/@caption"/>',this)</xsl:attribute>
																<xsl:attribute name="onmouseout">javascript:endpreviewquickanswer('report','<xsl:value-of select ="document/captions/noted/@caption"/>',this)</xsl:attribute>
																<xsl:value-of select ="document/captions/noted/@caption"/>
															</a>					
														</xsl:if>							
													</div>
												</td>
											</tr>
					                    <!--  Поле "код" 
					                    <xsl:if test="document/@status != 'new'">
											<tr>
												<td class="fc">
													<xsl:value-of select="document/captions/ndelo/@caption"/> :
												</td>
								        		<td>
					                    			<input type="text" name="ndelo" size="10" class="td_editable" value="{document/fields/ndelo}" style="width:150px;">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
															<xsl:attribute name="readonly">readonly</xsl:attribute>
														</xsl:if>
													</input>
					                        	</td>   					
											</tr>
										</xsl:if>
									-->
										<!-- Поле "Номенклатура дел" -->						
										<tr >
											<td class="fc" style ="padding:10px">
												<font style="vertical-align:top;">
													<xsl:value-of select="document/captions/nomentype/@caption"/> : 
												</font>
												<xsl:if test="$editmode ='edit'">
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('n','false','nomentype','frm', 'nomentypetbl');</xsl:attribute>								
														<img src="/SharedResources/img/iconset/report_magnify.png"/>			
													</a>
												</xsl:if>
											</td>
											<td>
												<table id="nomentypetbl">
													<tr>
														<td class="td_editable" style="width:600px;">
															<xsl:if test="$editmode != 'edit'">
																<xsl:attribute name="class">td_noteditable</xsl:attribute>
															</xsl:if>
															<xsl:value-of select="document/fields/nomentype"/>&#xA0;
														</td>
													</tr>
												</table>
												<input type="hidden" id="nomentype" name="nomentype" value="{document/fields/nomentype/@attrval}"/>
												<input type="hidden" id="nomentypecaption" value="{document/fields/nomentype/@caption}"/>
											</td>
										</tr>
					 				</table>
					 				<br/>
								</div>
								<input type="hidden" name="author" value="{document/fields/author/@attrval}"/> 
								<input type="hidden" name="type" value="save"/>  
								<input type="hidden" name="id" value="{@id}"/>
								<input type="hidden" name="key" value="{document/@docid}"/>
								<input type="hidden" name="doctype" value="{document/@doctype}"/>
								<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
								<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
								<xsl:if test="document/@status ='new'">
					           		<input type="hidden" name="ndelo" value="{document/fields/ndelo}"/>
					            </xsl:if>
							</form>
						</div>
						<div id="tabs-2">
							<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
								<input type="hidden" name="type" value="rtfcontent"/>
								<input type="hidden" name="formsesid" value="{formsesid}"/>
								<div display="block" id="att">
									<br/>	
									<xsl:call-template name="attach"/>
								</div>
							</form>
				        </div>
			           <div id="tabs-3">
							<xsl:call-template name="docinfo"/>
						</div>
           			</div>
           			<div style="height:10px"/>
			  		</div>
				</div>
				<xsl:call-template name="formoutline"/>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>