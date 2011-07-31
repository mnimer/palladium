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

  $Id: UserDAO.cfc 36 2006-10-18 01:53:57Z mpwoodward $

--->

<cfcomponent displayname="UserDAO" output="false">
	
	<cfset variables.dsn = "" />
	
	<cffunction name="init" access="public" returntype="net.litepost.component.user.UserDAO" output="false">
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
	<cffunction name="findUserByCredentials" access="public" returntype="numeric" output="false">
		<cfargument name="userName" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />		
		<cfset var userQry = 0 />
		
		<cfquery name="userQry" maxrows="1" datasource="#variables.dsn#">
		SELECT userId
		FROM users
		WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="15" value="#arguments.userName#" />
			AND password = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="15" value="#arguments.password#" />
		</cfquery>
		
		<cfif userQry.RecordCount>
			<cfreturn userQry.userId />
		<cfelse>
			<cfreturn -1 />
		</cfif>
	</cffunction>
	
	<cffunction name="fetch" returntype="net.litepost.component.user.User" access="public" output="false">
		<cfargument name="userID" type="numeric" required="true" />
		<cfset var user = CreateObject('component','net.litepost.component.user.User').init() />
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" maxrows="1" datasource="#variables.dsn#">
			SELECT 	userID, fname, lname, email, username, password, role 
			FROM 	users 
			WHERE 	userID = <cfqueryparam value="#arguments.userID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		
		<cfif qrySelect.RecordCount LT 1>
			<cfthrow message="Record not found for recordID: #arguments.recordID#!">
		</cfif>
		
		<cfset user.setUserID(qrySelect.userID) />
		<cfset user.setFirstName(qrySelect.fname) />
		<cfset user.setLastName(qrySelect.lname) />
		<cfset user.setEmail(qrySelect.email) />
		<cfset user.setUserName(qrySelect.username) />
		<cfset user.setPassword(qrySelect.password) />
		<cfset user.setRole(qrySelect.role) />
		
		<cfreturn user />
		
	</cffunction>
	
	<cffunction name="save" returntype="void" access="public" output="false">
		<cfargument name="user" type="net.litepost.component.user.User" required="true" />
		
		<cfif arguments.user.getUserID() GT 0>
			<cfset update(arguments.user)/>
		<cfelse>
			<cfset create(arguments.user)/>
		</cfif>		

	</cffunction>
	
	<cffunction name="create" returntype="void" access="private" output="false">
		<cfargument name="user" type="net.litepost.component.user.User" required="true" />

		<cfset var qryInsert = 0 />
		
		<!--- insert the record --->
		<cfquery name="qryInsert" datasource="#variables.dsn#">
			INSERT INTO users (
				fname, 
				lname, 
				email, 
				username, 
				password, 
				role
			) VALUES (
				<cfqueryparam value="#arguments.user.getFirstName()#" cfsqltype="cf_sql_varchar" />, 
				<cfqueryparam value="#arguments.user.getLastName()#" cfsqltype="cf_sql_varchar" />, 
				<cfqueryparam value="#arguments.user.getEmail()#" cfsqltype="cf_sql_varchar" />, 
				<cfqueryparam value="#arguments.user.getUserName()#" cfsqltype="cf_sql_varchar" />, 
				<cfqueryparam value="#arguments.user.getPassword()#" cfsqltype="cf_sql_varchar" />, 
				<cfqueryparam value="#arguments.user.getRole()#" cfsqltype="cf_sql_varchar" />
			)
		</cfquery>
		
	</cffunction>
	
	<cffunction name="update" returntype="void" access="private" output="false">
		<cfargument name="user" type="net.litepost.component.user.User" required="true" />

		<cfset var qryUpdate = 0 />
		
		<!--- update the record --->
		<cfquery name="qryUpdate" datasource="#variables.dsn#">
			UPDATE 	users 
			SET 	fname = <cfqueryparam value="#arguments.user.getFirstName()#" cfsqltype="cf_sql_varchar" />, 
					lname = <cfqueryparam value="#arguments.user.getLastName()#" cfsqltype="cf_sql_varchar" />, 
					email = <cfqueryparam value="#arguments.user.getEmail()#" cfsqltype="cf_sql_varchar" />, 
					username = <cfqueryparam value="#arguments.user.getUserName()#" cfsqltype="cf_sql_varchar" />, 
					password = <cfqueryparam value="#arguments.user.getPassword()#" cfsqltype="cf_sql_varchar" />, 
					role = <cfqueryparam value="#arguments.user.getRole()#" cfsqltype="cf_sql_varchar" /> 
			WHERE 	userID = <cfqueryparam cfsqltype="cf_sql_integer" value="#user.getUserID()#" />
		</cfquery>
		
	</cffunction>
	
</cfcomponent>