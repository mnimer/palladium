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

<cfcomponent output="false" hint="I represent a listener for a message, containing its target and the name of the listener function.">

<cfproperty name="target" hint="The listener (Observer) object." />
<cfproperty name="listenerFunction" hint="The name of the listener function." />

<cfset this.target = "" />
<cfset this.listenerFunction = "" />

<cffunction name="invokeListener" hint="I invoke the listener function.">
	<cfargument name="eventContext" hint="The event context for the invokation." />
	
	<cfinvoke component="#this.target#" method="#this.listenerFunction#">
		<cfinvokeargument name="event" value="#arguments.eventContext#" />
	</cfinvoke>
</cffunction>

</cfcomponent>
