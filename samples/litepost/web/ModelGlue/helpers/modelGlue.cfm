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

<cffunction name="showErrors" output="true">
	<cfargument name="errorCollection" />
	<cfargument name="property" default="" />

	<cfset var errors = "" />
	<cfset var i = "" />
	
	<cfif isObject(errorCollection)>
		<cfset errors = arguments.errorCollection.getErrors() />
		
		<cfif structKeyExists(errors, arguments.property)>
			<div class="error">
				<cfoutput>
					<cfloop from="1" to="#arrayLen(errors[arguments.property])#" index="i">
						#errors[arguments.property][i]#<br />
					</cfloop>
				</cfoutput>
			</div>	
		</cfif>
	</cfif>
</cffunction>
