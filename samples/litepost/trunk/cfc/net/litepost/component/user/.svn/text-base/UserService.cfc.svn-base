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
 
<cfcomponent displayname="UserService" 
			extends="net.litepost.service.UserService" 
			hint="Service for Users">

	<cffunction name="init" returntype="net.litepost.component.user.UserService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setUserDAO" returntype="void" access="public" output="false" hint="Dependency: UserDAO">
		<cfargument name="userDAO" type="net.litepost.component.user.UserDAO" required="true"/>
		<cfset variables.userDAO  = arguments.userDAO />
	</cffunction>
	
	<cffunction name="setUserGateway" returntype="void" access="public" output="false" hint="Dependency: UserGateway">
		<cfargument name="userGateway" type="net.litepost.component.user.UserGateway" required="true"/>
		<cfset variables.userGateway  = arguments.userGateway />
	</cffunction>
	
	<cffunction name="setSessionService" returntype="void" access="public" output="false" hint="Dependency: SessionService">
		<cfargument name="sessionService" type="net.litepost.service.SessionService" required="true"/>
		<cfset variables.sessionService  = arguments.sessionService />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="authenticate" access="public" returntype="net.litepost.component.user.User" output="false">
		<cfargument name="userName" type="string" required="true"/>
		<cfargument name="password" type="string" required="true"/>		
		<cfset var user = 0 />
		<cfset var userId = variables.userDAO.findUserByCredentials(arguments.userName, arguments.password) />
		
		<cfif userId LT 1>
			<cfset variables.sessionService.resetSession() />
			<cfreturn CreateObject('component','net.litepost.component.user.User') />
		</cfif>
		
		<!--- fetch the full user --->
		<cfset user = getUserByID(userId)/>
		<cfset user.setAuthenticated(true)/>
		
		<!--- store validated user in session --->
		<cfset variables.sessionService.setUser(user) />
		
		<cfreturn user/>
	</cffunction>
	
	<cffunction name="getUserByID" returntype="net.litepost.component.user.User" access="public" output="false">
		<cfargument name="userID" type="numeric" required="true" />
		<cfreturn variables.userDAO.fetch(arguments.userID) />
	</cffunction>
	
	<cffunction name="saveUser" returntype="void" access="public" output="false">
		<cfargument name="user" type="net.litepost.component.user.User" required="true" />
		<cfset variables.userDAO.save(arguments.user) />
	</cffunction>
	
</cfcomponent>