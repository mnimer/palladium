

<cfimport taglib="../.." prefix="ex">
<ex:detail error=#error#>
<cfinclude template="../../udf.cfm">
<cfoutput>
Error casting an object of type <b>#encodeForErrorSmart(error.message)#</b> to an incompatible type.  This usually
indicates a programming error in Java, although it could also mean you
have tried to use a foreign object in a different way than it was designed.
</cfoutput>
</ex:detail>
