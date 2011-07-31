<cfimport taglib="../.." prefix="ex">
<cfinclude template="../../udf.cfm">
<cfoutput>
<html>
<head>
	<title>#encodeForError(error.message)#</title>
</head>
<body>

<table border="1" cellpadding="3" bordercolor="##000808" bgcolor="##e7e7e7">
	<tr>
        <td>
		    <table cellpadding="0" cellspacing="0" border="0" width="500">
		    <tr>
		        <td id="tableProps2" align="left" valign="middle">
		            <h1 id="textSection1" style="COLOR: black; FONT: 13pt/15pt verdana">
		            #encodeForError(error.message)#
		            </h1>
		        </td>
		    </tr>
		    <tr>
		        <td id="tablePropsWidth" colspan="2">
		            <font style="COLOR: black; FONT: 8pt/11pt verdana">
		            #encodeForError(error.detail)#
		            </font>
		        </td>
		    </tr>
			</table>
		</td>
	</tr>
</table>

</body>
</html>

</cfoutput>

