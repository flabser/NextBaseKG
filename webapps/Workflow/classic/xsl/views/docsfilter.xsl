<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/form.xsl"/>
	<xsl:variable name="doctype">
		<xsl:choose>
			<xsl:when test="request/document/fields/tasktype = 'RESOLUTION'">
				<xsl:value-of select="request/document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="not (request/document/fields/tasktype)  and  request/document/@parentdocid != '' and request/document/@parentdoctype != 897 and  request/document/@parentdocid != 0">
				<xsl:value-of select="request/document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="request/document/fields/tasktype ='CONSIGN'">
				<xsl:value-of select="request/document/captions/kp/@caption"/>
			</xsl:when>
			<xsl:when test="request/document/@parentdocid = 0">
				<xsl:value-of select="request/document/captions/task/@caption"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="request/document/captions/kp/@caption"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title></title>		
				<link rel="stylesheet" href="classic/css/form.css"/>
				<script>
					$(function() {
							var dates = $( "#enddatefrom, #enddateto" ).datepicker({
							defaultDate: "+1w",
							showOn: "button",
							buttonImage: '/SharedResources/img/iconset/calendar.png',
							buttonImageOnly: true,
							changeMonth: true,
							numberOfMonths: 1,
							onSelect: function( selectedDate ) {
								enabledChbox('checkdatefilter')
								var option = this.id == "enddatefrom" ? "minDate" : "maxDate",
								instance = $( this ).data( "datepicker" ),
								date = $.datepicker.parseDate(
								instance.settings.dateFormat ||
								$.datepicker._defaults.dateFormat,
								selectedDate, instance.settings );
								dates.not( this ).datepicker( "option", option, date );
								}
						});
						});
				</script>
				<script>
					$(document).ready(function(){
					    $.ajax({
							url: "Provider?type=query&amp;id=bossandemppicklist",
							dataType: "xml",
							success: function( xmlResponse ) {
								var data = $( "entry[doctype=889]", xmlResponse ).map(function() {
									return {
										value: $(this).attr("viewtext"),
										id: $(this).children("userid").text()
									};
								}).get();
									$( "input[name=authorfiltername]" ).autocomplete({
										source: data,
										minLength: 0,
										select: function(event, ui) {
											enabledChbox('checkauthorfilter')
											$("input[name=authorfilter]").val(ui.item.id)
										},
										change: function() {
											
										}
									});
									
								}
							});
						});
  				</script>
			</head>			
			<body style="background:#fff; width:300px">
				<table style="margin-top:20px">
					<tr>
						<td style="color:#2E6EAF; font-size:14px; padding-left:13px"><xsl:value-of select="columns/column[@id='FILTERNAME']/@caption"/></td>
						<td style="padding-left:20px">
							<input type="text" class="td_editable"  name="filtername" style="width:314px"/>
							<input type="hidden" class="td_editable"  name="filtermode"  value="1"/>
							<input type="hidden" class="td_editable"  name="filteridfilter"  value=""/>
						</td>
					</tr>
				</table>
				<table style="margin-top:15px;">
					<tr>
						<td>
<!-- 							<input type="checkbox" name="checkdoctypefilter"/> -->
						</td>
						<td style="text-align:left"><xsl:value-of select="columns/column[@id='DOCTYPE']/@caption"/></td>
						<td style="padding-left:10px">
							<select size="1" name="doctypefilter" style="width:324px;" class="select_editable" onchange="javascript:enabledChbox('checkdoctypefilter')">
								<option value="in">
									<xsl:value-of select="columns/column[@id='IN']/@caption"/>
								</option>
								<option value="ish">
									<xsl:value-of select="columns/column[@id='ISH']/@caption"/>
								</option>
								<option value="task">
									<xsl:value-of select="columns/column[@id='TASK']/@caption"/>
								</option>
								<option value="sz">
									<xsl:value-of select="columns/column[@id='SZ']/@caption"/>
								</option>
								<option value="obr">
									<xsl:value-of select="columns/column[@id='OBR']/@caption"/>
								</option>
								<option value="workprj">
									<xsl:value-of select="columns/column[@id='WORKDOCPRJ']/@caption"/>
								</option>
								<option value="outdocprj">
									<xsl:value-of select="columns/column[@id='OUTDOCPRJ']/@caption"/>
								</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="checkprojectfilter"/>
						</td>
						<td style="text-align:left"><xsl:value-of select="columns/column[@id='PROJECT']/@caption"/></td>
						<td style="padding-left:10px">
							<select size="1" name="projectfilter" style="width:324px;" class="select_editable" onchange="javascript:enabledChbox('checkprojectfilter')">
								<xsl:for-each select="glossaries/projectsprav/query/entry">
									<option value="{@docid}">
										<xsl:value-of select="@viewtext"/>
									</option>
								</xsl:for-each>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="checkauthorfilter"/>
						</td>
						<td style="text-align:left"><xsl:value-of select="columns/column[@id='AUTHOR']/@caption"/></td>
						<td style="padding-left:10px"><input type="text" class="td_editable" name="authorfiltername" style="width:314px"/><input type="hidden" class="td_editable" name="authorfilter" style="width:314px"/></td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="checkcategoryfilter"/>
						</td>
						<td style="text-align:left"><xsl:value-of select="columns/column[@id='CATEGORY']/@caption"/></td>
						<td style="padding-left:10px">
							<select size="1" name="categoryfilter" style="width:324px;" class="select_editable" onchange="javascript:enabledChbox('checkcategoryfilter')">
								<xsl:for-each select="glossaries/docscat/query/entry">
									<option value="{@docid}">
										<xsl:value-of select="@viewtext"/>
									</option>
								</xsl:for-each>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="checkdatefilter"/>
						</td>
						<td style="text-align:left"><xsl:value-of select="columns/column[@id='REGDATE']/@caption"/></td>
						<td style="padding-left:10px; text-align:left">
							<font style="vertical-align:5px"><xsl:value-of select="columns/column[@id='FROM']/@caption"/></font> 
							<input type="text" name="datefromfilter" id="enddatefrom" class="td_editable" style="width:80px; vertical-align:top; margin-left:5px ; margin-right:5px"/> 
							<font style="vertical-align:5px; margin-left:5px"><xsl:value-of select="columns/column[@id='TO']/@caption"/> </font>
							<input type="text" value="" name="datetofilter" id="enddateto" class="td_editable" style="width:80px; vertical-align:top;  margin-left:5px ;"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="checkkeywordfilter"/>
						</td>
						<td style="text-align:left"><xsl:value-of select="columns/column[@id='KEYWORD']/@caption"/></td>
						<td style="padding-left:10px"><input type="text" class="td_editable" value="" name="keywordfilter" style="width:314px" onkeypress="javascript:enabledChbox('checkkeywordfilter')"/></td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>