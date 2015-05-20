<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="pagetitle">
		<xsl:variable name="entryid" select="//current_outline_entry/response/content/entry/@id"/>
		<xsl:if test="//current_outline_entry/response/content/entry != //response/content/outline/outline/entry[@id = $entryid]/@caption"> 
			<xsl:value-of select="//response/content/outline/outline/entry[@id = $entryid]/@caption"/>
		</xsl:if>
		<xsl:if test="//current_outline_entry/response/content/entry = //response/content/outline/outline/entry[@id = $entryid]/@caption or not(//response/content/outline/outline/entry[@id = $entryid]/@caption)">
		  	<xsl:value-of select="//current_outline_entry/response/content/entry"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="outline-section-state">
		<script>
			if($.cookie("HELP_<xsl:value-of select='@id'/>") != 'null'){
				$("#<xsl:value-of select='@id'/>").css("display",$.cookie("HELP_<xsl:value-of select='@id'/>"))
				if($.cookie("HELP_<xsl:value-of select='@id'/>") == "none"){
					$("img.<xsl:value-of select='@id'/>toogle_img").attr("src","/SharedResources/img/iconset/bullet_arrow_next.png")							
<!-- 					$("img.<xsl:value-of select='@id'/>folder_img").attr("src","/SharedResources/img/classic/1/folder_close_view.png")							 -->
				}else{
					$("img.<xsl:value-of select='@id'/>toogle_img").attr("src","/SharedResources/img/iconset/bullet_arrow_down.png")							
<!-- 					$("img.<xsl:value-of select='@id'/>folder_img").attr("src","/SharedResources/img/classic/1/folder_open_view.png") -->
				}
			} 
		</script>	
	</xsl:template>
	<xsl:variable name="current_outline" ><xsl:value-of select="//current_outline_entry/response/content/entry/@pageid" /></xsl:variable>
	<xsl:template name="outline-menu-view">	
		<div id="outline-container">
			<div id="outline-header" style="padding-top:7px;">
				<div style="float:left;" >
					<a href="javascript:return false" onclick="javascript:history.back();" title="{//captions/back/@caption}" style="padding-left:10px">
						<img src="/SharedResources/img/iconset/arrow_180.png" height="20px"/>
					</a>
					<a href="javascript:return false" onclick="javascript:history.forward();" title="{//captions/forward/@caption}"  style="padding-left:5px">
						<img src="/SharedResources/img/iconset/arrow.png" height="20px"/>
					</a>
					<a href="{//response/content/outline/entry[@id='homepage']/@url}" title="{//response/content/outline/entry[@id='homepage']/@caption}" style="padding-left:10px;">
						<img src="/SharedResources/img/iconset/home-icon.png" height="24px"/>
					</a>
					<a href="{//response/content/outline/entry[@id='favdocs']/@url}" title="{//response/content/outline/entry[@id='favdocs']/@caption}" style="padding-left:10px">
						<img src="/SharedResources/img/iconset/star_full.png" height="24px"/>
					</a>
					<div class="search-wrapper" style="padding:3px 0 0 15px">
						<div class="search-wrapper cf">
							<input type="text" id="searchInput" name="searchInput"  placeholder="{//captions/search/@caption}..." required=""/>
							<script>
								$('#searchInput').keyup(function(e){
								    if(e.keyCode == 13)
								    {
								        search()
								    }
								});
							</script>
							<button type="submit" title="{page/captions/search/@caption}">
								<xsl:attribute name="onclick">javascript:search()</xsl:attribute> 
								<xsl:value-of select="//captions/search/@caption"/>
							</button>
						</div>
					</div>
				</div>
				
			</div>
			<xsl:for-each select="//share_navi/response/content/outline">

                    <xsl:if test="@id !='favdocs' and (@id != 'recyclebin') and @id!='homepage' ">
                        <div style="padding-top:5px;">
                            <div>
                                <div class="treeentry" onclick="javascript:ToggleCategory(this)" style="height:20px">
                                    <img src="/SharedResources/img/iconset/bullet_arrow_next.png" style="margin-left:6px; cursor:pointer;" alt="" class="{@id}toogle_img"/>
                                    <font style="font-family:Verdana, Arial, Helvetica, sans-serif !important; font-size:14px; margin-left:4px; vertical-align:top">
                                        <xsl:value-of select="@hint"/>
                                    </font>
                                </div>
                            </div>

                            <div class="outlineEntry" id="{@id}">
                                <xsl:call-template name="outline-section-state"/>
                                <xsl:call-template name = "outline-tree"/>
                            </div>
                        </div>
                    </xsl:if>
			</xsl:for-each>
		</div>
		 
