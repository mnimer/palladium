<cfimport taglib="../.." prefix="ex"/>
<ex:detail error=#error#>
<cfoutput>
Structs, queries, arrays, etc cannot be automatically converted into simple
types by ColdFusion.  For this reason, code such as that shown below will cause
this error.
<br>
<Br>
<cfset l = "&lt;">
<cfset g = "&gt;">
<pre>
#l#cfset x = structnew()#g#
#l#cfset y = arraynew(1)#g#
#l#cfset z = querynew("q")#g#
#l#cfoutput#g#
##x## #l#-- complex expression --#g#
##y## #l#-- complex expression --#g#
##z## #l#-- complex expression --#g#
#l#/cfoutput#g#
</pre>

<br>
<br>
</cfoutput>
</ex:detail>
