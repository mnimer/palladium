<!---
License:

    Mach-II - A framework for object oriented MVC web applications in CFML
    Copyright (C) 2003-2009 GreatBizTools, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Author: Ben Edwards (ben@ben-edwards.com)
$Id: EventArgsFilter.cfc 1972 2009-11-21 11:29:49Z peterfarrell $

Created version: 1.0.10
Updated version: 1.1.0

EventArgsFilter
	This event-filter adds args to the current event being handled.
	
Configuration Parameters:
	None.
	
Event-Handler Parameters:
	The name/value of each parameter are the name/value of the args added to the event.
--->
<cfcomponent 
	displayname="EventArgsFilter" 
	extends="MachII.framework.EventFilter"
	output="false"
	hint="An EventFilter for adding args to the current event being handled.">
	
	<!---
	INITALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="This configure method does nothing.">
		<!--- Does nothing --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="filterEvent" access="public" returntype="boolean" output="false"
		hint="Runs the filter event.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="paramArgs" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var paramArgKeys = StructKeyArray(arguments.paramArgs) />
		<cfset var i = 0 />
		<cfset var argName = 0 />

		<cfloop index="i" from="1" to="#ArrayLen(paramArgKeys)#">
			<cfset argName = paramArgKeys[i] />
			<cfset arguments.event.setArg(argName, paramArgs[argName]) />
		</cfloop>
		
		<cfreturn true />
	</cffunction>
	
</cfcomponent>