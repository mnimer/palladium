<!---
LICENSE INFORMATION:

Copyright 2010, Joe Rinehart, Dan Wilson

Licensed under the Apache License, Version 2.0 (the "License"); you may not 
use this file except in compliance with the License. 

You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 
	
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.

VERSION INFORMATION:

This file is part of Model-Glue 'Gesture' 3.1 Maintenance Release Candidate (3.1.299).

The version number in parentheses is in the format versionNumber.subversion.revisionNumber.
--->

<cfcomponent extends="mxunit.framework.TestCase">

	<cfset this.coldspringPath = "/ModelGlue/gesture/test/ColdSpring.xml" />
	<cfset variables.mg = "">

	<cffunction name="setUp" returntype="void" access="public" hint="put things here that you want to run before each test">
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public" hint="put things here that you want to run after each test">	
	</cffunction>
	
	<cffunction name="createBootstrapper" access="private">
		<cfargument name="coldspringPath" default="#this.coldspringPath#">
		<cfset var bootstrapper = createObject("component", "ModelGlue.gesture.loading.ColdSpringBootstrapper")>
		<cfset bootstrapper.coldspringPath = arguments.coldspringPath>
		<cfset bootstrapper.coreColdspringPath = arguments.coldspringPath>
		
		<cfset request._modelglue.bootstrap.bootstrapper = bootstrapper />
		<cfset request._modelglue.bootstrap.initializationRequest = true />
		<cfset request._modelglue.bootstrap.initializationLockPrefix = expandPath(".") & "/.modelglue" />
		<cfset request._modelglue.bootstrap.initializationLockTimeout = 60 />
		
		<cfreturn bootstrapper>
	</cffunction>
	
	<cffunction name="createModelGlueIfNotDefined" access="private">
		<cfargument name="coldspringPath" default="#this.coldspringPath#">
		<cfif isSimpleValue(mg)>
			<cfset createModelGlue(coldspringPath)>
		</cfif>
		<cfreturn mg>
	</cffunction>
	
	<cffunction name="createModelGlue" access="private">
		<cfargument name="coldspringPath" default="#this.coldspringPath#">
		<cfset variables.mg = createBootstrapper(coldspringPath).
					createModelGlue()>
					
		<!--- load "test" application event definitions --->
		<cfset mg.getInternalBean("modelglue.ModuleLoaderFactory").create("XML").load( mg, expandPath("/ModelGlue/gesture/test/primaryModule.xml") ) />

		<cfset request._modelglue.bootstrap.framework = mg />
		
		<cfreturn  mg>	
	</cffunction>

</cfcomponent>
