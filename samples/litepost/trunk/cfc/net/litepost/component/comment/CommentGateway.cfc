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

  $Id: CommentGateway.cfc 33 2006-10-18 01:42:37Z Chris.Scott.One $

--->

<cfcomponent displayname="CommentGateway" output="false">
	
	<cfset variables.dsn = "" />
	<cfset variables.cacheTimeLong = CreateTimeSpan(0, 0, 30, 0)>
	<cfset variables.cacheTimeShort = CreateTimeSpan(0, 0, 20, 0)>
	
	<cffunction name="init" access="public" returntype="net.litepost.component.comment.CommentGateway" output="false">
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setDsn" returntype="void" access="public" output="false" hint="Dependency: datasource name">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	
	<!--- gateway methods --->
	<cffunction name="getCommentsByEntryID" returntype="array" access="public" output="false" hint="Retrieves comments for a particular entry">
		<cfargument name="entryID" type="numeric" required="true" />
		
		<cfset var qrySelect = 0 />
		<cfset var comments = arrayNew(1) />
		<cfset var comment = 0 />
		
		<cfquery name="qrySelect" datasource="#variables.dsn#">
			SELECT commentID, entryID, comment, name, email, url, dateCreated 
			FROM comments 
			WHERE entryID = <cfqueryparam value="#arguments.entryID#" cfsqltype="cf_sql_integer" /> 
			ORDER BY dateCreated ASC
		</cfquery>
		
		<cfloop query="qrySelect">
			<cfset comment = createObject("component", "net.litepost.component.comment.Comment").init(qrySelect.commentID, 
																								  qrySelect.entryID, 
																								  qrySelect.comment, 
																								  qrySelect.name, 
																								  qrySelect.email, 
																								  qrySelect.url, 
																								  qrySelect.dateCreated) />
			
			<cfset arrayAppend(comments, comment) />
		</cfloop>
		
		<cfreturn comments />
	</cffunction>
</cfcomponent>