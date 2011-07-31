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

	$Id: BookmarkListener.cfc 122 2006-10-24 06:01:56Z mpwoodward $
--->

<cfcomponent 
	displayname="BookmarkListener" 
	output="false" 
	extends="MachII.framework.Listener" 
	hint="The Bookmark listener for Litepost">

	<cffunction name="configure" returntype="void" access="public" output="false" hint="Configures this listener; called automatically by Mach-II">
		<!--- don't need to do anything here --->
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setBookmarkService" returntype="void" access="public" output="false" hint="Dependency: BookmarkService">
		<cfargument name="bookmarkService" type="net.litepost.component.bookmark.BookmarkService" required="true" />
		<cfset variables.bookmarkService = arguments.bookmarkService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getBookmark" returntype="net.litepost.component.bookmark.Bookmark" access="public" output="false" 
			hint="Returns a bookmark">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn variables.bookmarkService.getBookmarkByID(arguments.event.getArg("bookmarkID", 0)) />
	</cffunction>
	
	<cffunction name="getBookmarks" returntype="array" access="public" output="false" 
			hint="Returns an array of Bookmark">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.bookmarkService.getBookmarks() />
	</cffunction>
	
	<cffunction name="getBookmarksAsQuery" returntype="query" access="public" output="false" 
			hint="Returns a query object containing bookmarks">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.bookmarkService.getBookmarksAsQuery() />
	</cffunction>
	
	<cffunction name="processBookmarkForm" returntype="void" access="public" output="false" 
			hint="Processes the bookmark form and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = "The link was saved." />
		
		<cftry>
			<cfset variables.bookmarkService.saveBookmark(arguments.event.getArg("bookmark")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = "An error occurred: #cfcatch.detail#" />
			</cfcatch>
		</cftry>
		
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteBookmark" returntype="void" access="public" output="false" 
			hint="Deletes a bookmark and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = "The link was deleted." />
		
		<cftry>
			<cfset variables.bookmarkService.removeBookmark(arguments.event.getArg("bookmarkID")) />
			<cfcatch type="any">
				<cfset message = "An error occurred: #cfcatch.detail#" />
			</cfcatch>
		</cftry>
	</cffunction>
</cfcomponent>