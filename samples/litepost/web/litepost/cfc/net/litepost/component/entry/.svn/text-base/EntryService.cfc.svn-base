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

  $Id$

--->
 
<cfcomponent displayname="EntryService" 
			extends="net.litepost.service.EntryService" 
			hint="Service for Comments">

	<cffunction name="init" returntype="net.litepost.component.entry.EntryService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setEntryDAO" returntype="void" access="public" output="false" hint="Dependency: EntryDAO">
		<cfargument name="entryDAO" type="net.litepost.component.entry.EntryDAO" required="true"/>
		<cfset variables.entryDAO  = arguments.entryDAO />
	</cffunction>
	
	<cffunction name="setEntryGateway" returntype="void" access="public" output="false" hint="Dependency: EntryGateway">
		<cfargument name="entryGateway" type="net.litepost.component.entry.EntryGateway" required="true"/>
		<cfset variables.entryGateway  = arguments.entryGateway />
	</cffunction>
	
	<cffunction name="setCommentService" returntype="void" access="public" output="false" hint="Dependency: CommentService">
		<cfargument name="commentService" type="net.litepost.service.CommentService" required="true"/>
		<cfset variables.commentService  = arguments.commentService />
	</cffunction>
	
	<cffunction name="setSessionService" returntype="void" access="public" output="false" hint="Dependency: SessionService">
		<cfargument name="sessionService" type="net.litepost.service.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getEntries" returntype="array" access="public" output="false" hint="Gets entries and comments as objects">
		<cfargument name="numToReturn" type="numeric" required="false" default="-1" />
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn variables.entryGateway.getEntries(arguments.numToReturn, arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getEntriesAsQuery" returntype="query" access="public" output="false" hint="Gets a query object of entries">
		<cfargument name="numToReturn" type="numeric" required="false" default="-1" />
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn variables.entryGateway.getEntriesAsQuery(arguments.numToReturn, arguments.activeOnly) />
	</cffunction>
	
	<cffunction name="getEntriesByCategoryID" returntype="array" access="public" output="false" hint="Gets entries by a category ID as objects">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfargument name="numToReturn" type="numeric" required="false" default="-1" />
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		
		<cfreturn variables.entryGateway.getEntries(arguments.numToReturn, arguments.activeOnly, arguments.categoryID) />
	</cffunction>
	
	<cffunction name="getEntryByID" returntype="net.litepost.component.entry.Entry" access="public" output="false" hint="Gets an entries by a entry ID, and all it's comments">
		<cfargument name="entryID" type="numeric" required="true" />
		<cfargument name="includeComments" type="boolean" required="false" default="true" />
		
		<cfset var entry =  variables.entryDAO.fetch(arguments.entryID) />
		
		<cfif not entry.isNull() and arguments.includeComments>
			<cfset entry.setComments(variables.commentService.getCommentsByEntryID(entry.getEntryID())) />
		</cfif>
		
		<cfreturn entry />
	</cffunction>
	
	<cffunction name="getNewEntry" returntype="net.litepost.component.entry.Entry" access="public" output="false" hint="Returns an empty entry.">
		<cfset var entry = createObject('component', 'net.litepost.component.entry.Entry').init() />
		<cfreturn entry />
	</cffunction>
	
	<cffunction name="saveEntry" returntype="numeric" access="public" output="false" hint="Saves an entry">
		<cfargument name="entry" type="net.litepost.component.entry.Entry" required="true" />
		<!--- set the user id in the entry object --->
		<cfset arguments.entry.setUserID(variables.sessionService.getUser().getUserID()) />		
		<cfreturn variables.entryDAO.save(arguments.entry) />
	</cffunction>
	
	<cffunction name="removeEntry" returntype="void" access="public" output="false" hint="Saves an entry">
		<cfargument name="entryID" type="numeric" required="true" />
		<cfset variables.entryDAO.remove(arguments.entryID) />
	</cffunction>
	
	<cffunction name="resetEntryCategories" returntype="void" access="public" output="false" 
			hint="Resets entry category ids for a particular category id to 0">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfset variables.entryGateway.resetEntryCategories(arguments.categoryID) />
	</cffunction>
</cfcomponent>