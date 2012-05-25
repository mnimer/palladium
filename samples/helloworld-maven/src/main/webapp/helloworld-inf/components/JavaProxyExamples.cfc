<!---
  Created by IntelliJ IDEA.
  User: mnimer
  Date: 5/24/12
  Time: 12:33 PM
  To change this template use File | Settings | File Templates.
--->
<cfcomponent>

        <cffunction name="ping" returnformat="JSON">

                <cfset results = structNew()>
                <cfset results['data'] = now()>
                <cfset results['status'] = "ok">
                <cfset results['currentTemplate'] = getCurrentTemplatePath()>
                <cfreturn RESULTS>
        </cffunction>


</cfcomponent>
