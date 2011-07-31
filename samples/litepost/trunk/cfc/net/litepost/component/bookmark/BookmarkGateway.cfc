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

  $Id: BookmarkGateway.cfc 22 2006-10-17 20:55:11Z mpwoodward $

--->

<cfcomponent displayname="BookmarkGateway" output="false">
	
	<cfset variables.dsn = "" />
	<cfset variables.cacheTimeLong = CreateTimeSpan(0, 0, 30, 0)>
	<cfset variables.cacheTimeShort = CreateTimeSpan(0, 0, 20, 0)>
	
	<cffunction name="init" access="public" returntype="net.litepost.component.bookmark.BookmarkGateway" output="false">
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setDsn" returntype="void" access="public" output="false" hint="Dependency: datasource name">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	
	<cffunction name="getBookmarks" returntype="array" access="public" output="false" 
			hint="Returns an array of bookmark objects">
		<cfset var qrySelect = 0 />
		<cfset var bookmarks = arrayNew(1) />
		<cfset var bookmark = 0 />
		
		<cfset qrySelect = getBookmarksAsQuery() />
		
		<cfloop query="qrySelect">
			<cfset bookmark = createObject("component", "net.litepost.component.bookmark.Bookmark").init(qrySelect.bookmarkID, 
																									 qrySelect.name, 
																									 qrySelect.url) />
			<cfset arrayAppend(bookmarks, bookmark) />
		</cfloop>
		
		<cfreturn bookmarks />
	</cffunction>
	
	<cffunction name="getBookmarksAsQuery" returntype="query" access="public" output="false">
		<cfset var qrySelect = 0 />

		<cfquery name="qrySelect" datasource="#variables.dsn#">
			SELECT bookmarkID, name, url 
			FROM bookmarks
		</cfquery>
		
		<cfreturn qrySelect />
	</cffunction>
</cfcomponent>