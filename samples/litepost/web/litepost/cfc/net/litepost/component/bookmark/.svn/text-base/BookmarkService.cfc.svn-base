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
 
<cfcomponent displayname="BookmarkService" 
			extends="net.litepost.service.BookmarkService" 
			hint="Service for Bookmarks">

	<cffunction name="init" returntype="net.litepost.component.bookmark.BookmarkService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setBookmarkDAO" returntype="void" access="public" output="false" hint="Dependency: BookmarkDAO">
		<cfargument name="bookmarkDAO" type="net.litepost.component.bookmark.BookmarkDAO" required="true"/>
		<cfset variables.bookmarkDAO  = arguments.bookmarkDAO />
	</cffunction>
	
	<cffunction name="setBookmarkGateway" returntype="void" access="public" output="false" hint="Dependency: BookmarkGateway">
		<cfargument name="bookmarkGateway" type="net.litepost.component.bookmark.BookmarkGateway" required="true"/>
		<cfset variables.bookmarkGateway  = arguments.bookmarkGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getBookmarks" returntype="array" access="public" output="false">
		<cfreturn variables.bookmarkGateway.getBookmarks() />
	</cffunction>
	
	<cffunction name="getBookmarksAsQuery" returntype="query" access="public" output="false">
		<cfreturn variables.bookmarkGateway.getBookmarksAsQuery() />
	</cffunction>
	
	<cffunction name="getBookmarkById" returntype="net.litepost.component.bookmark.Bookmark" access="public" output="false">
		<cfargument name="bookmarkID" type="numeric" required="true" />
		<cfreturn variables.bookmarkDAO.fetch(arguments.bookmarkID) />
	</cffunction>
	
	<cffunction name="getNewBookmark" returntype="net.litepost.component.bookmark.Bookmark" access="public" output="false" hint="Returns and empty bookmark">
		<cfset var bookmark = createObject('component', 'net.litepost.component.bookmark.Bookmark').init() />
		<cfreturn bookmark />
	</cffunction>
	
	<cffunction name="saveBookmark" returntype="numeric" access="public" output="false">
		<cfargument name="bookmark" type="net.litepost.component.bookmark.Bookmark" required="true" />
		<cfreturn variables.bookmarkDAO.save(arguments.bookmark) />
	</cffunction>
	
	<cffunction name="removeBookmark" returntype="void" access="public" output="false">
		<cfargument name="bookmarkID" type="numeric" required="true" />
		<cfset variables.bookmarkDAO.remove(arguments.bookmarkID) />
	</cffunction>
</cfcomponent>