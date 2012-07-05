<cfcomponent>

        <cffunction name="findArtist">
                <cfargument name="filter" type="string">
                <cfargument name="query">

                <cfquery name="filteredQuery" dbtype="query">
                        select * from query
                        where LOWER(Name) like '%#filter.toLowerCase()#%'
                </cfquery>


                <cfset results = structNew()>
                <cfset results['filteredQuery'] = filteredQuery>
                <cfset results['currentTemplate'] = getCurrentTemplatePath()>
                <cfreturn RESULTS>
        </cffunction>


        <cffunction name="dump">
                <cfargument name="data">

                <cfsavecontent variable="dump">
                    <cfdump var="#data#" expand="true"/>
                </cfsavecontent>

                <cfreturn dump>
        </cffunction>
</cfcomponent>