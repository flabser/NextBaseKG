<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="doctitleGlossary">
		<font>
			<xsl:value-of select="$doctype"/> - <xsl:value-of select="document/fields/name"/>
		</font>	
	</xsl:template>
	<!-- Тип документа -->
	<xsl:template name="doctitle">
		<font>
			<xsl:value-of select="$doctype"/>&#xA0;<xsl:value-of select="document/fields/vn"/>&#xA0;<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;<xsl:value-of select="document/fields/dvn"/>
		</font>
	</xsl:template>
	
	<xsl:template name="doctitleprj">
		<font>
			<xsl:value-of select="$doctype"/>&#xA0;<xsl:value-of select="document/fields/vn"/>
			&#xA0;<xsl:value-of select="document/fields/projectdate/@caption"/>&#xA0;<xsl:value-of select="document/fields/projectdate"/>
		</font>
	</xsl:template>
	
	<xsl:template name="htmlareaeditor">
		<script type="text/javascript">  
		  $(document).ready(function($) {
       		 CKEDITOR.replace('MyTextarea',{}); 
       		 CKEDITOR.config.width = "620px"
       		 CKEDITOR.config.height = "285px"
    		});
		</script>
	</xsl:template>

	<!-- Набор javascript библиотек -->
	<xsl:template name="cssandjs">
		<link type="text/css" rel="stylesheet" href="classic/css/main.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="classic/css/form.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="classic/css/actionbar.css?ver=3"/>
		<link type="text/css" rel="stylesheet" href="classic/css/dialogs.css??ver=3"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
		<link type="text/css" rel="Stylesheet" media="screen" href="/SharedResources/jquery/js/tiptip/tipTip.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.core.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.effects.core.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.widget.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.mouse.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.slider.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.progressbar.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.autocomplete.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.draggable.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.position.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.dialog.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.tabs.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.button.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/tiptip/jquery.tipTip.js"/>
		<script type="text/javascript" src="classic/scripts/form.js?ver=3"/>
		<script type="text/javascript" src="classic/scripts/coord.js?ver=3"/>
		<script type="text/javascript" src="classic/scripts/dialogs.js?ver=3"/>
		<script type="text/javascript" src="classic/scripts/outline.js?ver=3"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ckeditor/ckeditor.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/moment.js"/>
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
			lang='<xsl:value-of select="@lang"/>';
			redirectAfterSave = '<xsl:value-of select="history/entry[@type eq 'page'][last()]"/>&amp;page=<xsl:value-of select="document/@openfrompage"/>'
			showauthor = '<xsl:value-of select="document/captions/showauthor/@caption"/>';
			showrecipient = '<xsl:value-of select="document/captions/showrecipient/@caption"/>';
			noblockcoord = '<xsl:value-of select="document/captions/noblockcoord/@caption"/>';
			nochosenblocktodelete = '<xsl:value-of select="document/captions/nochosenblocktodelete/@caption"/>';
			successfullydeleted = '<xsl:value-of select="document/captions/successfullydeleted/@caption"/>';
			choosemember = '<xsl:value-of select="document/captions/choosemember/@caption"/>';
			choosevalue = '<xsl:value-of select="document/captions/choosevalue/@caption"/>';
			alreadychosen = '<xsl:value-of select="document/captions/alreadychosen/@caption"/>';
			isrecieverofsz = '<xsl:value-of select="document/captions/isrecieverofsz/@caption"/>';
			issignerofsz = '<xsl:value-of select="document/captions/issignerofsz/@caption"/>';
			hourss = '<xsl:value-of select="document/captions/hourss/@caption"/>';
			hours = '<xsl:value-of select="document/captions/hours/@caption"/>';
			day = '<xsl:value-of select="document/captions/day/@caption"/>';
			days = '<xsl:value-of select="document/captions/days/@caption"/>';
			saving = '<xsl:value-of select="document/captions/saving/@caption"/>';
			showfilename = '<xsl:value-of select="document/captions/showfilename/@caption"/>'; 
			addcomment = '<xsl:value-of select="document/captions/add_comment/@caption"/>'; 
			removedfromcontrol = '<xsl:value-of select="document/captions/removedfromcontrol/@caption"/>';
			attention = '<xsl:value-of select="document/captions/attention/@caption"/>';
			add_comment='<xsl:value-of select="document/captions/add_comment/@caption"/>';
			addcommentforattachment='<xsl:value-of select="document/captions/addcommentforattachment/@caption"/>';
			unlimited ='<xsl:value-of select="document/captions/unlimited/@caption"/>';
			newcoord= '<xsl:value-of select="document/captions/newcoord/@caption"/>';
			delete_file= '<xsl:value-of select="document/captions/delete_file/@caption"/>';
			onlynumber= '<xsl:value-of select="document/captions/onlynumber/@caption"/>';
			choosesigner= "<xsl:value-of select="document/captions/choosesigner/@caption"/>";
			replaceCoordBlocksConfirm="<xsl:value-of select="document/captions/replacecoordblocksconfirm/@caption"/>";
			entercomment="<xsl:value-of select="document/captions/entercomment/@caption"/>";
			buttonyes="<xsl:value-of select="document/captions/yes/@caption"/>";
			buttonno="<xsl:value-of select="document/captions/no/@caption"/>";
			button_saveandclose="<xsl:value-of select="document/captions/saveclose/@caption"/>";
			button_close="<xsl:value-of select="document/captions/close/@caption"/>";
			button_cancel="<xsl:value-of select="document/captions/cancel/@caption"/>";
			$(function(){
				$("#tabs").tabs();
				$("button").button();
			});
    	</script>
	</xsl:template>

	<!-- Тип документа (для задании) -->
	<xsl:template name="isresol">
		<font>
			<xsl:choose>
				<xsl:when test="document/fields/tasktype='RESOLUTION' or document/fields/parenttasktype =''">
					<xsl:value-of select="document/captions/kr/@caption"/>
				</xsl:when>
				<xsl:when test="not(document/fields/tasktype)  and  document/@parentdocid != '' and document/@parentdoctype != 897 and  document/@parentdocid != 0">
					<xsl:value-of select="document/captions/kr/@caption"/>
				</xsl:when>
				<xsl:when test="document/@parentdocid = 0">
					<xsl:value-of select="document/captions/task/@caption"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="document/captions/kp/@caption"/>
				</xsl:otherwise>
			</xsl:choose>
			&#xA0;<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;<xsl:value-of select="document/fields/taskdate"/>
		</font>
	</xsl:template>
	
	 <xsl:template name="formoutline-section-state">
        <script>
            if($.cookie("WORKFLOW_<xsl:value-of select='@id'/>")){
                $("#<xsl:value-of select='@id'/>").css("display",$.cookie("WORKFLOW_<xsl:value-of select='@id'/>"))
                if($.cookie("WORKFLOW_<xsl:value-of select='@id'/>") == "none"){
                    $("img.<xsl:value-of select='@id'/>toogle_img").attr("src","/SharedResources/img/classic/1/plus.png")
                    $("img.<xsl:value-of select='@id'/>folder_img").attr("src","/SharedResources/img/classic/1/folder_close_view.png")
                }
            }
        </script>
    </xsl:template>
	
	<xsl:template name="formoutline">
		<div id="outline">
			<div id="outline-container" style="width:303px; padding-top:10px">
				<xsl:for-each select="//response/content/outline">
					<div>
						<div class="treeentry" style="height:17px; padding:3px 0px 3px 0px; border:1px solid #F9F9F9; width:auto">								
							<img src="/SharedResources/img/classic/1/minus.png" style="margin-left:6px; cursor:pointer">
								<xsl:attribute name="onClick">javascript:ToggleCategory(this)</xsl:attribute>
							</img>
							<img src="/SharedResources/img/classic/1/folder_open_view.png" style="margin-left:5px;"/>
							<font style="font-family:arial; font-size:0.9em; margin-left:4px; vertical-align:3px">											
								<xsl:value-of select="@hint"/>
							</font>
						</div>
						<div style="clear:both;"/>
						<div class="outlineEntry" id="{@id}">
							<xsl:call-template name="formoutline-section-state"/>
							<xsl:for-each select="entry">
								<div class="entry treeentry" style="width:298px; padding:3px 0px 3px 0px; border:1px solid #F9F9F9;">
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
												<xsl:if test="@id !='favdocs' and @id != 'recyclebin'">
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
									<xsl:call-template name="formoutline-section-state"/>
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
														<xsl:if test="@id !='favdocs' and @id != 'recyclebin'">
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
			<span id="iconresizer" class="ui-icon ui-icon-triangle-1-e" style="margin-left:-2px; position:relative; top:49%"/>
		</div>
	</xsl:template>
	
	<xsl:template name="documentheader">
		<div style="position:absolute; top:0px; left:0px; width:100%; background:url(classic/img/yellow_background.jpg); height:70px; border-bottom:1px solid #fcdd76; z-index:2">
			<span style="float:left">
				<img src="/SharedResources/logos/workflow_small.png" style="margin:5px 5px 0px 10px"/>
				<font style="font-size:1.5em; vertical-align:20px; color:#555555; margin-left:5px">Workflow</font>
				<font style="font-size:1em; vertical-align:20px; color:#555555; margin-left:5px"> документооборот </font>
			</span>
			<span style="float:right; padding:5px 5px 5px 0px">
				<a id="currentuser" title="{document/captions/view_userprofile/@caption}" href=" Provider?type=edit&amp;element=userprofile&amp;id=userprofile" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
					<font>
						<xsl:value-of select="@username"/>
					</font>
				</a>
				<a id="logout" href="Logout" title="{document/captions/logout/@caption}" style="text-decoration:none; color:#555555; font:11px Tahoma; font-weight:bold">
					<font style="margin-left:20px;"><xsl:value-of select="document/captions/logout/@caption"/></font> 
				</a>
				<a id="helpbtn" href="/Help/Provider?type=page&amp;id=article" title="{document/captions/help/@caption}" style="text-decoration:none; color:#555555; font: 11px Tahoma; font-weight:bold">
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
	
	<xsl:template name="docInfo">
		<span style="float:right; font-size:11px"> 
			<b><xsl:value-of select="document/captions/author/@caption"/></b>: 
			<font style="font-weight:normal;"><xsl:value-of select="document/fields/author"/></font>
		</span>	
	</xsl:template>
	
	
	<xsl:template name="docinfo">
		<br/>
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
							 <xsl:when test="/request/document/fields/control/allcontrol = '0'"> 
								<xsl:value-of select="document/captions/readonly/@caption"/>
							</xsl:when>
							<xsl:when test="document/@editmode = 'view'">
								<xsl:value-of select="document/captions/readonly/@caption"/>
							</xsl:when>
							<xsl:when test="document/@editmode = 'readonly'">
								<xsl:value-of select="document/captions/readonly/@caption"/>
							</xsl:when>
							<xsl:when test="document/@editmode = 'edit'">
								<xsl:value-of select="document/captions/editing/@caption"/>
							</xsl:when>
							<xsl:when test="document/@editmode = 'noaccess'">
								<xsl:value-of select="document/captions/readonly/@caption"/>
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
						<script type="text/javascript">
							usersWhichReadInTable(this,<xsl:value-of select="document/@doctype"/>,<xsl:value-of select="document/@docid"/>)
						</script>
						<table class="table-border-gray" id="userswhichreadtbl" style="width:600px">
							<tr>
								<td style="width:350px; text-align:center">
									<xsl:value-of select="document/captions/whomread/@caption"/>
								</td>
								<td style="width:250px; text-align:center">
									<xsl:value-of select="document/captions/timeofreading/@caption"/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="fc">
						<xsl:value-of select="document/captions/DS/@caption"/> :
					</td>
					<td>
						<font id="eds_status">
							<xsl:choose>
								<xsl:when test="document/@sign ='0'">
									<xsl:value-of select="document/captions/documentnotsigned/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='1'">
									<xsl:value-of select="document/captions/signistrue/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='2'">
									<xsl:value-of select="document/captions/signisfalse/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='3'">
									<xsl:value-of select="document/captions/invalidkey/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='4'">
									<xsl:value-of select="document/captions/algorithmnotfound/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='5'">
									<xsl:value-of select="document/captions/fillmechanismnotfound/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='6'">
									<xsl:value-of select="document/captions/invalidcharkey/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='7'">
									<xsl:value-of select="document/captions/invalidparalgo/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='8'">
									<xsl:value-of select="document/captions/totalexceptionkey/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='10'">
									<xsl:value-of select="document/captions/filecertnotfound/@caption"/>
								</xsl:when>
								<xsl:when test="document/@sign ='11'">
									<xsl:value-of select="document/captions/onefilenotfound4sign/@caption"/>
								</xsl:when>
								<xsl:otherwise>
								</xsl:otherwise>
							</xsl:choose>
						</font>		
					</td>
				</tr>
				<tr id="signtexttr" style="visible:hidden">
					<td class="fc">
						Sign :
					</td>
					<td>
						<font id="signtext" style="font-size:10px; visible:hidden; width:600px; word-wrap:break-word">
							<xsl:value-of select="document/fields/sign"/>
						</font>		
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
							<input type="file" size="60" border="#CCC" name="fname" id="fileInput">
								<xsl:attribute name="onchange">javascript:submitFile('upload', 'upltable', 'fname'); ajaxFunction()</xsl:attribute>
							</input>&#xA0;
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
											<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;id=rtfcontent&amp;id=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
										</img>
										<xsl:if test="$editmode = 'edit'">
											<xsl:if test="comment =''">
												<a href='' style="vertical-align:top;" title='tect'>
													<xsl:attribute name='href'>javascript:addCommentToAttach('<xsl:value-of select="$id"/>')</xsl:attribute>
													<img id="commentaddimg{$id}" src="/SharedResources/img/classic/icons/comment_add.png" style="width:16px; height:16px" >
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
											<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;id=rtfcontent&amp;file=<xsl:value-of select='$filename'/>	</xsl:attribute>
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
												<xsl:attribute name='href'>javascript:deleterow('<xsl:value-of select="$formsesid"/>','<xsl:value-of select='$filename' />','<xsl:value-of select="$id"/>')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:13px; height:13px">
													<xsl:attribute name="title" select="//document/captions/delete_file/@caption"/>
												</img>
											</a>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</td>
					</tr>
					<tr>
						<td/>
						<td colspan="2" style="color:#777; font-size:12px">
							<xsl:if test="comment !=''">
								<xsl:value-of select="concat(//document/captions/comments/@caption,':',comment)"/>
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
	
	<xsl:template name="eds_attach">
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
							<br/>
							<style>.ui-progressbar .ui-progressbar-value { background-image: url(/SharedResources/jquery/css/base/images/pbar-ani.gif); }</style>
							<div id="progressbar" style="width:370px; margin-top:5px; height:12px"></div>
							<div id="progressstate" style="width:370px; display:none">
								<font style="visibility:hidden; color:#999; font-size:11px; width:70%" id="readybytes"/>
								<font style="visibility:hidden; color:#999; font-size:11px; float:right;" id="percentready"/>
								<font style="visibility:hidden; text-align:center; color:#999; font-size:11px; width:30%; text-align:center" id="initializing">Подготовка к загрузке</font>
							</div>
						</td>
						<td/>
					</tr>
				</xsl:if>
			</table>
		</div>
	</xsl:template>
	
	<xsl:template name="attach_cert">
		<div id="attach" style="display:block;">
			<table style="border:0; border-collapse:collapse" id="upltable" width="99%">
				<xsl:if test="$editmode = 'edit'">
					<tr>
						<td class="fc">
							<xsl:value-of select="document/captions/password/@caption"/>:
						</td>
						<td>
							<input type="password" size="40" border="#CCC" name="p_eds"/>
						</td>
						<td></td>
					</tr>
					<tr>
						<td class="fc">
							<xsl:value-of select="document/captions/attachments_cert/@caption"/>:
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
								<font style="visibility:hidden; color:#999; font-size:11px; width:70%" id="readybytes"/>
								<font style="visibility:hidden; color:#999; font-size:11px; float:right;" id="percentready"/>
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
											<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
										</img>
										<xsl:if test="$editmode = 'edit'">
											<xsl:if test="comment =''">
												<a href='' style="vertical-align:top;" title='tect'>
													<xsl:attribute name='href'>javascript:addCommentToAttach('<xsl:value-of select="$id"/>')</xsl:attribute>
													<img id="commentaddimg{$id}" src="/SharedResources/img/classic/icons/comment_add.png" style="width:16px; height:16px" >
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
											<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;id=rtfcontent&amp;file=<xsl:value-of select='$filename'/>	</xsl:attribute>
											<xsl:value-of select='$filename'/>
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
												<xsl:attribute name='href'>javascript:deleterow('<xsl:value-of select="$formsesid"/>','<xsl:value-of select='$filename' />','<xsl:value-of select="$id"/>')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:13px; height:13px">
													<xsl:attribute name ="title" select="//document/captions/delete_file/@caption"/>
												</img>
											</a>
										</xsl:if>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</td>
					</tr>
					<tr>
						<td/>
						<td colspan="2" style="color:#777; font-size:12px">
							<xsl:if test="comment !=''">
								<xsl:value-of select="concat(//document/captions/comments/@caption,' : ', comment)"/>
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