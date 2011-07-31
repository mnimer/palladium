<!--
	  
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

	$Id: $
-->

<cfcomponent displayname="SecurityController" 
			 hint="Security controller for all user / authentication things" 
			 extends="ModelGlue.Core.Controller" 
			 output="false">
			 
	<cffunction name="Init" access="Public" returnType="litepost.mg.controller.SecurityController" output="false" 
				hint="I build a new SecurityC">
		<cfargument name="ModelGlue" required="true" type="ModelGlue.ModelGlue" />
		<cfargument name="InstanceName" required="true" type="string" />
		<cfset super.Init(arguments.ModelGlue) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setSecurityService" returntype="void" access="public" output="false" hint="Dependency: SecurityService">
		<cfargument name="securityService" type="net.litepost.service.SecurityService" required="true" />
		<cfset variables.securityService = arguments.securityService />
	</cffunction>
	
	<cffunction name="setUserService" returntype="void" access="public" output="false" hint="Dependency: UserService">
		<cfargument name="userService" type="net.litepost.service.UserService" required="true" />
		<cfset variables.userService = arguments.userService />
	</cffunction>
	
	<cffunction name="checkAuthentication" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var isAdmin = variables.securityService.isAuthenticated() />
		<cfset arguments.event.SetValue("isAdmin", isAdmin) />

	</cffunction>
	
	<cffunction name="authenticateUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var username = arguments.event.getValue("username","") />
		<cfset var password = arguments.event.getValue("password","") />
		<cfset var user = variables.userService.authenticate(username, password)>
		
		<cfif user.isNull()>
			<cfset arguments.event.SetValue("message", "User not found!") />
		<cfelse>
			<cfset arguments.event.forward("home") />
		</cfif>

	</cffunction>
	
	
	<cffunction name="logoutUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset variables.securityService.removeUserSession() />
		<cfset arguments.event.forward("home") />
		
	</cffunction>
		
</cfcomponent>