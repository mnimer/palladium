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

  $Id: SecurityListener.cfc 50 2006-10-18 20:29:46Z mpwoodward $

--->

<cfcomponent 
	displayname="SecurityListener" 
	output="false" 
	extends="MachII.framework.Listener" 
	hint="Security Listener for Litepost">
	
	<cffunction name="configure" returntype="void" access="public" output="false" hint="Configures this listener; called automatically by Mach-II">
		<!--- don't need to do anything here --->
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setSecurityService" returntype="void" access="public" output="false" hint="Dependency: SecurityService">
		<cfargument name="securityService" type="net.litepost.component.security.SecurityService" required="true" />
		<cfset variables.securityService = arguments.securityService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="checkAuthentication" access="public" returntype="boolean" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.securityService.isAuthenticated() />
	</cffunction>
	
	<cffunction name="logoutUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset variables.securityService.removeUserSession() />
	</cffunction>

</cfcomponent>