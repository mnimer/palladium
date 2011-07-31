
<cfimport taglib="../.." prefix="ex">
<ex:detail error=#error#>
<cfoutput>
Could not access a java object field called <b>#error.message#</b>.
</cfoutput>
</ex:detail>
