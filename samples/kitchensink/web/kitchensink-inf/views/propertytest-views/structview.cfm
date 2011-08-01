Property Test Examples:  "Structview.cfm"
<br/><br/>

<a href="../">Back</a><br/>

<cfdump var="#request#" expand="false"/>

<cfoutput>
Keys: #structKeyList(request.data)#
<br/><br/>
<cfloop collection="#request.data#" item="item">
    <b>#item# - #isSimpleValue( request.data[item] )#</b><br/>

    <cfif isSimpleValue( request.data[item] )>
       "#request.data[item]#"<br/>
    <cfelse>
        <cfdump var="#request.data[item]#"><br/>
    </cfif>
</cfloop>
</cfoutput>


<br/><br/>
<cfdump var="#request#" expand="false"/>