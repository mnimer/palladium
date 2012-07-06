<cfcomponent>

    <cffunction name="queryToExcel">
        <cfargument name="dir">
        <cfargument name="fileName">
        <cfargument name="query">

        <cfif not directoryExists(expandPath(dir))>
            <cfdirectory action="create" directory="#expandPath(dir)#">
        </cfif>

        <cfspreadsheet
                action = "write"
                filename="#expandPath(dir)#/#fileName#"
                query="query"
                overwrite="true">
    </cffunction>



    <cffunction name="readExcel">
        <cfargument name="dir">
        <cfargument name="fileName">
        <cfargument name="format" default="html">

        <cfspreadsheet
                action="read"
                format="#format#"
                src="#expandPath(dir)#/#fileName#"
                name="myQuery"/>

        <cfreturn myQuery>
    </cffunction>



    <cffunction name="readExcelQuery">
        <cfargument name="dir">
        <cfargument name="fileName">
        <cfargument name="endRow">

        <cfspreadsheet
                action="read"
                src="#expandPath(dir)#/#fileName#"
                rows="1-#endRow#"
                query="myQuery"/>

        <cfreturn myQuery>
    </cffunction>




    <cffunction name="dump">
        <cfargument name="data">

        <cfsavecontent variable="dump">
            <cfdump var="#data#" expand="true"/>
        </cfsavecontent>

        <cfreturn dump>
    </cffunction>
</cfcomponent>