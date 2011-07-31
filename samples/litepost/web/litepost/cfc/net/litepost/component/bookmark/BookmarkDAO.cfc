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

  $Id: BookmarkDAO.cfc 121 2006-10-24 06:01:28Z mpwoodward $

--->

<cfcomponent displayname="BookmarkDAO" output="false">
	
	<cfset variables.dsn = "" />
	
	<cffunction name="init" access="public" returntype="net.litepost.component.bookmark.BookmarkDAO" output="false">
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setDsn" returntype="void" access="public" output="false" hint="Dependency: datasource name">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDsn" returntype="string" access="public" output="false" hint="Dependency: datasource name">
		<cfreturn variables.dsn />
	</cffunction>
	
	<!--- dao methods --->
	<cffunction name="fetch" returntype="net.litepost.component.bookmark.Bookmark" access="public" output="false">
		<cfargument name="bookmarkID" type="numeric" required="true" />
		<cfset var bookmark = CreateObject('component','net.litepost.component.bookmark.Bookmark').init() />
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" maxrows="1" datasource="#variables.dsn#">
			SELECT bookmarkID, name, url 
			FROM bookmarks 
			WHERE bookmarkID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.bookmarkID#"/>
		</cfquery>
		
		<!--- <cfif qrySelect.RecordCount LT 1>
			<cfthrow message="Record not found for bookmarkID: #arguments.bookmarkID#!">
		</cfif> --->
		
		<cfif qrySelect.recordCount gt 0>
			<cfset bookmark.setBookmarkID(qrySelect.bookmarkID) />
			<cfset bookmark.setName(qrySelect.name) />
			<cfset bookmark.setUrl(qrySelect.url) />
		</cfif>
		
		<cfreturn bookmark />
		
	</cffunction>
	
	<cffunction name="save" returntype="numeric" access="public" output="false">
		<cfargument name="bookmark" type="net.litepost.component.bookmark.Bookmark" required="true" />
		
		<cfif arguments.bookmark.getBookmarkID() GT 0>
			<cfset update(arguments.bookmark)/>
			<cfreturn arguments.bookmark.getBookmarkID() />
		<cfelse>
			<cfreturn create(arguments.bookmark)/>
		</cfif>		

	</cffunction>
	
	<cffunction name="remove" returntype="void" access="public" output="false">
		<cfargument name="bookmarkID" type="numeric" required="true" />
		
		<cfset var qryDelete = 0 />
		
		<!--- delete the record --->
		<cfquery name="qryDelete" datasource="#variables.dsn#">
			DELETE FROM 	bookmarks 
			WHERE bookmarkID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.bookmarkID#" />
		</cfquery>
		
	</cffunction>
	
	<cffunction name="create" returntype="numeric" access="private" output="false">
		<cfargument name="bookmark" type="net.litepost.component.bookmark.Bookmark" required="true" />

		<cfset var qryInsert = 0 />
		<cfset var qrySelect = 0 />
		
		<!--- insert the record --->
		<cftransaction>
			<cfquery name="qryInsert" datasource="#variables.dsn#">
				INSERT INTO bookmarks (
					name, 
					url
				) VALUES (
					<cfqueryparam value="#arguments.bookmark.getName()#" cfsqltype="cf_sql_varchar" />, 
					<cfqueryparam value="#arguments.bookmark.getUrl()#" cfsqltype="cf_sql_varchar" />
				)
			</cfquery>
			<cfquery name="qrySelect" datasource="#variables.dsn#">
				SELECT LAST_INSERT_ID() AS NewID
			</cfquery>
		</cftransaction>
		
		<cfreturn qrySelect.NewID />
		
	</cffunction>
	
	<cffunction name="update" returntype="void" access="private" output="false">
		<cfargument name="bookmark" type="net.litepost.component.bookmark.Bookmark" required="true" />

		<cfset var qryUpdate = 0 />
		
		<!--- update the record --->
		<cfquery name="qryUpdate" datasource="#variables.dsn#">
			UPDATE 	bookmarks 
			SET		name = <cfqueryparam value="#arguments.bookmark.getName()#" cfsqltype="cf_sql_varchar" />, 
					url = <cfqueryparam value="#arguments.bookmark.getUrl()#" cfsqltype="cf_sql_varchar" /> 
			WHERE 	bookmarkID = <cfqueryparam cfsqltype="cf_sql_integer" value="#bookmark.getBookmarkID()#" />
		</cfquery>
		
	</cffunction>
	
</cfcomponent>