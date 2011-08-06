<cfcomponent>

    <cffunction name="onRequestStart">
        <cfargument name="template"/>


        <cfif isDefined("request.palladium.version")>
            <cfinclude template="#template#">
            <cfabort/>
        <cfelse>
            <cflocation url="/kitchensink/index.html"/>
        </cfif>

    </cffunction>
</cfcomponent>