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

  $Id: EntryListener.cfc 110 2006-10-21 04:38:39Z mpwoodward $

--->

<cfcomponent 
	displayname="EntryListener" 
	output="false" 
	extends="MachII.framework.Listener" 
	hint="The Entry listener for Litepost">

	<cffunction name="configure" returntype="void" access="public" output="false" hint="Configures this listener; called automatically by Mach-II">
		<!--- don't need to do anything here --->
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setEntryService" returntype="void" access="public" output="false" hint="Dependency: EntryService">
		<cfargument name="entryService" type="net.litepost.component.entry.EntryService" required="true" />
		<cfset variables.entryService = arguments.entryService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getEntry" returntype="net.litepost.component.entry.Entry" access="public" output="false" 
			hint="Returns an entry bean based on the entry ID in the event object">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var includeComments = true />
		<cfset var entry = 0 />
		
		<cfif arguments.event.isArgDefined("includeComments")>
			<cfset includeComments = arguments.event.getArg("includeComments") />
		</cfif>
		
		<cfset entry = variables.entryService.getEntryByID(arguments.event.getArg("entryID", 0), includeComments) />
		
		<cfif entry.isNull()>
			<cfset entry.init() />
		</cfif>
		
		<cfreturn entry />
	</cffunction>
	
	<cffunction name="getEntries" returntype="array" access="public" output="false" 
			hint="Returns an array of entry objects and comment objects">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var numToReturn = -1 />
		<cfset var activeOnly = true />
		
		<cfif arguments.event.isArgDefined("numToReturn")>
			<cfset numToReturn = arguments.event.getArg("numToReturn") />
		</cfif>
		
		<cfif arguments.event.isArgDefined("activeOnly")>
			<cfset activeOnly = arguments.event.getArg("activeOnly") />
		</cfif>
		
		<cfreturn variables.entryService.getEntries(arguments.numToReturn, arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getEntriesAsQuery" returntype="query" access="public" output="false" 
			hint="Returns a query object of entry objects (does not include comments)">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var numToReturn = -1 />
		<cfset var activeOnly = true />
		
		<cfif arguments.event.isArgDefined("numToReturn")>
			<cfset numToReturn = arguments.event.getArg("numToReturn") />
		</cfif>
		
		<cfif arguments.event.isArgDefined("activeOnly")>
			<cfset activeOnly = arguments.event.getArg("activeOnly") />
		</cfif>
		
		<cfreturn variables.entryService.getEntriesAsQuery(arguments.numToReturn, arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getEntriesForHomePage" returntype="array" access="public" output="false" 
			hint="Gets the entries for the home page using the numEntriesOnHomePage property in mach-ii.xml">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var entries = 0 />
		
		<cfif arguments.event.isArgDefined("categoryID")>
			<cfset entries = variables.entryService.getEntriesByCategoryID(arguments.event.getArg("categoryID"), 
																			getProperty("numEntriesOnHomePage"), true) />
		<cfelse>
			<cfset entries = variables.entryService.getEntries(getProperty("numEntriesOnHomePage"), true) />
		</cfif>
		
		<cfreturn entries />
	</cffunction>
	
	<cffunction name="getEntriesByCategoryID" returntype="array" access="public" output="false" 
			hint="Gets the entries for a particular category">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var numToReturn = -1 />
		<cfset var activeOnly = true />
		
		<cfif arguments.event.isArgDefined("numToReturn")>
			<cfset numToReturn = arguments.event.getArg("numToReturn") />
		</cfif>
		
		<cfif arguments.event.isArgDefined("activeOnly")>
			<cfset activeOnly = arguments.event.getArg("activeOnly") />
		</cfif>
		
		<cfreturn variables.entryService.getEntriesByCategoryID(arguments.event.getArg("categoryID"), 
																numToReturn, activeOnly) />
	</cffunction>
	
	<cffunction name="processEntryForm" returntype="void" access="public" output="false" 
			hint="Processes the entry form and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = "The entry was saved." />
		
		<!--- if there's an exitEvent included in the event object, use it --->
		<cfif arguments.event.isArgDefined("exitEvent")>
			<cfset exitEvent = arguments.event.getArg("exitEvent") />
		</cfif>
		
		<!--- save the data --->
		<cftry>
			<cfset variables.entryService.saveEntry(arguments.event.getArg("entry")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = "An error occured: #cfcatch.detail#" />
			</cfcatch>
		</cftry>
		
		<!--- announce the next event --->
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteEntry" returntype="void" access="public" output="false" 
			hint="Deletes an entry and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent="success" />
		<cfset var message = "The entry was deleted." />

		<!--- if there's an exitEvent included in the event object, use it --->
		<cfif arguments.event.isArgDefined("exitEvent")>
			<cfset exitEvent = arguments.event.getArg("exitEvent") />
		</cfif>
		
		<!--- delete the entry --->
		<cftry>
			<cfset variables.entryService.removeEntry(arguments.event.getArg("entryID")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = "An error occurred: #cfcatch.detail#" />
			</cfcatch>
		</cftry>
		
		<!--- announce the next event --->
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>