<!-- 		<div id="resizer" onclick="javascript: closepanel()"> -->
<!-- 		<div id="resizer"> -->
<!-- 			<span id="iconresizer"  style="margin-left:-6px; position:relative; top:49%"></span> -->
<!-- 		</div> -->
	</xsl:template>
	<xsl:template name="outline-tree">
		<div style="padding-left:20px">
		<xsl:for-each select="entry">
			<xsl:if test="@id !='favdocs' and (@id != 'recyclebin') and @id!='homepage' ">
				<div class="entry treeentry" >
					<xsl:if test="$current_outline = @id">
						<xsl:attribute name="class">entry treeentrycurrent</xsl:attribute>										
					</xsl:if> 
					<xsl:if test="./entry">
						<div onclick ="javascript:ToggleCategory(this)" style="cursor: pointer; text-align:right; display:inline-block">
							<img src="/SharedResources/img/iconset/bullet_arrow_down.png" class="{@id}toogle_img"/>
						</div>
					</xsl:if>
					<xsl:if test="not(./entry)">
						<xsl:attribute name="style" >margin-left:18px</xsl:attribute>
					</xsl:if>
					<div class="viewlink">
						<xsl:if test="$current_outline = @id">
								<xsl:attribute name="class">viewlink viewlink_current</xsl:attribute>										
						</xsl:if> 
						<a href="{@url}" title="{@caption}">
							<div>
								<img src="/SharedResources/img/iconset/page_white_text.png" height="16"/>
								<xsl:if test="@id ='recyclebin'">
									<img src="/SharedResources/img/iconset/bin.png" height="17px"/>
								</xsl:if>													 
								<font class="viewlinktitle">												
									 <xsl:value-of select="@caption"/>
								</font>
							</div>
						</a>
					</div>
					</div>
					<xsl:if test="./entry">
					 	<xsl:call-template name = "outline-tree"/>
					 </xsl:if> 	
				
			</xsl:if>
		</xsl:for-each>
		</div>
	</xsl:template>
	<xsl:template name="header-view">	
		<div id="header-view" >
	     	<span style="float:left;  padding-top:3px">
                <img src="/SharedResources/logos/help-icon.png" style="height:35px; margin-left:10px; " />
				<font style="font-size:1.6em; color:#2D2D2D; margin-left:6px; vertical-align:5px">
					<xsl:value-of select="//captions/app_title/@caption" />	
				</font>
			</span>
			<span style="float:right; padding:5px 5px 5px 0px;text-align:right" > 
				<a href="Logout" id="logout" style="text-decoration:none; color:#555555; font:11px Tahoma; font-weight:bold; margin-right:5px">
					<xsl:attribute name="title"><xsl:value-of select ="//captions/logout/@caption"/></xsl:attribute>
					<xsl:value-of select="//captions/logout/@caption"/> 
				</a> 
				<!-- <div class="sarea" style="margin-top:15px; text-align:right">
					<input id="searchInput" style="padding:0.3em 0.9em; width:200px; margin-right:3px; vertical-align:top">
						<xsl:attribute name="value"><xsl:value-of select="//current_outline_entry/response/content/search"/></xsl:attribute>
					</input> 
					<button id="btnsearch" style="vertical-align:top; text-align:center">
						<xsl:attribute name ="title"><xsl:value-of select="page/captions/search/@caption"/></xsl:attribute>
						<xsl:attribute name="onclick">javascript:search()</xsl:attribute>
						<img src="/SharedResources/img/iconset/magnifier.png" style="border:none; position:absolute; left:8px; top:5px; width:16px; height:16px"/>
					</button>
					<script type="text/javascript">    
				   		$(function(){
				   			$("#searchInput").keydown(function(e){if(e.which==13){search();}});
							$(".sarea button").button().css("width","30px").css("height","26px");
				    	});
		    		</script>
				</div> -->
			</span>				
		</div>
	</xsl:template>
	
	<xsl:template name="pageinfo"> 
		<table style="width:100%;">
			<tr style="height:30px">
				<td style="text-align:left; padding-left:15px;">					 
					<font class="time" style="font-size:14px; padding-right:10px; font-weight:bold;">
						  
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
						&#xA0;<xsl:value-of select="page/captions/documents/@caption"/> : <xsl:value-of select="//query/@count"/>&#xA0;
					</font>
				</td>
			</tr>
		</table>
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
							<a href="" style="font-size:12px">
								<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=1&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
								&lt;&lt;
							</a>&#xA0;
						</td>
						<td>
							<a href="" style="font-size:12px">
								<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$prevpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
								&lt;
							</a>&#xA0;
						</td>
					</xsl:if>
					<xsl:call-template name="pagenavig"/>
					<xsl:if test="//query/@maxpage > 9">
						<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
                		<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
						<td>
							<select>
								<xsl:attribute name="onChange">jjavascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page="+this.value+"&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
			 					<xsl:call-template name="combobox"/>
			 				</select>
			 			</td>
					</xsl:if>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>	 
	
	 <xsl:template name="flashentry">	
		<xsl:if test="page/view_content/query/@flashdocid !=''">
			<script type="text/javascript">
				$("document").ready(
					function(){ flashentry(<xsl:value-of select="page/view_content/query/@flashdocid"/><xsl:value-of select="page/view_content/query/@flashdoctype"/>);}
				);
			</script>
		</xsl:if>	
	</xsl:template> 
	
	<xsl:template name="viewtable_dblclick_open">	
		<script>
			$("."+<xsl:value-of select="@docid"/>).dblclick(function(event){
  				if(event.target.nodeName != "INPUT" &amp;&amp; event.target.nodeName != "IMG"){
  					beforeOpenDocument();
  					window.location = '<xsl:value-of select="@url"/>'
  				}
			});
		</script>
	</xsl:template>
	
