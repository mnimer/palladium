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

<cfcomponent output="false" extends="ModelGlue.gesture.controller.Controller" beans="modelglue.eventGenerator">

<cffunction name="generateEvent" output="false" hint="If the requested event doesn't exist, I generate its XML as well as code stubs for a listener and a view.">
	<cfargument name="event" />
	
	<cfset var eventName = arguments.event.getValue(arguments.event.getValue("eventValue")) />
	
	<cfif getModelGlue().getConfigSetting("generationEnabled") and not getModelGlue().hasEventHandler(eventName)>
		<cfset event.addTraceStatement("Event Generation", "Generating ""#eventName#""") />
		
		<cfset beans.modelglueEventGenerator.generateEvent(arguments.event) />
		
		<cfset arguments.event.addResult("configurationInvalidated") />
	</cfif>
</cffunction>

</cfcomponent>
