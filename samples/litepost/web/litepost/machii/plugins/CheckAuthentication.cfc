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
	
	$Id: CheckAuthentication.cfc 91 2006-10-20 20:25:33Z mpwoodward $
--->

<cfcomponent
	displayname="CheckForUser"
	extends="MachII.framework.Plugin"
	output="false"
	hint="Plugin to check for a valid user in LitePost">

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the plugin.">
		<!--- Does nothing --->
	</cffunction>

	<cffunction name="setSecurityService" access="public" output="false" returntype="void"
			hint="Dependency: injected">
		<cfargument name="securityService" type="net.litepost.component.security.SecurityService" required="true" />
		<cfset variables.securityService = arguments.securityService />
	</cffunction>	

	<!---
	PUBLIC FUNCTIONS - PLUGIN POINTS
	--->
	<!---
	<cffunction name="preProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	--->
	
	<cffunction name="preEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfif variables.securityService.isAuthenticated()>
			<cfset arguments.eventContext.getCurrentEvent().setArg("isAdmin", true) />
		<cfelse>
			<cfset arguments.eventContext.getCurrentEvent().setArg("isAdmin", false) />
		</cfif>
	</cffunction>
	
	<!---
	<cffunction name="postEvent" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
	</cffunction>
	--->
	
	<cffunction name="handleException" access="public" returntype="void" output="false">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
	</cffunction>
</cfcomponent>