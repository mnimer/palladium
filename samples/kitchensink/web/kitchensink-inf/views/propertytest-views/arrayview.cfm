Property Test Examples: "Arrayview.cfm"
<br/><br/>

<a href="../">Back</a><br/>

<cfdump var="#request#" expand="false"/>

<cfoutput>
<cfloop index="i" from="1" to="#arrayLen(request.data)#">
    <cfset item = request.data[i]>
    <cfif isSimpleValue( item )>
        #item# <br/>
    <cfelse>
        <cfdump var="#item#"><br/>
    </cfif>
</cfloop>
</cfoutput>

<hr/>
<br/><br/>
<cfdump var="#request#" expand="false"/>