<!--	навигатор по страницам -->
	<xsl:template name="pagenavig">
 		<xsl:param name="i" select="1"/>  <!-- счетчик количества страниц отображаемых в навигаторе  -->
 		<xsl:param name="n" select="9"/> <!-- количество страниц отображаемых в навигаторе -->
  		<xsl:param name="z" select="//query/@maxpage - 8"/>
  		<xsl:param name="f" select="9"/>
 		<xsl:param name="c" select="//query/@currentpage"/> <!-- текущая страница в виде -->
 		<xsl:param name="startnum" select="//query/@currentpage - 4"/> 
  		<xsl:param name="d" select="//query/@maxpage - 8"/>	<!-- переменная для вычисления начального номера страницы в навигаторе  -->
  		<xsl:param name="currentpage" select="//query/@currentpage"/>
  		<xsl:param name="maxpage" select="//query/@maxpage"/>
  		<xsl:param name="nextpage" select="$currentpage + 1"/>
  		<xsl:param name="prevpage" select="$currentpage - 1"/>
  		<xsl:param name="curview" select="@id"/> 
  		<xsl:param name="direction" select="//@direction"/> 
		<xsl:choose>
			<xsl:when test="$maxpage > 9">
				<xsl:choose>
					<xsl:when test="$maxpage - $currentpage &lt; 4">
						<xsl:if test="$i != $n+1">
							<xsl:if test="$z &lt; $maxpage + 1">
								<td>
									<a href="" style="font-size:12px">
										<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$z'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
    									<xsl:if test="$z=$currentpage">
    										<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    									</xsl:if>
    									<xsl:value-of select="$z"/>
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
     								<a href="" style="font-size:12px">
     									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$nextpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
      									>
      								</a>
      							</td>
       							<td>
       								<a href="" style="font-size:12px; margin-left:7px">
       									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$maxpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
       									>>
       								</a> 
						        </td>
							</xsl:if>
   						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$currentpage &lt; 4">
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
											<a href="" style="font-size:12px">
												<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$i'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
    											<xsl:if test="$i=$currentpage">
    												<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    											</xsl:if>
    											<xsl:value-of select="$i"/>
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
												<a href="" style="font-size:12px">
													<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$startnum'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
    												<xsl:if test="$startnum=$currentpage">
    													<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    												</xsl:if>
    												<xsl:value-of select="$startnum"/>
						   						</a>&#xA0;
											</td>
										</xsl:if>
									</xsl:if>
									<xsl:if test="$startnum != 0">
      									<xsl:call-template name="pagenavig">
											<xsl:with-param name="i" select="$i + 1"/>
	        								<xsl:with-param name="n" select="$n"/>
	        								<xsl:with-param name="c" select="$c+1"/>
	        								<xsl:with-param name="startnum" select="$c - 3"/>
      									</xsl:call-template>
      								</xsl:if>
									<xsl:if test="$startnum = 0">
      									<xsl:call-template name="pagenavig">
										<xsl:with-param name="i" select="$i"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
	        							<xsl:with-param name="startnum" select="$c - 3"/>
      								</xsl:call-template>
      							</xsl:if>
      						</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
      								<a href="" style="font-size:12px">
      									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$nextpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
     									>
     								</a>
							    </td>
       							<td>
       								<a href="" style="font-size:12px; margin-left:7px">
       									<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$maxpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
       									>>
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
							<a href="" style="font-size:12px">
								<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$i'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
    							<xsl:if test="$i=$currentpage">
    								<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    							</xsl:if>
    							<xsl:value-of select="$i"/>
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
      						<a href="" style="font-size:12px">
      							<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$nextpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
      							>
      						</a>
					    </td>
       					<td>
       						<a href="" style="font-size:12px; margin-left:7px">
       							<xsl:attribute name="href">javascript:window.location.href="Provider?type=page&amp;id=<xsl:value-of select='@id'/>&amp;page=<xsl:value-of select='$maxpage'/>&amp;entryid=<xsl:value-of select='//current_outline_entry/response/content/entry/@entryid'/>&amp;title=<xsl:value-of select='//current_outline_entry/response/content/entry'/><xsl:value-of select='//current_outline_entry/response/content/customparam'/>"</xsl:attribute>
       							>>
       						</a> 
						</td>
					</xsl:if>
   				</xsl:if>
   			</xsl:otherwise>
  		 </xsl:choose>
 	 </xsl:template>
 	 
	 <xsl:template name="combobox">
		<xsl:param name="i" select="1"/>
		<xsl:param name="k" select="//query/@currentpage"/>
 		<xsl:param name="n" select="//query/@maxpage + 1"/>
		<xsl:if test="$n > $i">
			<option>
 				<xsl:attribute name="value"><xsl:value-of select="$i"/></xsl:attribute>
 				<xsl:if test="$k = $i">
 					<xsl:attribute name="selected">true</xsl:attribute>
 				</xsl:if>
 				<xsl:value-of select="$i"/>
 			</option>
			<xsl:call-template name="combobox">
	       		<xsl:with-param name="i" select="$i + 1"/>
	       		<xsl:with-param name="n" select="$n"/>
	       		<xsl:with-param name="k" select="//query/@currentpage"/>
	       	</xsl:call-template>
		</xsl:if>
	 </xsl:template>
	 
	 <xsl:template name="sortingcell">
		<xsl:param name="namefield"/>
		<xsl:param name="sortorder"/>
		<xsl:param name="sortmode"/>
		<a href="">
			<xsl:choose>
				<xsl:when test="$sortorder = 'ASC' and $sortmode = 'ON'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','desc')</xsl:attribute>
					<img src="/SharedResources/img/iconset/br_up_green.png" style="margin-right:7px; height:12px; width:12px"/>
				</xsl:when>
				<xsl:when test="$sortmode = 'OFF' or $sortorder = 'DESC'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
					<img src="/SharedResources/img/iconset/br_up.png" style="height:12px; width:12px; margin-right:7px"/>
				</xsl:when>
			</xsl:choose>
		</a>
		<a href="" class="actionlink">
			<xsl:attribute name="onmouseover">javascript:window.status='hello'; return true;</xsl:attribute>
			<xsl:choose>
				<xsl:when test="$sortorder = 'ASC' and $sortmode = 'ON'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','desc')</xsl:attribute>
				</xsl:when>
				<xsl:when test="$sortorder = 'DESC' and $sortmode = 'ON'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
				</xsl:when>
				<xsl:when test="$sortmode = 'OFF'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<font style="vertical-align:2px"><xsl:value-of select="page/captions/*[name() = lower-case($namefield)]/@caption"/></font>
		</a>
		<a href="">
			<xsl:choose>
				<xsl:when test="$sortorder = 'DESC' and $sortmode = 'ON'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','asc')</xsl:attribute>
					<img src="/SharedResources/img/iconset/br_down_green.png" style="margin-left:7px ; height:12px; width:12px"/>
				</xsl:when>
				<xsl:when test="$sortmode = 'OFF' or $sortorder = 'ASC'">
					<xsl:attribute name="href">javascript:sorting('<xsl:value-of select="/request/@id"/>','<xsl:value-of select="$namefield"/>','desc')</xsl:attribute>
					<img src="/SharedResources/img/iconset/br_down.png" style="margin-left:7px ; height:12px; width:12px"/>
				</xsl:when>
			</xsl:choose>
		</a>
	 </xsl:template>
	 <xsl:template name="hotkeys">
	 	<script type="text/javascript">
			$(document).ready(function(){
				
				$(".button_panel button").button();
				$(document).bind('keydown', function(e){
						if (e.ctrlKey) {
							switch (e.keyCode) {
						   case 78:
								<!-- клавиша n -->
						     	e.preventDefault();
						     	$("#btnNewdoc").click();
						     	break;
						   case 68:
						   		<!-- клавиша d -->
						     	e.preventDefault();
						     	$("#btnDeldoc").click();
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
			});
			<![CDATA[
				$(document).ready(function(){
					$("#btnNewdoc").hotnav({keysource:function(e){ return "n"; }});
					$("#btnDeldoc").hotnav({keysource:function(e){ return "d"; }});
					$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
					$("#logout").hotnav({keysource:function(e){ return "q"; }});
					$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
				});
			]]>
			$(document).ready(function(){
				outline.type = '<xsl:value-of select="@type"/>'; 
				outline.viewid = '<xsl:value-of select="@id"/>';
				outline.element = 'project';
				outline.command='<xsl:value-of select="current/@command"/>';
				outline.curPage = '<xsl:value-of select="current/@page"/>'; 
				outline.category = '';
				outline.filterid = '<xsl:value-of select="@id"/>';
<!-- 				refresher();   -->
			});
			
			$(function() {
			    $( "#outline-container" ).resizable({
			    handles: 'e',
			    resize: function( event, ui ){
			    	$(".viewframe").css("left", ui.size.width);
<!-- 			    	$(".viewframe").css("width", $(window).width()- ui.size.width); -->
			    }, 
			    minWidth:333,
			    maxWidth:1060,
			    });
			});
		</script>
	 </xsl:template>
	 
	 <xsl:template name="calendar">
	 	<xsl:if test="/request/@lang = 'KAZ'">
				<script>
					$(function() {
						$('.eventdate').datepicker({
							showOn: 'button',
							buttonImage: '/SharedResources/img/iconset/calendar.png',
							buttonImageOnly: true,
							regional:['ru'],
							showAnim: '',
							changeYear:  true,
							yearRange: '-200:+0',
							changeMonth: true,
							monthNames: ['Қаңтар','Ақпан','Наурыз','Сәуір','Мамыр','Маусым',
							'Шілде','Тамыз','Қыркүйек','Қазан','Қараша','Желтоқсан'],
							monthNamesShort: ['Қаңтар','Ақпан','Наурыз','Сәуір','Мамыр','Маусым',
							'Шілде','Тамыз','Қыркүйек','Қазан','Қараша','Желтоқсан'],
							dayNames: ['жексебі','дүйсенбі','сейсенбі','сәрсенбі','бейсенбі','жұма','сенбі'],
							dayNamesShort: ['жек','дүй','сей','сәр','бей','жұм','сен'],
							dayNamesMin: ['Жс','Дс','Сс','Ср','Бс','Жм','Сн'],
						});
					});
				</script>
			</xsl:if>
			<xsl:if test="/request/@lang = 'RUS'">
				<script>
					$(function() {
						$('.eventdate').datepicker({
							showOn: 'button',
							buttonImage: '/SharedResources/img/iconset/calendar.png',
							buttonImageOnly: true,
							regional:['ru'],
							showAnim: '',
							changeYear:  true,
							yearRange: '-200:+0',
							changeMonth: true
						});
					});
				</script>
		</xsl:if>
		<xsl:if test="/request/@lang = 'ENG'">
			<script>
				$(function() {
					$('.eventdate').datepicker({
						showOn: 'button',
						buttonImage: '/SharedResources/img/iconset/calendar.png',
						buttonImageOnly: true,
						regional:['en'],
						showAnim: '',
						changeYear : true,
						changeMonth : true,
						yearRange: '-100y:c+nn',
						monthNames: ['January','February','March','April','May','June',
						'July','August','September','October','November','December'],
						monthNamesShort: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
						'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
						dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
						dayNamesShort: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
						dayNamesMin: ['Su','Mo','Tu','We','Th','Fr','Sa'],
						weekHeader: 'Wk',
						firstDay: 1,
						isRTL: false,
						showMonthAfterYear: false,
					});
				});
			</script>
		</xsl:if>		
	 </xsl:template>
	 <xsl:template name="cssandscripts">
	 	<link type="text/css" rel="stylesheet" href="classic/css/outline.css"/>
		<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
		<link type="text/css" rel="stylesheet" href="classic/css/searchbox.css"/>
		<link media="print" rel="stylesheet" href="classic/css/print.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
		<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.8.3.min.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.resizable.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.button.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
		<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
		<script type="text/javascript" src="classic/scripts/outline.js"/>
		<script type="text/javascript" src="classic/scripts/view.js"/>
		<script type="text/javascript" src="classic/scripts/form.js"/>
		<script type="text/javascript" src="classic/scripts/page.js"/>
	 </xsl:template>
	 
	 <xsl:template name="attach">
		<div id="attach" >
			<table style="border:0; border-collapse:collapse; width:100%" id="upltable;">
				 
				<xsl:variable name='docid' select="document/@docid"/>
				<xsl:variable name='doctype' select="document/@doctype"/>
				<xsl:variable name='formsesid' select="formsesid"/>
				
				<xsl:for-each select="document/fields/rtfcontent/entry">
					<tr >
						<xsl:variable name='id' select='@hash'/>
						<xsl:variable name='filename' select='@filename'/>
						<xsl:variable name="extension" select="tokenize(lower-case($filename), '\.')[last()]"/>
						<xsl:variable name="resolution"/>
						<xsl:attribute name='id' select="$id"/>
						 
						<td>
							<xsl:choose>
								<xsl:when test="$extension = 'jpg' or $extension = 'jpeg' or $extension = 'gif' or $extension = 'bmp' or $extension = 'png'">
									<img class="imgAttr" title="{$filename}" style="border:1px solid lightgray; max-width:800px;">
<!-- 											<xsl:attribute name="onload">checkImage(this)</xsl:attribute> -->
										<xsl:attribute name='src'>Provider?type=getattach&amp;id=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
									</img>
								</xsl:when>
								<xsl:otherwise>
									<img src="/SharedResources/img/iconset/file_extension_{$extension}.png" style="margin-right:5px">
										<xsl:attribute name="onerror">javascript:changeAttIcon(this)</xsl:attribute>
									</img>
									<a style="vertical-align:5px">
										<xsl:attribute name='href'>Provider?type=getattach&amp;id=getatach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="@id"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
										<xsl:value-of select='$filename'/>
									</a>&#xA0;&#xA0;
								</xsl:otherwise>
							</xsl:choose>
						</td>
					</tr>
					<tr> 
						<td style="color:#777; font-size:12px; padding-left:25px">
							<xsl:if test="comment !=''">
								<xsl:value-of select="comment"/>
								<br/><br/>
							</xsl:if>
						</td>
					</tr>
				</xsl:for-each>
			</table>
			 
		</div>
	</xsl:template>
</xsl:stylesheet>