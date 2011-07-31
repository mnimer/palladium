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

<cfcomponent displayname="EntryDAO" output="false">
	
	<cfset variables.dsn = "" />
	
	<cffunction name="init" access="public" returntype="net.litepost.component.entry.EntryDAO" output="false">
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
	<cffunction name="fetch" returntype="net.litepost.component.entry.Entry" access="public" output="false">
		<cfargument name="entryID" type="numeric" required="true" />
		<cfset var entry = 0 />
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" maxrows="1" datasource="#variables.dsn#">
		SELECT e.entryID, e.title, e.body, TIMESTAMP(e.dateCreated) AS entryDate, 
			e.dateCreated, e.dateLastUpdated, e.categoryID, ct.category, COUNT(c.commentID) AS numComments, 
			u.userID, u.fname, u.lname 
        FROM entries e 
		LEFT OUTER JOIN categories ct ON e.categoryID = ct.categoryID 
		LEFT OUTER JOIN comments c ON e.entryID = c.entryID 
		INNER JOIN users u ON e.userID = u.userID 
        WHERE e.entryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entryID#" />
		GROUP BY e.entryID, e.title, e.body, e.dateCreated, e.dateLastUpdated 
		</cfquery>
		
		<cfif qrySelect.RecordCount LT 1>
			<!--- return an uninitialized entry --->
			<cfreturn CreateObject('component','net.litepost.component.entry.Entry') />
		</cfif>
		
		<cfset entry = CreateObject('component','net.litepost.component.entry.Entry').init() />
		<cfset entry.setEntryID(qrySelect.entryID) />
		<cfset entry.setCategoryID(qrySelect.categoryID) />
		<cfset entry.setCategory(qrySelect.category) />
		<cfset entry.setUserID(qrySelect.userID) />
		<cfset entry.setUserFirstName(qrySelect.fname) />
		<cfset entry.setUserLastName(qrySelect.lname) />
		<cfset entry.setTitle(qrySelect.title) />
		<cfset entry.setBody(qrySelect.body) />
		<cfset entry.setNumComments(qrySelect.numComments) />
		<cfset entry.setEntryDate(qrySelect.entryDate) />
		<cfset entry.setDateCreated(qrySelect.dateCreated) />
		<cfset entry.setDateLastUpdated(qrySelect.dateLastUpdated) />
		
		<cfreturn entry />
		
	</cffunction>
	
	<cffunction name="save" returntype="numeric" access="public" output="false">
		<cfargument name="entry" type="net.litepost.component.entry.Entry" required="true" />
		
		<cfif arguments.entry.getEntryID() GT 0>
			<cfset update(arguments.entry)/>
			<cfreturn arguments.entry.getEntryID()/>
		<cfelse>
			<cfreturn create(arguments.entry)/>
		</cfif>		

	</cffunction>
	
	<cffunction name="remove" returntype="void" access="public" output="false">
		<cfargument name="entryID" type="numeric" required="true" />

		<cfset var qryDelete = 0 />
		
		<!--- delete the record --->
		<cfquery name="qryDelete" datasource="#variables.dsn#">
		DELETE FROM entries 
		WHERE entryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entryID#" />
		</cfquery>
		
	</cffunction>
	
	<cffunction name="create" returntype="numeric" access="private" output="false">
		<cfargument name="entry" type="net.litepost.component.entry.Entry" required="true" />

		<cfset var qryInsert = 0 />
		<cfset var qrySelect = 0 />
		
		<!--- insert the record --->
		<cftransaction>
			<cfquery name="qryInsert" datasource="#variables.dsn#">
			INSERT INTO entries (
				userID, categoryID, title, body, dateCreated, dateLastUpdated
				)
			VALUES (
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entry.getUserID()#" />, 
				<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entry.getCategoryID()#" />, 
				<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.entry.getTitle()#" />,
				<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.entry.getBody()#" />,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#" />,
				<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#" />
				)
			</cfquery>
			<cfquery name="qrySelect" datasource="#variables.dsn#">
				SELECT LAST_INSERT_ID() AS NewID
			</cfquery>
		</cftransaction>
		
		<cfreturn qrySelect.NewID />
		
	</cffunction>
	
	<cffunction name="update" returntype="void" access="private" output="false">
		<cfargument name="entry" type="net.litepost.component.entry.Entry" required="true" />

		<cfset var qryUpdate = 0 />
		
		<!--- update the record --->
		<cfquery name="qryUpdate" datasource="#variables.dsn#">
		UPDATE entries 
			SET categoryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entry.getCategoryID()#" />, 
				title = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.entry.getTitle()#" />, 
				body = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.entry.getBody()#" />,
				dateLastUpdated = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#" />
		WHERE entryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.entry.getEntryID()#" />
		</cfquery>
		
	</cffunction>
	
</cfcomponent>