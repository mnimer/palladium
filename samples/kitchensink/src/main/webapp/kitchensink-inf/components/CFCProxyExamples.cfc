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




        <cffunction name="createPDF">
            <cfargument name="html" type="string"/>

                <cfdump var="#html#" output="console"/>

            <cfset fileName =  "#getTempDirectory()#/#createUUID()#.pdf">
            <cfdocument name="pdf" overwrite="true" format="pdf" >
                    <cfoutput>#arguments.html#</cfoutput>
            </cfdocument>



            <cfset results = structNew()>
            <cfset results['pdf'] = pdf>
            <cfset results['filename'] = fileName>
            <cfreturn results>
        </cffunction>


</cfcomponent>
