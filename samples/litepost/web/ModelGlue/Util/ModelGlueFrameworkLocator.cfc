<!---
LICENSE INFORMATION:

Copyright 2010, Joe Rinehart, Dan Wilson

Licensed under the Apache License, Version 2.0 (the "License"); you may not 
use this file except in compliance with the License. 

You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 
	
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.

VERSION INFORMATION:

This file is part of Model-Glue 'Gesture' 3.1 Maintenance Release Candidate (3.1.299).

The version number in parentheses is in the format versionNumber.subversion.revisionNumber.
--->

<cfcomponent output="false" hint="""Static"" component for finding instances of Model-Glue.">

<cffunction name="findInScope" output="false" returntype="array" hint="Finds all or specific instances of Model-Glue within a given scope (or any struct, for that matter).">
	<cfargument name="scope" type="struct" required="true" />
	<cfargument name="scopeKey" type="string" required="false" />
	
	<cfset var key = "" />
	<cfset var mgInstance = "" />
	<cfset var result = arrayNew(1) />
	
	<!--- Find ModelGlue instances in the application scope. --->
	<cfloop collection="#scope#" item="key">
		<cfif isObject(scope[key]) and getMetadata(scope[key]).name eq "ModelGlue.gesture.ModelGlue">
			<cfif not structKeyExists(arguments, "scopeKey") or arguments.scopeKey eq key>
				<cfset arrayAppend(result, scope[key]) />
			</cfif>
		</cfif>
	</cfloop>
	
	<cfreturn result />
</cffunction>

</cfcomponent>
