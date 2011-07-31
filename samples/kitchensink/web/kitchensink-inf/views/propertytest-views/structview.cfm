Property Test Examples:
<br/><br/>

<a href="../">Back</a><br/>

<cfdump var="#request#" expand="false"/>

<cfoutput>
<cfloop collection="#request.data#" item="item">
    <b>#item#</b>
    <cfif isSimpleValue( request.data[item] )>
        #request.data[item]# <br/>
    <cfelse>
        <cfdump var="#request.data[item]#"><br/>
    </cfif>
</cfloop>
</cfoutput>


<br/><br/>
<cfdump var="#request#" expand="false"/>