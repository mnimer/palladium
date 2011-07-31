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

<cfcomponent output="false" extends="ModelGlue.gesture.controller.Controller">

<cffunction name="addNamedResult" access="public" output="false" returntype="void">
	<cfargument name="event" type="any" required="true" />
	
	<cfset arguments.event.addResult("target") />
</cffunction>

<cffunction name="addFormatNamedResult" access="public" output="false" returntype="void">
	<cfargument name="event" type="any" required="true" />
	
	<cfset arguments.event.addResult("formatTarget") />
</cffunction>

<cffunction name="message" access="public" output="false" returntype="void">
	<cfargument name="event" type="any" required="true" />
	
	<cfset var messageFormats = arguments.event.getValue("messageFormats") />
	
	<cfset messageFormats = listAppend(messageFormats, "none") />
	
	<cfset arguments.event.setValue("messageFormats", messageFormats) />
</cffunction>

<cffunction name="formatMessage" access="public" output="false" returntype="void">
	<cfargument name="event" type="any" required="true" />
	
	<cfset var messageFormats = arguments.event.getValue("messageFormats") />
	
	<cfset messageFormats = listAppend(messageFormats, "format") />
	
	<cfset arguments.event.setValue("messageFormats", messageFormats) />
</cffunction>

</cfcomponent>
