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

  $Id: SecurityService.cfc 41 2006-10-18 02:35:08Z Chris.Scott.One $

--->

<cfcomponent displayname="SecurityService"
			extends="net.litepost.service.SecurityService" hint="Service for Security">

	<cffunction name="init" returntype="net.litepost.component.security.SecurityService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="setSessionService" access="public" returntype="void" output="false" hint="DEPENDENCY: SessionService">
		<cfargument name="sessionService" type="net.litepost.service.SessionService" required="true" />
		<cfset variables.sessionService = arguments.sessionService />
	</cffunction>
	
	<cffunction name="isAuthenticated" access="public" returntype="boolean" output="false">
		<cfset var user = variables.sessionService.getUser() />
		<cfreturn user.isAuthenticated() /> 
	</cffunction>
	
	<cffunction name="isRole" access="public" returntype="boolean" output="false">
		<cfargument name="validRoles" type="string" required="true" />
		
		<cfset var userRole = '' />
		<cfset var permission = 0 />
		<cfset var user = 0 />
		
		<cfif isAuthenticated()>
			<cfset user = variables.sessionService.getUser() />
			<cfset userRole = user.getRole() />
			<cfloop list="#arguments.validRoles#" delimiters="," index="permission">
				<cfif userRole EQ permission>
					<cfreturn true>>
				</cfif>
			</cfloop>
		</cfif>
		
		<cfreturn false />
		
	</cffunction>
	
	<cffunction name="removeUserSession" access="public" returntype="void" output="false">
		<cfset variables.sessionService.resetSession() />
	</cffunction>
	
</cfcomponent>