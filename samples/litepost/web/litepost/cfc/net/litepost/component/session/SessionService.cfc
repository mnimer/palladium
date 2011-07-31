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

  $Id: SessionService.cfc 4 2006-10-17 00:46:27Z mpwoodward $

--->

<cfcomponent displayname="SessionService" 
			extends="net.litepost.service.SessionService" hint="Service for Session Facade">

	<cffunction name="init" returntype="net.litepost.component.session.SessionService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!---
	SESSION USER MANAGEMENT
	--->
	<cffunction name="getUser" access="public" returntype="net.litepost.component.user.User" output="false">
		<cfreturn getParameter('user') />
	</cffunction>
	
	<cffunction name="setUser" access="public" returntype="void" output="false">
		<cfargument name="user" type="net.litepost.component.user.User" required="true" />
		<cfset setParameter('user', arguments.user) />
	</cffunction>
	
	<cffunction name="getStartTime" access="public" returntype="string" output="false">
		<cfreturn getParameter('startTime') />
	</cffunction>
	
	<cffunction name="isAuthenticated" access="public" returntype="boolean" output="false">
		<cfreturn getParameter('user').isAuthenticated() />
	</cffunction>
	
	<!---
	SESSION DATA MANAGEMENT
	--->
	
	<cffunction name="setParameter" access="public" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" hint="name of variable"/>
		<cfargument name="value" type="any" required="true" hint="value of variable"/>
		
		<cfset validateSession() />
		
		<cflock name="Session.Storage" timeout="5">
			<cfset session.storage[arguments.name] = arguments.value/>
		</cflock>
	</cffunction>
	
	<cffunction name="getParameter" access="public" output="false" returntype="any">
		<cfargument name="name" type="string" required="true" hint="name of variable"/>
		<cfset var value = 0 />
		<cfset var error = false />
		
		<cfset validateSession() />
		
		<cflock name="Session.Storage" timeout="5">
			<cfif StructKeyExists(session.storage,arguments.name)>
				<cfset value = session.storage[arguments.name] />
			<cfelse>
				<cfset error = true />
			</cfif>
		</cflock>
		
		<cfif error>
			<cfthrow message="Session variable: #arguments.name# is not defined"/>
		<cfelse>
			<cfreturn value />
		</cfif>
	</cffunction>

	<cffunction name="parameterExist" access="public" output="false" returntype="boolean">
		<cfargument name="name" type="string" required="true" hint="name of variable"/>
		<cfset var exists = false />
		
		<cfset validateSession() />
		
		<cfif StructKeyExists(session.storage,arguments.name)>
			<cfset exists = true />
		</cfif>
		
		<cfreturn exists />
	</cffunction>		
	
	<cffunction name="removeParameter" access="public" output="false" returntype="void">
		<cfargument name="varName" type="string" required="true" hint="name of variable"/>
		
		<cfset validateSession() />
		
		<cflock name="Session.Storage" timeout="5">
			<cfif StructKeyExists(session.storage,arguments.name)>
				<cfset structDelete(session.storage,arguments.name)/>
			</cfif>
		</cflock>
	</cffunction>
	
	<!--- 
	PRIVATE METHODS FOR SESSION MANAGEMENT
	--->
	
	<cffunction name="initSession" access="private" returntype="void" output="false">
		<cfset var user = CreateObject("component","net.litepost.component.user.User").init() />
		<cflock name="Session.Storage" timeout="5">
			<cfset session.uid = CreateUUID() />
			<cfset session.storage = structnew() />
			<cfset session.storage.user = user />
			<cfset session.storage.startTime = Now() />
		</cflock>
	</cffunction>
	
	<cffunction name="validateSession" access="private" returntype="void" output="false">
		<cfif not StructKeyExists(session, "uid")>
			<cfset initSession() />
		</cfif>
	</cffunction>
	
	<cffunction name="resetSession" access="public" returntype="void" output="false">
		<cfset initSession() />
	</cffunction>
	
</cfcomponent>