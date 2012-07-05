<cfcomponent>

    <cffunction name='urltopdf'>
        <cfargument name="url" type="string"/>


        <!--- Call a webpage--->
        <cfhttp url="#arguments.url#" method="get" resolveurl="yes">
        <!--- Convert content of webpage to PDF and Scale it --->
        <cfdocument name="pdf" format="PDF" localurl="no">
            <cfoutput>#cfhttp.fileContent#</cfoutput>
        </cfdocument>


        <cfset results = structNew()>
        <cfset results['pdf'] = pdf>
        <cfreturn results>
    </cffunction>
</cfcomponent>