<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="docInfo">
		<span style="float:right; font-size:11px"> 
			<xsl:value-of select="document/captions/docauthor/@caption"/>: 
			<font style="font-weight:normal;"><xsl:value-of select="document/fields/docauthor"/></font>
			<input type="hidden" name="docauthor" value="{document/fields/docauthor/@attrval}"/>
				&#xA0;&#xA0;
			<xsl:value-of select="document/captions/docdate/@caption"/>: 
			<font style="font-weight:normal;"><xsl:value-of select="document/fields/docdate"/></font>
			<input type="hidden" name="docdate" value="{document/fields/docdate}" />
			<xsl:if test="document/@status = 'existing'">
				<xsl:if test="@id='demand' or @id = 'ki'">
					<font style="font-weight:bold; margin-left:10px"><xsl:value-of select="document/captions/control/@caption" />: </font>
					<xsl:if test="document/fields/allcontrol = '1'">
						<font style="font-weight:normal; color:red"><xsl:value-of select="document/captions/incontrol/@caption" /></font>
					</xsl:if>
					<xsl:if test="document/fields/allcontrol = '0'">
						<font style="font-weight:normal;"><xsl:value-of select="document/captions/controlisreset/@caption" /></font>
					</xsl:if>
				</xsl:if>
			</xsl:if>
		</span>	
	</xsl:template>
	
	<xsl:template name="htmlareaeditor">
		<!--<script type="text/javascript">  -->
			<!--$(function() {-->
        		<!--//$("textarea").htmlarea(); -->
	        	<!--$("#txtDefaultHtmlArea").htmlarea({-->
	        	<!--toolbar: [-->
        <!--["html"], ["bold", "italic", "underline","strikethrough"],["subscript","superscript"],["indent","outdent"],["decreasefontsize","increasefontsize"],["orderedlist","unorderedlist"],["justifyleft","justifycenter","justifyright"],-->
        <!--["p","h1", "h2", "h3", "h4", "h5", "h6"],["horizontalrule"]-->
    <!--]}-->
	        	<!--); // Initialize jHtmlArea's with all default values-->
           		<!--$("#btnRemoveCustomHtmlArea").click(function() {-->
            		<!--$("#txtCustomHtmlArea").htmlarea("dispose");-->
           		<!--});-->
        	<!--});-->
		<!--</script>-->
        <script type="text/javascript">
            $(document).ready(function($) {
            CKEDITOR.replace( 'txtDefaultHtmlArea',{});
            CKEDITOR.config.width = "620px"
            CKEDITOR.config.height = "285px"
            });
        </script>
	</xsl:template>

	<!-- Набор javascript библиотек -->
	<xsl:template name="cssandjs">
		<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
		<link type="text/css" rel="stylesheet" href="classic/css/form.css"/>
		<link type="text/css" rel="stylesheet" href="classic/css/actionbar.css"/>
		<link type="text/css" rel="stylesheet" href="classic/css/dialogs.css"/>
		<link rel="Stylesheet" type="text/css" href="/SharedResources/jquery/js/jhtmlarea/style/jHtmlArea.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
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
		<script type="text/javascript" src="classic/scripts/form.js"/>
		<script type="text/javascript" src="classic/scripts/coord.js"/>
		<script type="text/javascript" src="classic/scripts/dialogs.js"/>
		<script type="text/javascript" src="classic/scripts/outline.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
        <script type="text/javascript" src="/SharedResources/jquery/js/ckeditor/ckeditor.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
		<script>
			cancelcaption='<xsl:value-of select="document/captions/cancel/@caption"/>'
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
			lang='<xsl:value-of select="@lang"/>';
			redirectAfterSave = '<xsl:value-of select="history/entry[@type eq 'page'][last()]"/>'
			documentsavedcaption = '<xsl:value-of select="document/captions/documentsavedcaption/@caption"/>';
			attention = '<xsl:value-of select="document/captions/attention/@caption"/>';
			notifyofnewimplement = '<xsl:value-of select="document/captions/notifyofnewimplement/@caption"/>';
			cancel = '<xsl:value-of select="document/captions/cancel/@caption"/>';
			notify = '<xsl:value-of select="document/captions/notify/@caption"/>';
			removefromcontrol = '<xsl:value-of select="document/captions/removefromcontrol/@caption"/>';
			removedcaption ='<xsl:value-of select="document/captions/removedcaption/@caption"/>';
			removedfromcontrol='<xsl:value-of select="document/captions/removedfromcontrol/@caption"/>';
			projects='<xsl:value-of select="document/captions/projects/@caption"/>';
			read = '<xsl:value-of select="document/captions/read/@caption"/>';
			notread = '<xsl:value-of select="document/captions/notread/@caption"/>';
			addcommentforattachment = '<xsl:value-of select="document/captions/addcommentforattachment/@caption"/>';
			addcomment = '<xsl:value-of select="document/captions/addcomment/@caption"/>';
			showfilename = '<xsl:value-of select="document/captions/showfilename/@caption"/>';
			delete_file = '<xsl:value-of select="document/captions/delete_file/@caption"/>';
			pleasewaitdocsave= '<xsl:value-of select="document/captions/pleasewaitdocsave/@caption"/>';
			removedcaption= '<xsl:value-of select="document/captions/removedcaption/@caption"/>';
		</script>
		<script type="text/javascript">    
			$(function() {
				$("#tabs").tabs();
				$("button").button();
			});
    	</script>
	</xsl:template>

	<xsl:template name="documentheader">
		<div style="position:absolute;  top:0px; left:0px; width:100%; height:70px; border-bottom:1px solid rgba(190,213,224,0.89); background:url('classic/img/blue_background.jpg'); z-index:2">
 			<span style="float:left">
		     	<img src="/SharedResources/logos/khowledgeBase.png" style="margin:12px 0px 0px 10px"/> 
			</span>
	     	 
			<span style="float:left; margin:15px 0 0 0px">
				<font style="font-size:1.6em; color:#404040; padding-left: 10px">KnowledgeBase</font>
				<font style="font-size:1em; color:#595959; margin-left:10px;">
					<xsl:value-of select="document/page/captions/app_title/@caption"/>
				</font>
			</span>
			<span style="float:right; padding:5px 5px 5px 0px">
				<a id="currentuser" href="Provider?type=edit&amp;element=userprofile&amp;id=userprofile" style="color: #555555 ; font: 11px Tahoma; font-weight:bold;">
					<xsl:attribute name="title"><xsl:value-of select ="document/captions/view_userprofile/@caption"/></xsl:attribute>
						<xsl:value-of select="@username"/>
				</a>
				<a id="logout" href="Logout" title="{document/captions/logout/@caption}" style="color: #555555 ; font: 11px Tahoma; font-weight:bold ; margin:0 5px 0 10px">
					<xsl:value-of select="document/captions/logout/@caption"/>
				</a>
