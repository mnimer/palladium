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

  $Id: EntryGateway.cfc 105 2006-10-21 04:31:15Z mpwoodward $

--->

<cfcomponent displayname="EntryGateway" output="false">
	
	<cfset variables.dsn = "" />
	<cfset variables.cacheTimeLong = CreateTimeSpan(0, 0, 30, 0)>
	<cfset variables.cacheTimeShort = CreateTimeSpan(0, 0, 20, 0)>
	
	<cffunction name="init" access="public" returntype="net.litepost.component.entry.EntryGateway" output="false">
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setDsn" returntype="void" access="public" output="false" hint="Dependency: datasource name">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getEntriesAsQuery" returntype="query" access="public" output="false" hint="Returns entries as a query">
		<cfargument name="numToReturn" type="numeric" required="false" default="-1" />
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryID" type="numeric" required="false" default="0" />
		
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" datasource="#variables.dsn#">
			SELECT e.entryID, e.title, e.body, TIMESTAMP(e.dateCreated) AS entryDate, 
				e.dateCreated, e.dateLastUpdated, e.categoryID, ct.category, COUNT(c.commentID) AS numComments, 
				u.userID, u.fname, u.lname 
			FROM entries e 
			LEFT OUTER JOIN categories ct ON e.categoryID = ct.categoryID 
			LEFT OUTER JOIN comments c ON e.entryID = c.entryID 
			INNER JOIN users u ON e.userID = u.userID 
             WHERE 1=1 
				<cfif arguments.activeOnly>
				AND 	e.dateCreated <= <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" /> 
				</cfif>
				<cfif arguments.categoryID neq 0>
				AND 	e.categoryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryID#" /> 
				</cfif>
				GROUP BY e.entryID, e.title, e.body, e.dateCreated, e.dateLastUpdated 
				ORDER BY dateCreated DESC 
				<cfif arguments.numToReturn GT 0>
				LIMIT <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.numToReturn#" /> 
				</cfif>
		</cfquery>
		
		<cfreturn qrySelect />
	</cffunction>
	
	<cffunction name="getEntries" returntype="array" access="public" output="false" hint="Gets entries and (optionally) comments as objects">
		<cfargument name="numToReturn" type="numeric" required="false" default="-1" />
		<cfargument name="activeOnly" type="boolean" required="false" default="true" />
		<cfargument name="categoryID" type="numeric" required="false" default="0" />
		
		<cfset var qrySelect = 0 />
		<cfset var entries = arrayNew(1) />
		<cfset var entry = 0 />
		
		<cfset qrySelect = getEntriesAsQuery(arguments.numToReturn, arguments.activeOnly, arguments.categoryID) />
		
		<cfloop query="qrySelect">
			<cfset entry = createObject("component", "net.litepost.component.entry.Entry").init() />
			<cfset entry.setEntryID(qrySelect.entryID) />
			<cfset entry.setCategoryID(qrySelect.categoryID) />
			<cfset entry.setUserID(qrySelect.userID) />
			<cfset entry.setUserFirstName(qrySelect.fname) />
			<cfset entry.setUserLastName(qrySelect.lname) />
			<cfset entry.setCategory(qrySelect.category) />
			<cfset entry.setTitle(qrySelect.title) />
			<cfset entry.setBody(qrySelect.body) />
			<cfset entry.setEntryDate(qrySelect.entryDate) />
			<cfset entry.setDateCreated(qrySelect.dateCreated) />
			<cfset entry.setDateLastUpdated(qrySelect.dateLastUpdated) />
			<cfset entry.setNumComments(qrySelect.numComments) />
			
			<cfset arrayAppend(entries, entry) />
		</cfloop>
		
		<cfreturn entries />
	</cffunction>
	
	<cffunction name="resetEntryCategories" returntype="void" access="public" output="false" 
			hint="Resets category ids in entries for a specific category id to 0">
		<cfargument name="categoryID" type="numeric" required="true" />
		
		<cfset var qryUpdate = 0 />
		
		<cfquery name="qryUpdate" datasource="#variables.dsn#">
			UPDATE entries 
			SET categoryID = 0 
			WHERE categoryID = <cfqueryparam value="#arguments.categoryID#" cfsqltype="cf_sql_integer" />
		</cfquery>
	</cffunction>
</cfcomponent>