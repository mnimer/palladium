<!---

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

Author: Kurt Wiersma (kurt@mach-ii.com)
$Id: AbstractCacheStrategy.cfc 1892 2009-11-05 05:01:27Z peterfarrell $

Created version: 1.6.0
Updated version: 1.8.0

Notes:
Caching strategies:

* Are not Mach-II framework aware and do not have any access to the 
Mach-II AppManager or other Mach-II Managers. All configuration data 
should be passed into the strategy via the parameters.
* Are not required to implement all the public methods, however you
need to override the abstract methods if you do not want to have
errors thrown.
* Must make use the the CacheStats if you want caching stats available
in the Mach-II dashboard.

--->
<cfcomponent
 	displayname="AbstractCacheStrategy"
	output="false"
	hint="A caching strategy. This is abstract and must be extended by a concrete strategy implementation.">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />
	<cfset variables.instance.strategyTypeName = "undefined" />
	<cfset variables.parameters = StructNew() />
	<cfset variables.parameters.cachingEnabled = true />
	<cfset variables.cacheStats = CreateObject("component", "MachII.caching.CacheStats").init() />
	<cfset variables.log = 0 />
	<cfset variables.assert = "" />
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="AbstractCacheStrategy" output="false"
		hint="Initializes the caching strategy. Do not override.">
		<cfargument name="parameters" type="struct" required="false" default="#StructNew()#"
			hint="A struct of configure time parameters." />
		
		<cfset setParameters(arguments.parameters) />
		<cfset setAssert(CreateObject("component", "MachII.util.Assert").init()) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the strategy. Override to provide custom functionality.">
		<!--- Does nothing. Override to provide custom functionality. --->
	</cffunction>

	<cffunction name="deconfigure" access="public" returntype="void" output="false"
		hint="Deconfigures the strategy. Override to provide custom functionality.">
		<!--- Does nothing. Override to provide custom functionality. --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="put" access="public" returntype="void" output="false" 
		hint="Puts an element by key into the cache.">
		<cfargument name="key" type="string" required="true"
			hint="The unique key for the data to put in the cache." />
		<cfargument name="data" type="any" required="true"
			hint="The data to cache." />
		<cfabort showerror="This method is abstract and must be overrided." />
	</cffunction>
	
	<cffunction name="get" access="public" returntype="any" output="false"
		hint="Gets an element by key from the cache.">
		<cfargument name="key" type="string" required="true"
			hint="The unique key for the data to get from the cache." />
		<cfabort showerror="This method is abstract and must be overrided." />
	</cffunction>
	
	<cffunction name="flush" access="public" returntype="void" output="false"
		hint="Flushes all elements from the cache.">
		<cfabort showerror="This method is abstract and must be overrided." />
	</cffunction>
	
	<cffunction name="reap" access="public" returntype="void" output="false"
		hint="Reaps 'expired' cache elements.">
		<cfabort showerror="This method is abstract and must be overrided." />
	</cffunction>
	
	<cffunction name="keyExists" access="public" returntype="boolean" output="false"
		hint="Checks if an element exists by key in the cache.">
		<cfargument name="key" type="string" required="true"
			hint="The unique key for the data to check if it is in the cache." />
		<cfabort showerror="This method is abstract and must be overrided." />
	</cffunction>
	
	<cffunction name="remove" access="public" returntype="void" output="false"
		hint="Removes a cached element by key.">
		<cfargument name="key" type="string" required="true"
			hint="The unique key for the data to remove from the cache." />
		<cfabort showerror="This method is abstract and must be overrided." />
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS - UTILS
	--->
	<cffunction name="getCacheStats" access="public" returntype="MachII.caching.CacheStats" output="false"
		hint="Gets the cache stats for this caching strategy.">
		<cfreturn variables.cacheStats />
	</cffunction>
	
	<cffunction name="getConfigurationData" access="public" returntype="struct" output="false"
		hint="Gets pretty configuration data for this caching strategy. Override to provide nicer looking information for Dashboard integration.">
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="setParameter" access="public" returntype="void" output="false"
		hint="Sets a configuration parameter.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfargument name="value" type="any" required="true"
			hint="The parameter value." />
		<cfset variables.parameters[arguments.name] = arguments.value />
	</cffunction>
	<cffunction name="getParameter" access="public" returntype="any" output="false"
		hint="Gets a configuration parameter value, or a default value if not defined.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfargument name="defaultValue" type="any" required="false" default=""
			hint="The default value to return if the parameter is not defined. Defaults to a blank string." />
		<cfif isParameterDefined(arguments.name)>
			<cfreturn variables.parameters[arguments.name] />
		<cfelse>
			<cfreturn arguments.defaultValue />
		</cfif>
	</cffunction>
	<cffunction name="isParameterDefined" access="public" returntype="boolean" output="false"
		hint="Checks to see whether or not a configuration parameter is defined.">
		<cfargument name="name" type="string" required="true"
			hint="The parameter name." />
		<cfreturn StructKeyExists(variables.parameters, arguments.name) />
	</cffunction>
	<cffunction name="getParameterNames" access="public" returntype="string" output="false"
		hint="Returns a comma delimited list of parameter names.">
		<cfreturn StructKeyList(variables.parameters) />
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="getStrategyTypeName" access="public" returntype="string" output="false"
		hint="Returns the type name of the strategy. Required for Dashboard integration.">
		<cfreturn variables.instance.strategyTypeName />
	</cffunction>
	<cffunction name="getStrategyType" access="public" returntype="string" output="false"
		hint="Returns the dot path type of the strategy. Required for Dashboard integration.">
		<cfreturn GetMetadata(this).name />
	</cffunction>
	
	<cffunction name="setCacheEnabled" access="public" returntype="void" output="false"
		hint="Sets the boolean suggestion that isCacheEnabled() returns.">
		<cfargument name="cachingEnabled" type="boolean" required="true" />
		<cfset variables.parameters.cachingEnabled = arguments.cachingEnabled />
	</cffunction>
	<cffunction name="isCacheEnabled" access="public" returntype="boolean" output="false"
		hint="Provides a boolean suggestion to the *calling code* if caching should be used. This does not explicitly turn caching on/off.">
		<cfreturn variables.parameters.cachingEnabled />
	</cffunction>
	
	<cffunction name="setAssert" access="private" returntype="void" output="false"
		hint="Sets the assert utility.">
		<cfargument name="assert" type="MachII.util.Assert" required="true" />
		<cfset variables.assert = arguments.assert />
	</cffunction>
	<cffunction name="getAssert" access="public" returntype="MachII.util.Assert" output="false"
		hint="Gets the assert utility.">
		<cfreturn variables.assert />
	</cffunction>

	<cffunction name="setParameters" access="public" returntype="void" output="false"
		hint="Sets the full set of configuration parameters for the component.">
		<cfargument name="parameters" type="struct" required="true" />
		
		<cfset var key = "" />
		
		<cfloop collection="#arguments.parameters#" item="key">
			<cfset setParameter(key, arguments.parameters[key]) />
		</cfloop>
	</cffunction>
	<cffunction name="getParameters" access="public" returntype="struct" output="false"
		hint="Gets the full set of configuration parameters for the component.">
		<cfreturn variables.parameters />
	</cffunction>
	
	<cffunction name="setLog" access="public" returntype="void" output="false"
		hint="Uses the log factory to create a log.">
		<cfargument name="logFactory" type="MachII.logging.LogFactory" required="true" />
		<cfset variables.log = arguments.logFactory.getLog(getMetadata(this).name) />
	</cffunction>
	<cffunction name="getLog" access="public" returntype="MachII.logging.Log" output="false"
		hint="Gets the log.">
		<cfreturn variables.log />
	</cffunction>
	
</cfcomponent>