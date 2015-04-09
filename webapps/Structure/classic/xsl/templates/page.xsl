<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="flashentry">	
		<xsl:if test="query/@flashdocid !=''">
			<script type="text/javascript">
				$("document").ready(
					function(){ flashentry(<xsl:value-of select="concat(query/@flashdocid, query/@flashdoctype)"/>);}
				);
			</script>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template name="loadingpage">	
		<div id='loadingpage' style='position:absolute; display:none'>
			<script>
				lt = ($(document).height() - 80 )/2;
				ll = ($(window).width() - 80 )/2;
				$("#loadingpage").css({"top":lt, "left":ll})
			</script>
			<img src='/SharedResources/img/classic/4(4).gif'/>
		</div>	
	</xsl:template>
	
	<xsl:template name="header-view">	
		<div id="header-view">
			<span style="float:left">
				<img alt="" src ="/SharedResources/logos/structure_small.png" style="margin:5px 5px 0px 10px"/>
				<font style="font-size:1.5em; vertical-align:20px; color:#555555; margin-left:5px">4MS</font>
				<font style="font-size:1em; vertical-align:20px; color:#555555; margin-left:5px"> Structure </font>
			</span>
			<span style="float:right; padding:5px 5px 5px 0px" >
				<a id="currentuser" target="_parent" title="{//captions/userprofile/@caption}" href="Provider?type=edit&amp;element=userprofile&amp;id=userprofile" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
					<font><xsl:value-of select="@username"/></font>
				</a>
				<a target="_parent" href="Logout" id="logout" title="{//captions/logout/@caption}" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
					<font style="margin-left:15px;"><xsl:value-of select="//captions/logout/@caption"/></font>
				</a>
				<a target="_parent" id="helpbtn" href="/Help/Provider?type=page&amp;id=article" title="{//captions/help/@caption}" style="text-decoration:none;color: #555555 ; font: 11px Tahoma; font-weight:bold">
					<font style="margin-left:15px;"><xsl:value-of select="//captions/help/@caption"/></font>
				</a>
				<div class="sarea" style="margin-top:15px; text-align:right; display:none">
					<input id="searchInput" style="padding:0.3em 0.9em; width:200px; margin-right:3px; vertical-align:top">
						<xsl:attribute name="value"><xsl:value-of select="query/@keyword"/></xsl:attribute>
					</input> 
					<script>
						$("#searchInput").keydown(function(e){if(e.which ==13){search();}});
					</script> 
					<button id="btnsearch" title="Поиск" style="vertical-align:top; text-align:center">
						<xsl:attribute name="onclick">javascript:search()</xsl:attribute>
						<img src="/SharedResources/img/iconset/magnifier.png" style="width:16px; height:16px; margin-left:1px"/>
					</button>
					<script type="text/javascript">
				   		$(function(){
							$(".sarea button").button();
							$(".sarea button").css("width","30px").css("height","26px");
							$("#btnsearch span").css("padding","0px").css("padding-left","2px");
				    	});
	    			</script>
				</div>
			</span>				
		</div>
	</xsl:template>
	
	<xsl:template name="outline-menu-view">	
		<div id="outline">
			<div id="outline-container" style="width:303px; padding-top:10px">
				<xsl:for-each select="//outline/response/content/outline">
					<div>
						<xsl:if test="@id = 'mydocs'">
							<xsl:attribute name="style">border:1px solid #ccc; border-left:none; margin-bottom:20px; width:auto; margin-right:7px</xsl:attribute>
						</xsl:if>
						<div>
						<div class="treeentry" style="height:17px; padding:3px 0px 3px 0px  ; border:1px solid #F9F9F9; width:auto" onclick="javascript:ToggleCategory(this)">								
							<img src="/SharedResources/img/classic/1/minus.png" style="margin-left:6px; cursor:pointer" alt="">
								<!-- <xsl:attribute name="onClick">javascript:ToggleCategory(this)</xsl:attribute> -->
							</img>
							<img src="/SharedResources/img/classic/1/folder_open_view.png" style="margin-left:5px; " alt=""/>
							<font style="font-family:arial; font-size:0.9em; margin-left:4px; vertical-align:3px">											
								<xsl:value-of select="@hint"/>
							</font>
						</div>
						</div>
						<div style="clear:both;"/>
						<div class="outlineEntry" id="{@id}">
							<script>
								if($.cookie("STRUCTURE_<xsl:value-of select='@id'/>") != 'null'){
									$("#<xsl:value-of select='@id'/>").css("display",$.cookie("STRUCTURE_<xsl:value-of select='@id'/>"))
									if($.cookie("STRUCTURE_<xsl:value-of select='@id'/>") == "none"){
										$("#<xsl:value-of select='@id'/>").prev().prev().children().children("img:first").attr("src","/SharedResources/img/classic/1/plus.png")							
										$("#<xsl:value-of select='@id'/>").prev().prev().children().children("img:last").attr("src","/SharedResources/img/classic/1/folder_close_view.png")							
									}
								}
							</script>
							<xsl:for-each select="entry">
							<a href="{@url}" style="width:90%; vertical-align:top; text-decoration:none !important" title="{@hint}">
								<div class="entry treeentry" style="width:auto; padding:3px 0px 3px 0px; border:1px solid #F9F9F9; " >
									<xsl:if test="/request/@id = @id">
										<xsl:attribute name="class">entry treeentrycurrent</xsl:attribute>										
									</xsl:if>
									<div class="viewlink">
										<xsl:if test="/request/@id = @id">
											<xsl:attribute name="class">viewlink_current</xsl:attribute>										
										</xsl:if>	
										<div style="padding-left:35px">
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
											<xsl:if test="../@id = 'mydocs'">
												<span style=" text-align:left; float:right; margin-right:5px ">
													<font class="countSpan" id="count{@id}" style="vertical-align:top">
														<xsl:value-of select="@count"/>
														<xsl:variable name="countid" select="@id"/>
														<xsl:for-each select="/request/counts/*">
															<xsl:if test="name(.) = $countid">
																<xsl:value-of select="."/>
															</xsl:if>
														</xsl:for-each>
													</font>
												</span>
											</xsl:if>
										</div>
									</div>
								</div>
								</a>
							</xsl:for-each>
						</div>
					</div>
				</xsl:for-each>
			</div>
		</div>
		<div id="resizer" style="position:absolute; top: 80px; left:306px; background:#E6E6E6; width:12px; bottom:0px; border-radius: 0 6px 6px 0; border: 1px solid #adadad; border-left: ; cursor:pointer" onclick="javascript: closepanel()">
			<span  id="iconresizer" class="ui-icon ui-icon-triangle-1-w" style="margin-left:-2px; position:relative; top:49%"></span>
		</div>
	</xsl:template>
	
	<xsl:template name="viewtable_dblclick_open">	
		<script>
			$("."+<xsl:value-of select="@docid"/>).dblclick( function(event){
  				if (event.target.nodeName != "INPUT" &amp;&amp;  event.target.nodeName != "IMG"){
  					beforeOpenDocument();
  					window.location = '<xsl:value-of select="@url"/>'
  				}
			});
		</script>
	</xsl:template>

	<xsl:template name="search">
		 <input id="searchInput" style=" padding:0.25em 0.9em; width:200px; margin-right:3px; vertical-align:top">
			<xsl:attribute name="value">
				<xsl:value-of select="query/@keyword"/>
			</xsl:attribute>
		</input> 
  		<script>
  			$("#searchInput").keydown(function(e){ if (e.which ==13){ search(); } });
  		</script> 
			<button id="btnsearch" title="Поиск">
				<xsl:attribute name="onclick">javascript:search()</xsl:attribute>
				<div style="text-align:center">
					<img src="/SharedResources/img/iconset/magnifier.png" style="border:none; position:absolute; left:8px; top:5px; width:16px; height:16px "></img>
				</div>
			</button>
		<div id="advancedSearchDiv" style="border:2px solid #ccc; background:#ffffff; display:none; margin-top:3.5%; right:0;  width:53%; position:absolute; height:100px;">
			<table style=" font-size:12px; width:100%">
				<tr>
					<td> 
						<input type="checkbox" name="typefinddoc" value="in">Входящий</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="ish" style="margin-left:12.4%">Исходящий</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="in">Карточка исполнения</input>&#xA0;
					</td>
				</tr>
				<tr style="height:28px">
					<td> 
						<input type="checkbox" name="typefinddoc" value="in">Служебная записка</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="prj">Проект</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="in" style="margin-left:5.2%">Резолюция</input>&#xA0;
					</td>
				</tr>
				<tr>
					<td> 
						<b>Дата создания:</b>
 					</td>
 				</tr>
 				<tr>
 					<td>
 						&#xA0;с &#xA0;
 						<input type="text" id="fromdate" name="fromdate" size="14" class="rof" style="height:22px" readonly="readonly">
							<xsl:attribute name="value">
								<xsl:value-of select="document/fields/from" />
							</xsl:attribute>
						</input>&#xA0;
 						по&#xA0;
 						<input type="text" id="todate" name="todate" size="14" class="rof" style="height:22px" readonly="readonly">
							<xsl:attribute name="value">
								<xsl:value-of select="document/fields/to"/>
							</xsl:attribute>
						</input>&#xA0;
 						<input type="checkbox" name="control" value="1">Контрольный</input>&#xA0;
 						<script>
							$(function() {
								$('#fromdate, #todate').datepicker({
									showOn: 'button',
									buttonImage: '/SharedResources/img/iconset/calendar.png',
									buttonImageOnly: true,
									regional:['ru'],
									showAnim: ''
								});
							});
						</script>
 					</td>
 				</tr>
 			</table>
 		</div>
	</xsl:template>
	
	
	<xsl:template name="pagetitle">
		<xsl:value-of select="//captions/title/@caption"/>
	</xsl:template>
	
	<xsl:template name="viewinfo">
		<div style="height:30px">
			<table style="width:100%;">
			<tr style="height:34px">
				<td style="text-align:left; padding-left:15px; width:350px; max-width:400px">					 
					<font class="time" style="font-size:14px; padding-right:10px; font-weight:bold;">
						<xsl:if test="@id = 'demand-unexecuted-view-by-executor'">
							<xsl:value-of select ="//captions/executor/@caption"/> :
						</xsl:if>
						<xsl:if test="@id = 'demand-unexecuted-view-by-author'">
							<xsl:value-of select ="//captions/author/@caption"/> :
						</xsl:if>
						<xsl:call-template name="pagetitle"/>
			    	</font>
				</td>  
				<td>
					<center>
						<xsl:call-template name="prepagelist"/>
					</center>
				</td>
				<td style="text-align:right;">
					<font class="time">						
						<xsl:value-of select="concat(' ',//captions/documents/@caption,' : ',//query/@count,' ')"/>
					</font>
				</td>
			</tr>
		</table>
		</div>
	</xsl:template>
	
	<xsl:template name="prepagelist">
		<xsl:if test="//query/@maxpage !=1">
			<table class="pagenavigator">
				<xsl:variable name="curpage" select="//query/@currentpage"/>
				<xsl:variable name="prevpage" select="$curpage -1 "/>
				<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
            	<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
				<tr>
					<xsl:if test="//query/@currentpage>1">
						<td>
							<a href="">
								<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=1"</xsl:attribute>
								<font style="font-size:12px">&lt;&lt;</font>
							</a>&#xA0;
						</td>
						<td>
							<a href="">
								<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$prevpage'/>"</xsl:attribute>
								<font style="font-size:12px">&lt;</font>
							</a>&#xA0;
						</td>
					</xsl:if>
					<xsl:call-template name="pagenavig"/>
					<xsl:if test="//query/@maxpage > 15">
						<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
                		<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
						<td>
							<select>
								<xsl:attribute name="onChange">jjavascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page="+this.value</xsl:attribute>
			 					<xsl:call-template name="combobox"/>
			 				</select>
			 			</td>
					</xsl:if>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="prepagelistsearch">
		<xsl:if test="query/@maxpage !=1">
			<table class="pagenavigator">
				<xsl:variable name="curpage" select="query/@currentpage"/>
				<xsl:variable name="prevpage" select="$curpage -1 "/>
				<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
            	<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
            	<xsl:variable name="keyword" select="query/@keyword"/> 
				<tr>
					<xsl:if test="query/@currentpage>1">
						<td>
							<a href="">
								<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',1)</xsl:attribute>
								<font style="font-size:12px">&lt;&lt;</font>
							</a>&#xA0;
						</td>
						<td>
							<a href="">
								<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$prevpage"/>)</xsl:attribute>
								<font style="font-size:12px">&lt;</font>
							</a>&#xA0;
						</td>
					</xsl:if>
					<xsl:call-template name="pagenavigSearch"/>
					<xsl:if test="query/@maxpage > 15">
						<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
                		<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
						<td>
							<select>
								<xsl:attribute name="onChange">javascript:doSearch('<xsl:value-of select="$keyword"/>',this.value)</xsl:attribute>
			 					<xsl:call-template name="combobox"/>
			 				</select>
			 			</td>
					</xsl:if>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>
	
	<!--	навигатор по страницам -->
	<xsl:template name="pagenavig">
 		<xsl:param name="i" select="1"/>  <!-- счетчик количества страниц отображаемых в навигаторе  -->
 		<xsl:param name="n" select="15"/> <!-- количество страниц отображаемых в навигаторе -->
  		<xsl:param name="z" select="//query/@maxpage -14"/>
  		<xsl:param name="f" select="15"/>
 		<xsl:param name="c" select="//query/@currentpage"/> <!-- текущая страница в виде -->
 		<xsl:param name="startnum" select="//query/@currentpage - 7"/> 
  		<xsl:param name="d" select="//query/@maxpage - 14"/>	<!-- переменная для вычисления начального номера страницы в навигаторе  -->
  		<xsl:param name="currentpage" select="//query/@currentpage"/>
  		<xsl:param name="maxpage" select="//query/@maxpage"/>
  		<xsl:param name="nextpage" select="$currentpage + 1"/>
  		<xsl:param name="prevpage" select="$currentpage - 1"/>
  		<xsl:param name="curview" select="@id"/> 
  		<xsl:param name="direction" select="//query/@direction"/> 
		<xsl:choose>
			<xsl:when test="$maxpage>15">
				<xsl:choose>
					<xsl:when test="$maxpage - $currentpage &lt; 7">
						<xsl:if test="$i != $n+1">
							<xsl:if test="$z &lt; $maxpage + 1">
								<td>
									<a href="">
										<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$z'/>"</xsl:attribute>
   			 							<font style="font-size:12px">
    										<xsl:if test="$z=$currentpage">
    											<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    										</xsl:if>
    										<xsl:value-of select="$z"/>
    									</font>
   									</a>&#xA0;
								</td>
							</xsl:if>
      						<xsl:call-template name="pagenavig">
	        					<xsl:with-param name="i" select="$i + 1"/>
	        					<xsl:with-param name="n" select="$n"/>
	        					<xsl:with-param name="z" select="$z+1"/>
      						</xsl:call-template>
						</xsl:if>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
     								<a href="">
     									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$nextpage'/>"</xsl:attribute>
      									<font style="font-size:12px"> > </font>
      								</a>
      							</td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$maxpage'/>"</xsl:attribute>
       									<font style="font-size:12px; margin-left:7px"> >> </font>
       								</a> 
						        </td>
							</xsl:if>
   						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$currentpage &lt; 7">
								<xsl:if test="$i=1">
									<xsl:if test="$currentpage = 1">
										<td>
											&#xA0;&#xA0;&#xA0;&#xA0;	
										</td>
										<td>
											&#xA0;&#xA0;&#xA0;
										</td>
									</xsl:if>
								</xsl:if>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<td>
											<a href="">
												<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$i'/>"</xsl:attribute>
												<font style="font-size:12px">
    												<xsl:if test="$i=$currentpage">
    													<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    												</xsl:if>
    												<xsl:value-of select="$i"/>
    											</font>
						   					</a>&#xA0;
										</td>
									</xsl:if>
      								<xsl:call-template name="pagenavig">
	        							<xsl:with-param name="i" select="$i + 1"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
      								</xsl:call-template>
      							</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<xsl:if test="$startnum !=0">
											<td>
												<a href="">
													<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$startnum'/>"</xsl:attribute>
													<font style="font-size:12px">
    													<xsl:if test="$startnum=$currentpage">
    														<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    													</xsl:if>
    													<xsl:value-of select="$startnum"/>
    												</font>
						   						</a>&#xA0;
											</td>
										</xsl:if>
									</xsl:if>
									<xsl:if test="$startnum != 0">
      									<xsl:call-template name="pagenavig">
											<xsl:with-param name="i" select="$i + 1"/>
	        								<xsl:with-param name="n" select="$n"/>
	        								<xsl:with-param name="c" select="$c+1"/>
	        								<xsl:with-param name="startnum" select="$c - 6"/>
      									</xsl:call-template>
      								</xsl:if>
									<xsl:if test="$startnum = 0">
      									<xsl:call-template name="pagenavig">
										<xsl:with-param name="i" select="$i"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
	        							<xsl:with-param name="startnum" select="$c - 6"/>
      								</xsl:call-template>
      							</xsl:if>
      						</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
      								<a href="">
      									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$nextpage'/>"</xsl:attribute>
     									<font style="font-size:12px"> > </font>
     								</a>
							    </td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$maxpage'/>"</xsl:attribute>
       									<font style="font-size:12px; margin-left:7px"> >> </font>
       								</a>
							    </td>
							</xsl:if>
  						</xsl:if>
						
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$i=1">
					<xsl:if test="$currentpage = 1">
						<td>
							&#xA0;&#xA0;&#xA0;&#xA0;	
						</td>
						<td>
							&#xA0;&#xA0;&#xA0;
						</td>
					</xsl:if>
				</xsl:if>
				<xsl:if test="$i != $n+1">
					<xsl:if test="$i &lt; $maxpage + 1">
						<td>
							<a href="">
							<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$i'/>"</xsl:attribute>
   			 					<font style="font-size:12px">
    								<xsl:if test="$i=$currentpage">
    									<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    								</xsl:if>
    								<xsl:value-of select="$i"/>
    							</font>
						    </a>&#xA0;
						</td>
					</xsl:if>
      				<xsl:call-template name="pagenavig">
	        			<xsl:with-param name="i" select="$i + 1"/>
	        			<xsl:with-param name="n" select="$n"/>
	        			<xsl:with-param name="c" select="$c+1"/>
      				</xsl:call-template>
				</xsl:if>
				<xsl:if test="$currentpage != $maxpage">
					<xsl:if test="$i = $n+1">
						<td>
      						<a href="">
      							<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$nextpage'/>"</xsl:attribute>
      							<font style="font-size:12px"> > </font>
      						</a>
					    </td>
       					<td>
       						<a href="">
       							<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$maxpage'/>"</xsl:attribute>
       							<font style="font-size:12px; margin-left:7px"> >> </font>
       						</a> 
						</td>
					</xsl:if>
   				</xsl:if>
   			</xsl:otherwise>
  		 </xsl:choose>
 	 </xsl:template>
 	 
 	 <xsl:template name="pagenavigSearch">
 		<xsl:param name="i" select="1"/>  <!-- счетчик количества страниц отображаемых в навигаторе  -->
 		<xsl:param name="n" select="15"/> <!-- количество страниц отображаемых в навигаторе -->
  		<xsl:param name="z" select="query/@maxpage -14"/>
  		<xsl:param name="f" select="15"/>
 		<xsl:param name="c" select="query/@currentpage"/> <!-- текущая страница в виде -->
 		<xsl:param name="startnum" select="query/@currentpage - 7"/> 
  		<xsl:param name="d" select="query/@maxpage - 14"/>	<!-- переменная для вычисления начального номера страницы в навигаторе  -->
  		<xsl:param name="currentpage" select="query/@currentpage"/>
  		<xsl:param name="maxpage" select="query/@maxpage"/>
  		<xsl:param name="nextpage" select="$currentpage + 1"/>
  		<xsl:param name="prevpage" select="$currentpage - 1"/>
  		<xsl:param name="curview" select="@id"/> 
  		<xsl:param name="keyword" select="query/@keyword"/> 
  		<xsl:param name="direction" select="query/@direction"/> 
		<xsl:choose>
			<xsl:when test="$maxpage>15">
				<xsl:choose>
					<xsl:when test="$maxpage - $currentpage &lt; 7">
						<xsl:if test="$i != $n+1">
							<xsl:if test="$z &lt; $maxpage + 1">
								<td>
									<a href="">
   										<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$z"/>)</xsl:attribute>
   			 								<font style="font-size:12px">
    											<xsl:if test="$z=$currentpage">
    												<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    											</xsl:if>
    											<xsl:value-of select="$z"/>
    										</font>
   									</a>&#xA0;
								</td>
							</xsl:if>
      						<xsl:call-template name="pagenavigSearch">
	        					<xsl:with-param name="i" select="$i + 1"/>
	        					<xsl:with-param name="n" select="$n"/>
	        					<xsl:with-param name="z" select="$z+1"/>
      						</xsl:call-template>
						</xsl:if>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
     								<a href="">
      									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
      									<font style="font-size:12px"> > </font>
      								</a>
      							</td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       									<font style="font-size:12px; margin-left:7px"> >> </font>
       								</a> 
						        </td>
							</xsl:if>
   						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$currentpage &lt; 7">
								<xsl:if test="$i=1">
									<xsl:if test="$currentpage = 1">
										<td>
											&#xA0;&#xA0;&#xA0;&#xA0;	
										</td>
										<td>
											&#xA0;&#xA0;&#xA0;
										</td>
									</xsl:if>
								</xsl:if>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<td>
											<a href="">
   				 								<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$i"/>)</xsl:attribute>
												<font style="font-size:12px">
    												<xsl:if test="$i=$currentpage">
    													<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    												</xsl:if>
    												<xsl:value-of select="$i"/>
    											</font>
						   					</a>&#xA0;
										</td>
									</xsl:if>
      								<xsl:call-template name="pagenavigSearch">
	        							<xsl:with-param name="i" select="$i + 1"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
      								</xsl:call-template>
      							</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<xsl:if test="$startnum !=0">
											<td>
												<a href="">
   				 									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$startnum"/>)</xsl:attribute>
													<font style="font-size:12px">
    													<xsl:if test="$startnum=$currentpage">
    														<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    													</xsl:if>
    													<xsl:value-of select="$startnum"/>
    												</font>
						   						</a>&#xA0;
											</td>
										</xsl:if>
									</xsl:if>
									<xsl:if test="$startnum != 0">
      									<xsl:call-template name="pagenavigSearch">
											<xsl:with-param name="i" select="$i + 1"/>
	        								<xsl:with-param name="n" select="$n"/>
	        								<xsl:with-param name="c" select="$c+1"/>
	        								<xsl:with-param name="startnum" select="$c - 6"/>
      									</xsl:call-template>
      								</xsl:if>
									<xsl:if test="$startnum = 0">
      									<xsl:call-template name="pagenavigSearch">
										<xsl:with-param name="i" select="$i"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
	        							<xsl:with-param name="startnum" select="$c - 6"/>
      								</xsl:call-template>
      							</xsl:if>
      						</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
      								<a href="">
     									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
     									<font style="font-size:12px"> > </font>
     								</a>
							    </td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       									<font style="font-size:12px; margin-left:7px"> >> </font>
       								</a> 
							    </td>
							</xsl:if>
  						</xsl:if>
						
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$i=1">
					<xsl:if test="$currentpage = 1">
						<td>
							&#xA0;&#xA0;&#xA0;&#xA0;	
						</td>
						<td>
							&#xA0;&#xA0;&#xA0;
						</td>
					</xsl:if>
				</xsl:if>
				<xsl:if test="$i != $n+1">
					<xsl:if test="$i &lt; $maxpage + 1">
						<td>
							<a href="">
   								<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$i"/> )</xsl:attribute>
   			 					<font style="font-size:12px">
    								<xsl:if test="$i=$currentpage">
    									<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    								</xsl:if>
    								<xsl:value-of select="$i"/>
    							</font>
						    </a>&#xA0;
						</td>
					</xsl:if>
      				<xsl:call-template name="pagenavigSearch">
	        			<xsl:with-param name="i" select="$i + 1"/>
	        			<xsl:with-param name="n" select="$n"/>
	        			<xsl:with-param name="c" select="$c+1"/>
      				</xsl:call-template>
				</xsl:if>
				<xsl:if test="$currentpage != $maxpage">
					<xsl:if test="$i = $n+1">
						<td>
      						<a href="">
      							<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>', <xsl:value-of select="$nextpage"/>)</xsl:attribute>
      							<font style="font-size:12px"> > </font>
      						</a>
					    </td>
       					<td>
       						<a href="">
       							<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$maxpage"/> );</xsl:attribute>
       							<font style="font-size:12px; margin-left:7px"> >> </font>
       						</a> 
						</td>
					</xsl:if>
   				</xsl:if>
   			</xsl:otherwise>
  		 </xsl:choose>
 	 </xsl:template>
 	 
	 <xsl:template name="combobox">
		<xsl:param name="i" select="1"/>
		<xsl:param name="k" select="query/@currentpage"/>
 		<xsl:param name="n" select="query/@maxpage + 1"/>
		<xsl:choose>
			<xsl:when test="$n > $i">
				<option>
 					<xsl:attribute name="value"> <xsl:value-of select="$i"/></xsl:attribute>
 					<xsl:if test="$k=$i">
 						<xsl:attribute name="selected">true</xsl:attribute>
 					</xsl:if>
 					<xsl:value-of select="$i"/>
 				</option>
				<xsl:call-template name="combobox">
	        		<xsl:with-param name="i" select="$i + 1"/>
	        		<xsl:with-param name="n" select="$n"/>
	        		<xsl:with-param name="k" select="query/@currentpage"/>
	        	</xsl:call-template>
		 	</xsl:when>
 		</xsl:choose>
	 </xsl:template>
	 
	 <xsl:template name="sortingcell">
		<xsl:param name="namefield"/>
		<xsl:param name="sortorder"/>
		<xsl:param name="sortmode"/>
		<img src="/SharedResources/img/iconset/br_up.png" style="height:12px; width:12px; margin-right:7px; cursor:pointer">
			<xsl:attribute name="onclick">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
			<xsl:if test="$sortorder = 'ASC' and $sortmode = 'ON'">
				<xsl:attribute name="onclick">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','desc')</xsl:attribute>
				<xsl:attribute name="src" select="'/SharedResources/img/iconset/br_up_green.png'"/>
			</xsl:if>
		</img>
		<font style="vertical-align:2px; cursor:pointer">
			<xsl:attribute name="onclick">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
			<xsl:if test="$sortorder = 'ASC' and $sortmode = 'ON'">
				<xsl:attribute name="onclick">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','desc')</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="//captions/*[name() = lower-case($namefield)]/@caption"/>
		</font>
		<img src="/SharedResources/img/iconset/br_down.png" style="margin-left:7px; height:12px; width:12px; cursor:pointer">
			<xsl:attribute name="onclick">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','desc')</xsl:attribute>
			<xsl:if test="$sortorder = 'DESC' and $sortmode = 'ON'">
				<xsl:attribute name="onclick">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
				<xsl:attribute name="src" select="'/SharedResources/img/iconset/br_down_green.png'"/>
			</xsl:if>
		</img>
	 </xsl:template>
</xsl:stylesheet>