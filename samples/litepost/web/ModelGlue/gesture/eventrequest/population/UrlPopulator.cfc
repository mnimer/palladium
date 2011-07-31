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

<cfcomponent output="false" extends="ModelGlue.gesture.eventrequest.population.StructBasedPopulator"
					   hint="I populate an event context from the url scope.  The values are determined by the assigned UrlManager instance."
>

<cffunction name="setUrlManager" output="false" hint="I set the URL manager to use.">
	<cfargument name="urlManager" />
	<cfset variables._urlManager = arguments.urlManager />
</cffunction>

<cffunction name="populate" output="false" hint="I receive a structure and an event context and populate the event context from the structure.">
	<cfargument name="context" hint="EventContext to populate." />
	
	<cfset super.populate(context, variables._urlManager.extractValues()) />
	
	<cfset variables._urlManager.populateLocation(arguments.context) />
</cffunction>

</cfcomponent>
