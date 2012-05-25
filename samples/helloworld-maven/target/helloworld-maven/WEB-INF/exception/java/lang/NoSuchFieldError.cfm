
<cfimport taglib="../.." prefix="ex">
<ex:detail error=#error#>
<cfinclude template="../../udf.cfm">
<cfoutput>
Could not access a java object field called <b>#encodeForErrorSmart(error.message)#</b>.
</cfoutput>
</ex:detail>
