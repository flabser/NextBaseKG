<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:import href="../templates/form.xsl"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="doctype" select="request/document/captions/doctypemultilang/@caption"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="request">
		<xsl:variable name="path" select="/request/@skin"/>
		<html>
	  		<head>
	 			<title><xsl:value-of select="document/captions/employer/@caption"/>: <xsl:value-of select="document/fields/fullname"/> - 4ms workflow</title>
	     		<xsl:call-template name="cssandjs"/>
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
									   default:
									      	break;
									}
			   					}
							});
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
						}
					]]>
				</script>
				<script type="text/javascript">
					$(document).ready(function(){
						(function(){
							$("#btnPwdChange").click(function(){
								$("#passdlg").dialog({
									title: "Смена пароля",
									modal: true,
									width: 400
								});
							});
						})();
						$("#btnpwdok").click(function(){
							var perror = "";
							var oldpwd = $('#oldpwd').val();
							var newpwd = $('#cnewpwd').val();
							var rnewpwd = $('#rnewpwd').val();
							if( oldpwd == '' ) {
								perror = "Введите текущий пароль";
							} else if( newpwd == '' ) {
								perror = "Введите новый пароль";
							} else if( rnewpwd == ''){
								perror = "Подтвердите новый пароль";
							} else if (newpwd != rnewpwd) {
								perror = "Повтор пароля не верный";
							} else if (newpwd == oldpwd) {
								perror = "Операция не имеет смысла";
							} else if (3 > newpwd.length) {
								perror = "Пароль слишком короткий.";
							}
							if (perror==''){
								$('#pass').toggle(true);
								$("#btnPwdChange").toggle(false);
								$('#newpwd').val(newpwd).attr('name', 'newpwd');
								$('#newpwd').after('<input type="hidden" name="oldpwd" value="'+oldpwd+'"/>');
								$("#passdlg").dialog('close');
							} else {
								alert(perror);
							}
						});
						$("#btndlgclose").click(function(){ $("#passdlg").dialog('close'); });
						if ($.cookie("refresh") != null){ $("[name=refresh] #"+$.cookie("refresh")).attr("selected","selected")}
						if ($.cookie("lang") != null){ $("[name=lang] #"+$.cookie("lang")).attr("selected","selected")}
						<![CDATA[
						if ($.cookie("history") != null && $.cookie("history")=='history_on' ){
							$("input[name=historyvis]").attr("checked","checked")
						}]]>
						if ($.cookie("pagesize") != null){
							$("[name=countdocinview] #countdocinview"+$.cookie("pagesize")).attr("selected","selected")
						}
					});
				</script>
	    	</head>
	    	<body>  
	    		<div id="docwrapper">
	    			<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
	            		<div  class="formtitle">
							<div class="title">
								<font><xsl:value-of select="document/captions/employer/@caption"/> - <xsl:value-of select="document/fields/fullname"/></font>
							</div>
						</div>
		            	<div class="button_panel">
							<span style="float:left">
		             			<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" title="{document/captions/saveandclose/@caption}" id="btnsavedoc">
									<xsl:attribute name="onclick">javascript:saveUserProfile('<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/Workflow/')"/>')</xsl:attribute>
									<span>
										<img src="/SharedResources/img/iconset/disk.png" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"></img>
										<font style="font-size:12px; vertical-align:top"><xsl:value-of select="document/captions/saveandclose/@caption"/></font>
									</span>
								</button>
							</span>
							<span style="float:right; margin-right:5px">
			            		<xsl:call-template name="cancel"/>
			            	</span>
		 	         	</div>            			     
						<br/>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1"><xsl:value-of select="document/captions/properties/@caption"/></a>
								</li>
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-2"><xsl:value-of select="document/captions/interface/@caption"/></a>
								</li>
								<!-- <li class="ui-state-default ui-corner-top">
									<a href="#tabs-3"><xsl:value-of select="document/captions/filtermanage/@caption"/></a>
								</li> -->
							</ul>
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
							<div class="ui-tabs-panel" id="tabs-1">
							<div display="block"  id="property" width="100%">
								<br/>
	      	    				<table width="80%" border="0" style="margin-top:8px">
				 					<tr>
										<td class="fc">
											<xsl:value-of select="document/captions/department/@caption"/> :
										</td>
										<td>
											<table>
												<tr>
													<td class="td_noteditable" style="width:500px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:if test="document/fields/department != '0'">
															<xsl:value-of select="document/fields/department"/>
														</xsl:if>&#xA0;
													</td>
												</tr>
											</table>
										</td>
									</tr>					
									<tr>
										<td class="fc">
											<xsl:value-of select="document/captions/postid/@caption"/> :
										</td>
										<td>
											<table>
												<tr>
													<td class="td_noteditable" style="width:500px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/post"/>&#xA0;
													</td>
												</tr>
											</table>
										</td>
						    		</tr>
						    		<tr>
										<td class="fc">
											<xsl:value-of select="document/captions/shortname/@caption"/> :
										</td>
										<td>
											<table>
												<tr>
													<td class="td_noteditable" style="width:500px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/shortname"/>&#xA0;
													</td>
												</tr>
											</table>
										</td>
									</tr>					
					        		<tr>
										<td class="fc">
											<xsl:value-of select="document/captions/fullname/@caption"/> :
										</td>
										<td>
											<table>
												<tr>
													<td class="td_noteditable" style="width:500px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/fullname"/>&#xA0;
													</td>
												</tr>
											</table>
										</td>
									</tr>		
						    		<tr>
										<td class="fc">ID :</td>
										<td>
											<input  style="width:500px;" class="td_editable" name="userid" value="{document/fields/userid}">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
										</td>
									</tr>		
									<tr>
										<td class="fc"><xsl:value-of select="document/captions/oldpassword/@caption"/> :</td>
										<td>
											<input style="width:300px;" class="td_editable" id="oldpwd" name="oldpwd" type="password" autocomplete="off">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
										</td>
									</tr>
									<tr>
										<td class="fc"><xsl:value-of select="document/captions/newpassword/@caption"/> :</td>
										<td>
											<input style="width:300px;" id="newpwd" name="pwd" type="password" class="td_editable" autocomplete="off">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
										</td>
									</tr>
									<tr>
										<td class="fc"><xsl:value-of select="document/captions/repeatnewpassword/@caption"/> :</td>
										<td>
											<input style="width:300px;" id="newpwd2"  name="pwd2" type="password" class="td_editable" autocomplete="off">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
										</td>
									</tr>
									<tr>
										<td class="fc">Instant Messenger address :</td>
										<td>
											<input style="width:300px" name="instmsgaddress" type="text" class="td_editable" value="{document/fields/instmsgaddress}">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
											<span style="vertical-align:middle;">
												<xsl:choose>
													<xsl:when test="document/fields/instmsgstatus = 'false'">
														<img src="/SharedResources/img/iconset/bullet_red.png" title="Instant Messenger off"/>
													</xsl:when>
													<xsl:when test="document/fields/instmsgstatus = 'true'">
														<img src="/SharedResources/img/iconset/bullet_gren.png" title="Instant Messenger on"/>
													</xsl:when>
													<xsl:otherwise>
														<img src="/SharedResources/img/iconset/bullet_red.png" title="Instant Messenger off"/>
													</xsl:otherwise>
												</xsl:choose>
											</span>
										</td>
									</tr>		
				            		<tr>
										<td class="fc">E-mail :</td>
										<td width="69%">
											<input style="width:300px" id="email" name="email" type="text" class="td_editable" value="{document/fields/email}">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">td_noteditable</xsl:attribute>
												</xsl:if>
											</input>
										</td>
									</tr>	
				            		<tr>
										<td class="fc"><xsl:value-of select="document/captions/role/@caption"/> :</td>
										<td>
											<table>
												<xsl:for-each select="document/fields/role[not(entry)]">
													<xsl:variable name="role" select="."/>
													<xsl:if test="/request/document/glossaries/roles/entry[ison='ON'][name = $role]">
														<tr>
															<td style="width:500px;" class="td_noteditable">
																<xsl:if test="../../../../document/@editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>
																
																<xsl:if test="/request/document/glossaries/roles/entry[ison='ON'][name = $role]">
																	<input type="hidden" name="role" value="{.}"/>
																</xsl:if>
															</td>
														</tr>
													</xsl:if>
												</xsl:for-each>
												<xsl:for-each select="document/fields/role/entry">
													<xsl:variable name="role" select="."/>
													<xsl:if test="/request/document/glossaries/roles/entry[ison='ON'][name = $role]">
														<tr>
															<td style="width:500px;" class="td_noteditable">
																<xsl:if test="../../../../document/@editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>
																
																<xsl:if test="/request/document/glossaries/roles/entry[ison='ON'][name = $role]">
																	<input type="hidden" name="role" value="{.}"/>
																</xsl:if>
															</td>
														</tr>
													</xsl:if>
												</xsl:for-each>
											</table>
										</td>
									</tr>	
				            		<tr>
										<td class="fc"><xsl:value-of select="document/captions/group/@caption"/> :</td>
										<td width="69%">
											<table>
												<xsl:for-each select="document/fields/group/entry">
												<tr>
													<td style="width:500px" class="td_noteditable">
														<xsl:if test="../../../../document/@editmode != 'edit'">
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="."/>
													</td>
												</tr>
												</xsl:for-each>
											</table>
										</td>
									</tr>	
	                 			</table>
	                 			<br/>
	           				</div>
	           			</div>
	            		<div id="tabs-2">
							<div display="block" id="interface" style="width:100%">
								<br/>
				         		<table width="80%" border="0" style="margin-top:8px">
				             		<tr>	
							    		<td class="fc">
							    			<xsl:value-of select="document/captions/countdocinview/@caption"/>&#xA0;:
							    		</td>
										<td width="69%">
											<select name="pagesize" id="countdocinview" class="select_editable" style="width:85px">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="class">select_noteditable</xsl:attribute>
												</xsl:if>
												<option id="countdocinview10">
													<xsl:if test="document/fields/countdocinview = '10'">
														<xsl:attribute name="selected">selected</xsl:attribute>
													</xsl:if>10
												</option>
												<option id="countdocinview20">
													<xsl:if test="document/fields/countdocinview = '20'">
														<xsl:attribute name="selected">selected</xsl:attribute>
													</xsl:if>20
												</option>
												<option id="countdocinview30">
													<xsl:if test="document/fields/countdocinview = '30'">
														<xsl:attribute name="selected">selected</xsl:attribute>
													</xsl:if>30
												</option>
												<option id="countdocinview50">
													<xsl:if test="document/fields/countdocinview = '50'">
														<xsl:attribute name="selected">selected</xsl:attribute>
													</xsl:if>50
												</option>
											</select>
										</td>
									</tr>
				             		<tr>	
							    		<td class="fc"><xsl:value-of select="document/captions/refreshperiod/@caption"/> :</td>
								   			<td width="69%">
												<select name="refresh" id="refresh" class="select_editable" style="width:85px">
													<xsl:if test="document/@editmode != 'edit'">
														<xsl:attribute name="class">select_noteditable</xsl:attribute>
													</xsl:if>
													<option id="3" value="3">
														<xsl:if test="document/fields/refresh = '3'">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if> 3 <xsl:value-of select="document/captions/min/@caption"/>.
													</option>
													<option id="5" value="5">
														<xsl:if test="document/fields/refresh = '5' ">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>5 <xsl:value-of select="document/captions/min/@caption"/>.
													</option>
													<option id="10" value="10">
														<xsl:if test="document/fields/refresh = '10' ">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>10 <xsl:value-of select="document/captions/min/@caption"/>.
													</option>
													<option id="15" value="15">
														<xsl:if test="document/fields/refresh = '15' ">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>15 <xsl:value-of select="document/captions/min/@caption"/>.
													</option>
													<option id="20" value="20">
														<xsl:if test="document/fields/refresh = '20' ">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>20 <xsl:value-of select="document/captions/min/@caption"/>.
													</option>
													<option id="30" value="30">
														<xsl:if test="document/fields/refresh = '30' ">
															<xsl:attribute name="selected">selected</xsl:attribute>
														</xsl:if>30 <xsl:value-of select="document/captions/min/@caption"/>.
													</option>
												</select>
											</td>
										</tr>
				             		<tr>	
							    		<td class="fc"><xsl:value-of select="document/captions/lang/@caption"/> :</td>
								   		<td width="69%">
											<select name="lang" id="lang" class="select_editable" style="width:120px">
												<xsl:variable name='chinese' select="document/captions/chinese/@caption"/>
												<xsl:variable name='currentlang' select="../@lang"/>
<!-- 												<xsl:attribute name="onchange">javascript:changeSystemSettings(this)</xsl:attribute> -->
												<xsl:for-each select="document/glossaries/langs/entry">
													<option id="{id}" value="{id}">
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
											</select>
										</td>
									</tr>
				             			<!-- <tr>	
							    			<td class="fc">Отображение истории посещений :</td>
								   			<td  width="69%">
												<input type="checkbox" name="historyvis"  id="history_vis" value="history_on">
													<xsl:if test="document/fields/historyvis = 'history_on' ">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
												</input>
											</td>
										</tr> -->
				       				</table>
				       				<br/>	
				        		</div>
	        				</div>
							<input type="hidden" name="type" value="save_userprofile"/>
							<input type="hidden" name="id" value="userprofile"/>
	        			</form>
	        		</div>
	        		<div style="height:10px"/>
	        	</div>
	        	</div>
				<xsl:call-template name="formoutline"/>
	        </body>
		</html>
	</xsl:template>
</xsl:stylesheet>