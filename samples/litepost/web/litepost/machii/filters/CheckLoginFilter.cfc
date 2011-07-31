<!--- 
	  
  Copyright (c) 2006, Chris Scott, Matt Woodward, Adam Wayne Lehman, Dave Ross
  All rights reserved.
	
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
       http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

	$Id: CheckLoginFilter.cfc 81 2006-10-20 17:11:52Z mpwoodward $
--->

<cfcomponent
	displayname="CheckLoginFilter"
	extends="MachII.framework.EventFilter"
	output="false" 
	hint="CheckLogin filter for Litepost">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" output="false" returntype="void"
		hint="Configures the event-filter.">
		<!--- Does nothing. --->
	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="filterEvent" access="public" output="false" returntype="boolean" 
			hint="Filters event and returns a boolean to Mach-II indicating whether or not the event queue<br /> 
			should proceed.  If not, the event queue is cleared and a new event is announced.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfset var proceed = false />
		
		<cfif event.getArg("isAdmin")>
			<cfset proceed = true />
		<cfelse>
			<cfset arguments.eventContext.clearEventQueue() />
			<cfset arguments.event.setArg("message", "Either you are not logged in or your session has expired. Please log in.") />
			<cfset arguments.eventContext.announceEvent("showLogin", arguments.event.getArgs()) />
		</cfif>
		
		<cfreturn proceed />
	</cffunction>

</cfcomponent>