<!-- 				<a id="helpbtn" href="Provider?type=static&amp;id=help_summary" title="{document/captions/help/@caption}" style="color: #555555 ; font: 11px Tahoma; font-weight:bold ; margin-left:15px"> -->
<!-- 					<xsl:value-of select="document/captions/help/@caption"/>  -->
<!-- 				</a> -->
			</span>
		</div>
	</xsl:template>

	<xsl:template name="ECPsignFields">
		<!-- <input type="hidden" name="sign" id="sign" value="{sign}" style="width:100%;" />
		<input type="hidden" name="signedfields" id="signedfields" value="{signedfields}" style="width:100%;" />
		 <APPLET CODE="kz.gamma.TumarCSP" NAME="edsApplet"  type="application/x-java-applet" ARCHIVE="/edsApplet/lib/sign-applet.jar,/edsApplet/lib/commons-logging.jar,/edsApplet/lib/xmlsec-1.3.0.jar,/edsApplet/lib/crypto.gammaprov.jar,/edsApplet/lib/sign-applet.jar,/edsApplet/lib/crypto.tsp.jar" HEIGHT="100" WIDTH="100">
			<param name="ARCHIVE" value="/edsApplet/lib/sign-applet.jar,/edsApplet/lib/commons-logging.jar,/edsApplet/lib/xmlsec-1.3.0.jar,/edsApplet/lib/crypto.gammaprov.jar,/edsApplet/lib/sign-applet.jar,/edsApplet/lib/crypto.tsp.jar"/>
		</APPLET> 

		<xsl:if test="document/@canbesign='1111'">
			<script type="text/javascript" src="/edsApplet/js/jquery.blockUI.js" charset="utf-8"></script>
        	<script type="text/javascript" src="/edsApplet/js/crypto_object.js" charset="utf-8"></script>
        	<script type="text/javascript">
				edsApp.init();
			</script>
		</xsl:if> -->
	</xsl:template>
	
	<xsl:template name="markisread">
		<xsl:if test="document[@isread = 0][@status != 'new']">
			<script>
				markRead(<xsl:value-of select="document/@doctype"/>, <xsl:value-of select="document/@docid"/>);
			</script>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="docinfo">
		<table width="100%" border="0">
			<tr>
				<td class="fc">
					<xsl:value-of select="document/captions/statusdoc/@caption"/> :
				</td>
				<td>
					<font>
						<xsl:choose>
							<xsl:when test="document/@status='new'">
								<xsl:value-of select="document/captions/newdoc/@caption"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document/captions/saved/@caption"/>
							</xsl:otherwise>
						</xsl:choose>
					</font>		
				</td>
			</tr>
			<tr>
				<td class="fc">
					<xsl:value-of select="document/captions/permissions/@caption"/> :
				</td>
				<td>
					<font>
						<xsl:choose>
							<xsl:when test="$editmode='view'">
								<xsl:value-of select="document/captions/readonly/@caption"/>
							</xsl:when>
							<xsl:when test="$editmode='readonly'">
								<xsl:value-of select="document/captions/readonly/@caption" />
							</xsl:when>
							<xsl:when test="$editmode='edit'">
								<xsl:value-of select="document/captions/editing/@caption" />
							</xsl:when>
							<xsl:when test="$editmode='noaccess'">
								<xsl:value-of select="document/captions/readonly/@caption" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="document/captions/modenotdefined/@caption"/>
							</xsl:otherwise>
						</xsl:choose>
					</font>
				</td>
			</tr>
			<xsl:if test="document/@status !='new'">
				
				<tr>
					<td class="fc">
						<xsl:value-of select="document/captions/infofread/@caption"/> :
					</td>
					<td>
						<font>
							<xsl:choose>
								<xsl:when test="document/@isread ='1'">
									<xsl:value-of select="document/captions/read/@caption"/>
								</xsl:when>
								<xsl:otherwise> 
									<xsl:value-of select="document/captions/notread/@caption"/>
								</xsl:otherwise>
							</xsl:choose>
						</font>		
					</td>
				</tr>
				<tr>
					<td class="fc">
						<xsl:value-of select="document/captions/infofreaders/@caption"/> :
					</td>
					<td>
						<script type="text/javascript">
							usersWhichReadInTable(this,<xsl:value-of select="document/@doctype"/>,<xsl:value-of select="document/@docid"/>)
						</script>
						<table class="table-border-gray" id="userswhichreadtbl" style="width:600px">
							<tr>
								<td style="width:350px; text-align:center">
									<font>
										<xsl:value-of select="document/captions/infofreaders/@caption"/>
									</font>
								</td>
								<td style="width:250px; text-align:center">
									<font>
										<xsl:value-of select="document/captions/readtime/@caption"/>
									</font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</xsl:if>
		</table>
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
											<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;id=getattach&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
										</img>
										<xsl:if test="$editmode = 'edit'">
											<xsl:if test="comment =''">
												<a href='' style="vertical-align:top;" title='tect'>
													<xsl:attribute name='href'>javascript:addCommentToAttach('<xsl:value-of select="$id"/>')</xsl:attribute>
													<img id="commentaddimg{$id}" src="/SharedResources/img/classic/icons/comment_add.png" style="width:16px; height:16px" >
														<xsl:attribute name ="title"><xsl:value-of select ="//document/captions/add_comment/@caption"/></xsl:attribute>
													</img>
												</a>
											</xsl:if>
											<a href='' style="vertical-align:top; margin-left:8px">
												<xsl:attribute name='href'>javascript:deleterow('<xsl:value-of select="$formsesid"/>','<xsl:value-of select='$filename'/>','<xsl:value-of select="$id"/>')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:13px; height:13px">
												<xsl:attribute name ="title"><xsl:value-of select ="//document/captions/delete_file/@caption"/></xsl:attribute>
												</img>
											</a>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<img src="/SharedResources/img/iconset/file_extension_{$extension}.png" style="margin-right:5px">
											<xsl:attribute name="onerror">javascript:changeAttIcon(this)</xsl:attribute>
										</img>
										<a style="vertical-align:5px">
											<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;id=getattach&amp;file=<xsl:value-of select='$filename'/>	</xsl:attribute>
											<xsl:value-of select='replace($filename,"%2b","+")'/>
										</a>&#xA0;&#xA0;
										<xsl:if test="$editmode = 'edit'">
											<xsl:if test="comment =''">
												<a href='' style="vertical-align:5px;">
													<xsl:attribute name='href'>javascript:addCommentToAttach('<xsl:value-of select="$id"/>')</xsl:attribute>
													<img id="commentaddimg{$id}" src="/SharedResources/img/classic/icons/comment_add.png" style="width:16px; height:16px">
														<xsl:attribute name="title"><xsl:value-of select ="//document/captions/add_comment/@caption"/></xsl:attribute>
													</img>
												</a>
											</xsl:if>
											<a href='' style="vertical-align:5px; margin-left:5px">
												<xsl:attribute name='href'>javascript:deleterow('<xsl:value-of select="$formsesid"/>','<xsl:value-of select='$filename' />','<xsl:value-of select="$id"/>')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:13px; height:13px">
													<xsl:attribute name ="title"><xsl:value-of select ="//document/captions/delete_file/@caption"/></xsl:attribute>
												</img>
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
								<xsl:value-of select="//document/captions/comments/@caption"/> : <xsl:value-of select="comment"/>
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
	
	<!-- Outline -->
	<xsl:template name="formoutline">
		<div id="outline">
			<div id="outline-container" style="width:303px; padding-top:10px">
				<xsl:for-each select="//response/content/outline">
					<div>
						<div class="treeentry" style="height:17px; padding:3px 0px 3px 0px  ; border:1px solid #F9F9F9; width:auto">								
							<img src="/SharedResources/img/classic/1/minus.png" style="margin-left:6px; cursor:pointer" alt="">
								<xsl:attribute name="onClick">javascript:ToggleCategory(this)</xsl:attribute>
							</img>
							<img src="/SharedResources/img/classic/1/folder_open_view.png" style="margin-left:5px; " alt=""/>
							<font style="font-family:arial; font-size:0.9em; margin-left:4px; vertical-align:3px">											
								<xsl:value-of select="@hint"/>
							</font>
						</div>
						<div style="clear:both;"/>
						<div class="outlineEntry" id="{@id}">
							<script>
								if	($.cookie("KnowledgeBase_<xsl:value-of select='@id'/>") != 'null'){
									$("#<xsl:value-of select='@id'/>").css("display",$.cookie("KnowledgeBase_<xsl:value-of select='@id'/>"))
									if($.cookie("KnowledgeBase_<xsl:value-of select='@id'/>") == "none"){
										$("#<xsl:value-of select='@id'/>").prev().prev().children("img:first").attr("src","/SharedResources/img/classic/1/plus.png")							
										$("#<xsl:value-of select='@id'/>").prev().prev().children("img:last").attr("src","/SharedResources/img/classic/1/folder_close_view.png")							
									}else{
										$("#<xsl:value-of select='@id'/>").prev().prev().children("img:first").attr("src","/SharedResources/img/classic/1/minus.png")							
										$("#<xsl:value-of select='@id'/>").prev().prev().children("img:last").attr("src","/SharedResources/img/classic/1/folder_open_view.png")
									}
								}
							</script>
							<xsl:for-each select="entry">
								<div class="entry treeentry" style="width:298px; padding:3px 0px 3px 0px; border:1px solid #F9F9F9; " >
									<xsl:if test="/request/@id = @id">
										<xsl:attribute name="class">entry treeentrycurrent</xsl:attribute>										
									</xsl:if>
									<xsl:if test="contains(@url, //current_outline_entry/response/content/entry/@entryid) and //current_outline_entry/response/content/entry/@entryid != '' ">
										<xsl:attribute name="class">entry treeentrycurrent</xsl:attribute>										
									</xsl:if>
									<xsl:if test="@id = 'demands'">
										<img src="/SharedResources/img/classic/1/minus.png" style="margin-left:35px; cursor:pointer; float:left" alt="">
											<xsl:attribute name="onClick">javascript:ToggleCategory(this)</xsl:attribute>
										</img>
									</xsl:if>
									<a href="{@url}" style="width:90%; vertical-align:top; text-decoration:none !important;" title="{@hint}">
										<div class="viewlink">
											<xsl:if test="/request/@id = @id">
												<xsl:attribute name="class">viewlink_current</xsl:attribute>										
											</xsl:if>
											<xsl:if test="contains(@url, //current_outline_entry/response/content/entry/@entryid) and //current_outline_entry/response/content/entry/@entryid != '' ">
												<xsl:attribute name="class">viewlink_current</xsl:attribute>										
											</xsl:if>
											<xsl:if test="@id = 'demands'">
												<xsl:attribute name="style">width:80%;</xsl:attribute>
											</xsl:if>	
											<div style="padding-left:35px; white-space:nowrap">
												<xsl:if test="@id = 'demands'">
													<xsl:attribute name="style">padding-left:5px; white-space:nowrap</xsl:attribute>
												</xsl:if>
												<xsl:if test="@id !='favdocs' and (@id != 'recyclebin')">
													<img src="/SharedResources/img/classic/1/doc_view.png" style="cursor:pointer"/>
												</xsl:if>
												<xsl:if test="@id ='favdocs'">
													<img src="/SharedResources/img/iconset/star_full.png" height="17px" style="cursor:pointer"/>
												</xsl:if>
												<xsl:if test="@id ='recyclebin'">
													<img src="/SharedResources/img/iconset/bin.png" height="17px" style="cursor:pointer"/>
												</xsl:if>													 
												<font class="viewlinktitle">												
													 <xsl:value-of select="@caption"/>										
												</font>
											</div>
										</div>
									</a>
								</div>
								<div style="clear:both;"/>
								<div class="outlineEntry" id="{@id}">
									<script>
										if	($.cookie("KnowledgeBase_<xsl:value-of select='@id'/>") != 'null'){
											$("#<xsl:value-of select='@id'/>").css("display",$.cookie("KnowledgeBase_<xsl:value-of select='@id'/>"))
											if($.cookie("KnowledgeBase_<xsl:value-of select='@id'/>") == "none"){
												$("#<xsl:value-of select='@id'/>").prev().prev().children("img:first").attr("src","/SharedResources/img/classic/1/plus.png")							
											}else{
												$("#<xsl:value-of select='@id'/>").prev().prev().children("img:first").attr("src","/SharedResources/img/classic/1/minus.png")							
											}
										}
									</script>
									<xsl:for-each select="entry">
										<div class="entry treeentry" style="width:298px; padding:3px 0px 3px 15px; border:1px solid #F9F9F9; " >
											<xsl:if test="/request/@id = @id">
												<xsl:attribute name="class">entry treeentrycurrent</xsl:attribute>										
											</xsl:if>
											<xsl:if test="contains(@url, /request/page/outline/page/current_outline_entry/response/content/entry/@entryid) and /request/page/outline/page/current_outline_entry/response/content/entry/@entryid != '' ">
												<xsl:attribute name="class">entry treeentrycurrent</xsl:attribute>										
											</xsl:if>
											<a href="{@url}" style="width:90%; vertical-align:top; text-decoration:none !important" title="{@hint}">
												<div class="viewlink">
													<xsl:if test="/request/@id = @id">
														<xsl:attribute name="class">viewlink_current</xsl:attribute>										
													</xsl:if>	
													<xsl:if test="contains(@url, /request/page/outline/page/current_outline_entry/response/content/entry/@entryid) and /request/page/outline/page/current_outline_entry/response/content/entry/@entryid != '' ">
														<xsl:attribute name="class">viewlink_current</xsl:attribute>										
													</xsl:if>	
													<div style="padding-left:55px; white-space:nowrap">
														<xsl:if test="@id !='favdocs' and (@id != 'recyclebin')">
															<img src="/SharedResources/img/classic/1/doc_view.png" style="cursor:pointer"/>
														</xsl:if>
														<xsl:if test="@id ='favdocs'">
															<img src="/SharedResources/img/iconset/star_full.png" height="17px" style="cursor:pointer"/>
														</xsl:if>
														<xsl:if test="@id ='recyclebin'">
															<img src="/SharedResources/img/iconset/bin.png" height="17px" style="cursor:pointer"/>
														</xsl:if>													 
														<font class="viewlinktitle">												
															 <xsl:value-of select="@caption"/>										
														</font>
													</div>
												</div>
											</a>
										</div>
									</xsl:for-each>
								</div>
							</xsl:for-each>
						</div>
					</div>
				</xsl:for-each>
			</div>
		</div>
		<div id="resizer" style="position:absolute; top: 80px; left:1px; background:#E6E6E6; width:12px; bottom:0px; border-radius: 0 6px 6px 0; border: 1px solid #adadad; border-left: ; cursor:pointer" onclick="javascript: openformpanel()">
			<span  id="iconresizer" class="ui-icon ui-icon-triangle-1-e" style="margin-left:-2px; position:relative; top:49%"></span>
		</div>
	</xsl:template>
	
	
	<xsl:template name="import">
		<div id="attach" style="display:block;">
			<table style="border:0; border-collapse:collapse" id="upltable" width="99%">
				<xsl:if test="document/@editmode = 'edit'">
					<tr>
						<td class="fc">
							<xsl:value-of select="document/captions/attachments/@caption"/> :
						</td>
						<td>
							<input type="file" id="fname" size="60" border="#CCC" name="fname"/>
							&#xA0;
							<a id="upla">
								<xsl:attribute name="href">javascript:uploadFile('upload', 'fname')</xsl:attribute>
								<font style="font-size:13px">
									<xsl:value-of select="document/captions/attach/@caption"/>
								</font> 
							</a>
						</td>
						<td></td>
					</tr>
				</xsl:if>
			</table>
			 <div id="editor" ></div>
			<br/>
			<br/>
		</div>
	</xsl:template>
	<xsl:template name="hotkeys">
		<script type="text/javascript">
				$(document).bind('keydown', function(e){
 					if (e.ctrlKey) {
 						switch (e.keyCode) {
						   case 66:
						   		<!-- клавиша b -->
						     	e.preventDefault();
						     	$("#canceldoc").click();
						      	break;
						   case 83:
						   		<!-- клавиша s -->
						     	e.preventDefault();
						     	$("#btnsavedoc").click();
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
				      	   case 82:
							   <!-- r -->
							    e.preventDefault();
						     	$("#btnaddsubdoc").click();
						      	break; 
						   default:
						      	break;
						}
   					}
				});
			<![CDATA[
				jQuery(document).ready(function(){
					jQuery("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
					$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
					jQuery("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
					$("#logout").hotnav({keysource:function(e){ return "q"; }});
					$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
					$("#btnaddsubdoc").hotnav({keysource:function(e){ return "r"; }});
			});
			]]>
		</script>
	</xsl:template>
</xsl:stylesheet>