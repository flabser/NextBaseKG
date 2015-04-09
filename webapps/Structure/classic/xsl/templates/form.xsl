<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="doctitleBoss">
		<font><xsl:value-of select="concat($doctype,' - ',document/fields/fullname)"/></font>	
	</xsl:template>
	
	<xsl:template name="doctitleGlossary">
		<font>
			<xsl:value-of select="concat($doctype,' - ',document/fields/name)"/>
		</font>	
	</xsl:template>
	
	<xsl:template name="keypressactions">
		<script>
			$(document).bind('keydown', 'Ctrl+s',function (event){
				<xsl:if test="document/@editmode = 'edit'">
					if (event.ctrlKey) {
    					if (event.keyCode ==83 ){
    						javascript:SaveFormJquery('frm','frm','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/Workflow/')"/>');
    					}
    				}
    			</xsl:if>
    			if (event.ctrlKey &amp;&amp; event.shiftKey) {
    				if (event.keyCode ==49 ){
    					javascript:openXMLdoc();
    				}
				}
			});
		</script>
	</xsl:template>
	
	<xsl:template name="htmlareaeditor">
		<script type="text/javascript">  
			$(function() {
        		//$("textarea").htmlarea(); 
	        	$("#txtDefaultHtmlArea").htmlarea(); // Initialize jHtmlArea's with all default values
           		$("#btnRemoveCustomHtmlArea").click(function() {
            		$("#txtCustomHtmlArea").htmlarea("dispose");
           		});
        	});
		</script>
	</xsl:template>

	<!-- Набор javascript библиотек -->
	<xsl:template name="cssandjs">
		<link type="text/css" rel="stylesheet" href="classic/css/main.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="classic/css/form.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="classic/css/actionbar.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="classic/css/dialogs.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
		<link type="text/css" rel="Stylesheet" media="screen" href="/SharedResources/jquery/js/tiptip/tipTip.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/jquery-tokeninput/loopj-jquery-tokeninput-201d2d1/styles/token-input-facebook.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/jquery-tokeninput/loopj-jquery-tokeninput-201d2d1/styles/token-input.css"/>
		<link rel="Stylesheet" type="text/css" href="/SharedResources/jquery/js/jhtmlarea/style/jHtmlArea.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.slider.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.progressbar.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.autocomplete.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.tabs.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.button.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/jquery-tokeninput/loopj-jquery-tokeninput-201d2d1/src/jquery.tokeninput.js" charset="UTF-8"/>
		<script type="text/javascript" src="classic/scripts/form.js?ver=3" charset="UTF-8"/>
		<script type="text/javascript" src="classic/scripts/coord.js?ver=3" charset="UTF-8"/>
		<script type="text/javascript" src="classic/scripts/dialogs.js?ver=3" charset="UTF-8"/>
		<script type="text/javascript" src="classic/scripts/outline.js?ver=3" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/jhtmlarea/scripts/jHtmlArea-0.7.0.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js" charset="UTF-8"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/tiptip/jquery.tipTip.js"/>
		<script>
			cancelcaption='<xsl:value-of select="document/captions/cancel/@caption"/>'
			docfilter='<xsl:value-of select="document/captions/docfilter/@caption"/>'
			changeviewcaption='<xsl:value-of select="document/captions/changeview/@caption"/>'
			receiverslistcaption='<xsl:value-of select="document/captions/receiverslist/@caption"/>'
			commentcaption='<xsl:value-of select="document/captions/commentcaption/@caption"/>'
			correspforacquaintance='<xsl:value-of select="document/captions/correspforacquaintance/@caption"/>'
			searchcaption='<xsl:value-of select="document/captions/searchcaption/@caption"/>'
			contributorscoord='<xsl:value-of select="document/captions/contributorscoord/@caption"/>'
			type='<xsl:value-of select="document/captions/type/@caption"/>'
			parcoord='<xsl:value-of select="document/captions/parcoord/@caption"/>'
			sercoord='<xsl:value-of select="document/captions/sercoord/@caption"/>'
			waittime='<xsl:value-of select="document/captions/waittime/@caption"/>'
			coordparam='<xsl:value-of select="document/captions/coordparam/@caption"/>'
			hours='<xsl:value-of select="document/captions/hours/@caption"/>'
			yescaption='<xsl:value-of select="document/captions/yescaption/@caption"/>'
			nocaption='<xsl:value-of select="document/captions/nocaption/@caption"/>'
			warning='<xsl:value-of select="document/captions/warning/@caption"/>'
			documentsavedcaption = '<xsl:value-of select="document/captions/documentsavedcaption/@caption"/>';
			documentmarkread = '<xsl:value-of select="document/captions/documentmarkread/@caption"/>';
			pleasewaitdocsave = '<xsl:value-of select="document/captions/pleasewaitdocsave/@caption"/>';
			docissign = '<xsl:value-of select="document/captions/docissign/@caption"/>';
			docisrejected = '<xsl:value-of select="document/captions/docisrejected/@caption"/>';
			dociscoordyou = '<xsl:value-of select="document/captions/dociscoordyou/@caption"/>';
			docisrejectedyou = '<xsl:value-of select="document/captions/docisrejectedyou/@caption"/>';
			saving = '<xsl:value-of select="document/captions/saving/@caption"/>';
			lang='<xsl:value-of select="@lang"/>';
			redirectAfterSave = '<xsl:value-of select="history/entry[@type eq 'view'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>'
		</script>
		<script type="text/javascript">    
			$(function(){
				$("#tabs").tabs();
				$("button").button();
			});
    	</script>
	</xsl:template>

	<xsl:template name="formoutline">
		<div id="outline">
			<div id="outline-container" style="width:300px; padding-top:10px">
				<xsl:for-each select="document/outline/entry">
					<div  style="">
						<div class="treeentry" style="height:17px; padding:3px 0px 3px 0px  ; border:1px solid #F9F9F9; width:290px">								
							<img src="/SharedResources/img/classic/1/minus.png" style="margin-left:6px; cursor:pointer">
								<xsl:attribute name="onClick">javascript:ToggleCategory(this)</xsl:attribute>
							</img>
							<img src="/SharedResources/img/classic/1/folder_open_view.png" style="margin-left:5px;"/>
							<font style="font-family:arial; font-size:0.9em; margin-left:4px; vertical-align:3px">											
								<xsl:value-of select="@hint"/>
							</font>
						</div>
						<div style="clear:both;"/>
							<div class="outlineEntry">
								<xsl:for-each select="entry">
									<div class="entry treeentry" style="width:290px; padding:3px 0px 3px 0px; border:1px solid #F9F9F9;">
										<div class="viewlink" style="height:18px; ">
											<xsl:if test="@current = '1' or /request/@id = @id">
												<xsl:attribute name="class">viewlink_current</xsl:attribute>										
											</xsl:if>	
											<div style="float:left;">
												<img src="/SharedResources/img/classic/1/doc_view.png" style="margin-left:42px; cursor:pointer"/>
												<a href="{@url}" style="width:90%; vertical-align:top; text-decoration:none !important">
													<xsl:if test="../@id = 'filters'">
														<xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;filterid=<xsl:value-of select="@id"/></xsl:attribute>
													</xsl:if>
													<font class="viewlinktitle">	
														 <xsl:value-of select="@caption"/>
													</font>
												</a>
											</div>
											<xsl:if test="../@id = 'mydocs'">
												<span style=" text-align:left; float:right;">
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
		<div id="resizer" style="position:absolute; top: 80px; left:1px; background:#E6E6E6; width:12px; bottom:0px; border-radius: 0 6px 6px 0; border: 1px solid #adadad; cursor:pointer" onclick="javascript:openformpanel()">
			<span id="iconresizer" class="ui-icon ui-icon-triangle-1-e" style="margin-left:-2px; position:relative; top:49%"/>
		</div>
	</xsl:template>
	
	<xsl:template name="documentheader">
		<div style="position:absolute; top:0px; left:0px; width:100%; background:url(classic/img/yellow_background.jpg); height:70px; border-bottom:1px solid #fcdd76; z-index:2">
			<span style="float:left">
				<img src="/SharedResources/logos/structure_small.png" style="margin:5px 5px 0px 10px"/>
				<font style="font-size:1.5em; vertical-align:20px; color:#555555; margin-left:5px">4MS</font>
				<font style="font-size:1em; vertical-align:20px; color:#555555; margin-left:5px"> Structure </font>
			</span>
			<span style="float:right; padding:5px 5px 5px 0px">
				<a target="_parent" id="currentuser" title="{document/captions/view_userprofile/@caption}" href="Provider?type=edit&amp;element=userprofile&amp;id=userprofile" style="text-decoration:none; color:#555555; font:11px Tahoma; font-weight:bold">
					<font>
						<xsl:value-of select="@username"/>
					</font>
				</a>
				<a target="_parent" id="logout" href="Logout" title="{document/captions/logout/@caption}" style="text-decoration:none; color:#555555; font:11px Tahoma; font-weight:bold">
					<font style="margin-left:20px;"><xsl:value-of select="document/captions/logout/@caption"/></font> 
				</a>
				<a target="_parent"  id="helpbtn" href="/Help/Provider?type=page&amp;id=article" title="{document/captions/help/@caption}" style="text-decoration:none; color:#555555; font:11px Tahoma; font-weight:bold">
					<font style="margin-left:20px;"><xsl:value-of select="document/captions/help/@caption"/></font> 
				</a>
			</span>
		</div>
	</xsl:template>

	<xsl:template name="ECPsignFields">
		<input type="hidden" name="sign" id="sign" value="{sign}" style="width:100%;" />
		<input type="hidden" name="signedfields" id="signedfields" value="{signedfields}" style="width:100%;" />
		<!-- <APPLET CODE="kz.flabs.eds.applet.EDSApplet" NAME="edsApplet" ARCHIVE="eds.jar, commons-codec-1.3.jar" HEIGHT="1" WIDTH="1">
			<param name="ARCHIVE" value="/eds.jar, /commons-codec-1.3.jar" />
		</APPLET> -->

		<xsl:if test="document/@canbesign='1111'">
			<script type="text/javascript" src="/edsApplet/js/jquery.blockUI.js" charset="utf-8"></script>
        	<script type="text/javascript" src="/edsApplet/js/crypto_object.js" charset="utf-8"></script>
        	<script type="text/javascript">
				edsApp.init();
			</script>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="markisread">
		<xsl:if test="document[@isread = 0][@status != 'new']">
			<script>
				markRead(<xsl:value-of select="document/@doctype"/>, <xsl:value-of select="document/@docid"/>);
			</script>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="attach">
		<div id="attach" style="display:block;">
			<table style="border:0; border-collapse:collapse" id="upltable" width="99%">
				<xsl:if test="$editmode = 'edit'">
					<tr>
						<td class="fc">
							<xsl:value-of select="document/captions/attachments/@caption"/>:
						</td>
						<td>
							<input type="file" size="60" border="#CCC" name="fname">
								<xsl:attribute name="onchange">javascript:submitFile('upload', 'upltable', 'fname'); ajaxFunction()</xsl:attribute>
							</input>&#xA0;
							<!-- <a id="upla" style="margin-left:5px; border-bottom:1px dotted; text-decoration:none; color:#1A3DC1;">
								<xsl:attribute name="href">javascript:submitFile('upload', 'upltable', 'fname');ajaxFunction()</xsl:attribute>
								<xsl:value-of select="document/captions/attach/@caption"/>
							</a> -->
							<br/>
							<style>.ui-progressbar .ui-progressbar-value { background-image: url(/SharedResources/jquery/css/base/images/pbar-ani.gif); }</style>
							<div id="progressbar" style="width:370px; margin-top:5px; height:12px"></div>
							<div id="progressstate" style="width:370px; display:none">
								<font style="visibility:hidden; color:#999; font-size:11px; width:70%" id="readybytes"></font>
								<font style="visibility:hidden; color:#999; font-size:11px; float:right;" id="percentready"></font>
								<font style="visibility:hidden; text-align:center; color:#999; font-size:11px; width:30%; text-align:center" id="initializing">Подготовка к загрузке</font>
							</div>
						</td>
						<td></td>
					</tr>
				</xsl:if>
				<xsl:variable name='docid' select="document/@docid"/>
				<xsl:variable name='doctype' select="document/@doctype"/>
				<xsl:variable name='formsesid' select="formsesid"/>
				
				<xsl:for-each select="document/fields/rtfcontent/entry">
					<tr>
						<xsl:variable name='id' select='@hash'/>
						<xsl:variable name='filename' select='@filename'/>
						<xsl:variable name="extension" select="tokenize(lower-case($filename), '\.')[last()]"/>
						<xsl:variable name="resolution"/>
						<xsl:attribute name='id' select="$id"/>
						<td class="fc"></td>
						<td colspan="2">
							<div class="test" style="width:90%; overflow:hidden; display:inline-block">
								<xsl:choose>
									<xsl:when test="$extension = 'jpg' or $extension = 'jpeg' or $extension = 'gif' or $extension = 'bmp' or $extension = 'png'">
										<img class="imgAtt" title="{$filename}" style="border:1px solid lightgray; max-width:800px; max-height:600px; margin-bottom:5px">
											<xsl:attribute name="onload">checkImage(this)</xsl:attribute>
											<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
										</img>
										<xsl:if test="$editmode = 'edit'">
											<xsl:if test="comment =''">
												<a href='' style="vertical-align:top;" title='tect'>
													<xsl:attribute name='href'>javascript:addCommentToAttach('<xsl:value-of select="$id"/>')</xsl:attribute>
													<img id="commentaddimg{$id}" src="/SharedResources/img/classic/icons/comment_add.png" style="width:16px; height:16px">
														<xsl:attribute name="title" select="//document/captions/add_comment/@caption"/>
													</img>
												</a>
											</xsl:if>
											<a href='' style="vertical-align:top; margin-left:8px">
												<xsl:attribute name='href'>javascript:deleterow('<xsl:value-of select="$formsesid"/>','<xsl:value-of select='$filename'/>','<xsl:value-of select="$id" />')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:13px; height:13px">
												<xsl:attribute name="title" select="//document/captions/delete_file/@caption"/>
												</img>
											</a>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<img src="/SharedResources/img/iconset/file_extension_{$extension}.png" style="margin-right:5px">
											<xsl:attribute name="onerror">javascript:changeAttIcon(this)</xsl:attribute>
										</img>
										<a style="vertical-align:5px">
											<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/>	</xsl:attribute>
											<xsl:value-of select='replace($filename,"%2b","+")'/>
										</a>&#xA0;&#xA0;
										<xsl:if test="$editmode = 'edit'">
											<xsl:if test="comment =''">
												<a href='' style="vertical-align:5px;">
													<xsl:attribute name='href'>javascript:addCommentToAttach('<xsl:value-of select="$id"/>')</xsl:attribute>
													<img id="commentaddimg{$id}" src="/SharedResources/img/classic/icons/comment_add.png" style="width:16px; height:16px">
														<xsl:attribute name="title" select="//document/captions/add_comment/@caption"/>
													</img>
												</a>
											</xsl:if>
											<a href='' style="vertical-align:5px; margin-left:5px">
												<xsl:attribute name='href'>javascript:deleterow('<xsl:value-of select="$formsesid"/>','<xsl:value-of select='$filename'/>','<xsl:value-of select="$id"/>')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:13px; height:13px;" title="{//document/captions/delete_file/@caption}"/>
											</a>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2" style="color:#777; font-size:12px">
							<xsl:if test="comment !=''">
								<xsl:value-of select="concat(//document/captions/comments/@caption, ' : ', comment)"/>
								<br/><br/>
							</xsl:if>
						</td>
					</tr>
				</xsl:for-each>
			</table>
			<br/>
			<br/>
		</div>
	</xsl:template>
</xsl:stylesheet>