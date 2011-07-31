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

  $Id: CommentDAO.cfc 4 2006-10-17 00:46:27Z mpwoodward $

--->

<cfcomponent displayname="CommentDAO" output="false">
	
	<cfset variables.dsn = "" />
	
	<cffunction name="init" access="public" returntype="net.litepost.component.comment.CommentDAO" output="false">
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
	<cffunction name="fetch" returntype="net.litepost.component.comment.Comment" access="public" output="false">
		<cfargument name="commentID" type="numeric" required="true" />
		<cfset var comment = CreateObject('component','net.litepost.component.comment.Comment').init() />
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" maxrows="1" datasource="#variables.dsn#">
			SELECT commentID, entryID, comment, name, email, url, dateCreated 
			FROM comments 
			WHERE commentID = <cfqueryparam value="#arguments.commentID#" />
		</cfquery>
		
		<cfif qrySelect.RecordCount LT 1>
			<cfthrow message="Record not found for recordID: #arguments.recordID#!">
		</cfif>
		
		<cfset comment.setCommentID(qrySelect.commentID) />
		<cfset comment.setEntryID(qrySelect.entryID) />
		<cfset comment.setComment(qrySelect.comment) />
		<cfset comment.setName(qrySelect.name) />
		<cfset comment.setEmail(qrySelect.email) />
		<cfset comment.setUrl(qrySelect.url) />]
		<cfset comment.setDateCreated(qrySelect.dateCreated) />

		<cfreturn comment />
		
	</cffunction>
	
	<cffunction name="save" returntype="numeric" access="public" output="false">
		<cfargument name="comment" type="net.litepost.component.comment.Comment" required="true" />
		
		<cfif arguments.comment.getCommentID() GT 0>
			<cfset update(arguments.comment)/>
			<cfreturn arguments.comment.getCommentID()/>
		<cfelse>
			<cfreturn create(arguments.comment)/>
		</cfif>		

	</cffunction>
	
	<cffunction name="remove" returntype="void" access="public" output="false">
		<cfargument name="commentID" type="numeric" required="true" />
		
		<cfset var qryDelete = 0 />

		<!--- delete the record --->
		<cfquery name="qryDelete" datasource="#variables.dsn#">
		DELETE FROM comments 
		WHERE commentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.commentID#" />
		</cfquery>
	</cffunction>
	
	<cffunction name="create" returntype="numeric" access="private" output="false">
		<cfargument name="comment" type="net.litepost.component.comment.Comment" required="true" />

		<cfset var qryInsert = 0 />
		<cfset var qrySelect = 0 />
		
		<!--- insert the record --->
		<cftransaction>
			<cfquery name="qryInsert" datasource="#variables.dsn#">
				INSERT INTO comments (
					entryID, 
					comment, 
					name, 
					email, 
					url, 
					dateCreated
				) VALUES (
					<cfqueryparam value="#arguments.comment.getEntryID()#" cfsqltype="cf_sql_integer" />, 
					<cfqueryparam value="#arguments.comment.getComment()#" cfsqltype="cf_sql_varchar" />, 
					<cfqueryparam value="#arguments.comment.getName()#" cfsqltype="cf_sql_varchar" />, 
					<cfqueryparam value="#arguments.comment.getEmail()#" cfsqltype="cf_sql_varchar" />, 
					<cfqueryparam value="#arguments.comment.getUrl()#" cfsqltype="cf_sql_varchar" />, 
					<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" />
				)
			</cfquery>
			<cfquery name="qrySelect" datasource="#variables.dsn#">
				SELECT LAST_INSERT_ID() AS NewID
			</cfquery>
		</cftransaction>
		
		<cfreturn qrySelect.NewID />
		
	</cffunction>
	
	<cffunction name="update" returntype="void" access="private" output="false">
		<cfargument name="comment" type="net.litepost.component.comment.Comment" required="true" />

		<cfset var qryUpdate = 0 />
		
		<!--- update the record --->
		<cfquery name="qryUpdate" datasource="#variables.dsn#">
			UPDATE 	comments 
			SET		entryID = <cfqueryparam value="#arguments.comment.getEntryID()#" cfsqltype="cf_sql_integer" />, 
					comment = <cfqueryparam value="#arguments.comment.getComment()#" cfsqltype="cf_sql_varchar" />, 
					name = <cfqueryparam value="#arguments.comment.getName()#" cfsqltype="cf_sql_varchar" />, 
					email = <cfqueryparam value="#arguments.comment.getEmail()#" cfsqltype="cf_sql_varchar" />, 
					url = <cfqueryparam value="#arguments.comment.getUrl()#" cfsqltype="cf_sql_varchar" />
			WHERE commentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#comment.getCommentID()#" />
		</cfquery>
		
	</cffunction>
	
</cfcomponent>