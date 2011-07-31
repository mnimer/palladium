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
	
	$Id: UserListener.cfc 50 2006-10-18 20:29:46Z mpwoodward $
--->

<cfcomponent 
	displayname="UserListener" 
	output="false" 
	extends="MachII.framework.Listener" 
	hint="User Listener for Litepost">
	
	
	<cffunction name="configure" returntype="void" access="public" output="false" hint="Configures this listener; called automatically by Mach-II">
		<!--- don't need to do anything here --->
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setUserService" returntype="void" access="public" output="false" hint="Dependency: UserService">
		<cfargument name="userService" type="net.litepost.component.user.UserService" required="true" />
		<cfset variables.userService = arguments.userService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getUser" returntype="net.litepost.component.user.User" access="public" output="false" 
			hint="Returns a user bean based on the userID in the event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfreturn variables.userService.getUserByID(arguments.event.getArg("userID")) />
	</cffunction>
	
	<cffunction name="processUserForm" returntype="void" access="public" output="false" 
			hint="Processes the user form and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "showUserForm" />
		
		<cfif arguments.event.isArgDefined("exitEvent")>
			<cfset exitEvent = arguments.event.getArg("exitEvent") />
		</cfif>
		
		<cfset variables.userService.saveUser(arguments.event.getArg("user")) />
		
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="authenticate" returntype="void" access="public" output="false" 
			hint="Checks the login attempt and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var user = createObject("component", "net.litepost.component.user.User").init() />
		<cfset var message = "You were successfully logged in." />
		<cfset var exitEvent = "success" />
		
		<cftry>
			<cfset user = variables.userService.authenticate(arguments.event.getArg("userName"), 
																	arguments.event.getArg("password")) />
			
			<cfif user.isNull()>
				<cfset message = "Your login failed. Please try again." />
				<cfset exitEvent = "failure" />
			</cfif>
			
			<cfcatch type="any">
				<cfset message = "An error occurred: #cfcatch.detail#" />
				<cfset exitEvent = "failure" />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>