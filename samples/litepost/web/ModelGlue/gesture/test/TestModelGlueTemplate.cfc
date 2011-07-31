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

<cfcomponent extends="mxunit.framework.TestCase" hint="Tests the various ModelGlue.cfm templates.">

<cffunction name="testGestureModelGlueTemplate" returntype="void" access="public">
	<cfset var expectedMgXmlPath = "/ModelGlue/gesture/test/ModelGlue.xml" />
	<cfset var expectedCsXmlPath = "/ModelGlue/gesture/test/ColdSpring.xml" />
	<cfset var ModelGlue_CORE_COLDSPRING_PATH = "/ModelGlue/gesture/test/ColdSpring.xml" />
	<cfset var ModelGlue_LOCAL_COLDSPRING_PATH = "/ModelGlue/gesture/test/ColdSpring.xml" />
	<cfset var ModelGlue_CONFIG_PATH = "/ModelGlue/gesture/test/ModelGlue.xml" />
	<cfset structDelete(application, "_modelglue") />
	
 	<cftry>
		<cfinclude template="/ModelGlue/gesture/ModelGlue.cfm" />
		<cfcatch>
			<!--- 
				It's going to try to run a request and load files it can't find.  We just
				care that paths are set up correctly...
			--->
		</cfcatch>
	</cftry>
 	<cfset assertTrue(structKeyExists(request, "_modelglue"), "_modelglue not in request") />
	<cfset assertTrue(structKeyExists(request._modelglue, "bootstrap"), "bootstrap not created") />
	<cfset assertTrue(structKeyExists(request._modelGlue.bootstrap, "framework"), "framework not created") />
	<cfset assertTrue(structKeyExists(request._modelglue.bootstrap, "bootstrapper"), "bootstrapper not created") />
	<cfset assertTrue(structKeyExists(request._modelglue.bootstrap.bootstrapper, "primaryModulePath"), "primaryModulePath not set") />
	<cfset assertTrue(request._modelglue.bootstrap.bootstrapper.coldspringPath eq expectedCsXmlPath, "coldspringPath not as expected (expected '#expectedCsXmlPath#', was '#request._modelglue.bootstrap.bootstrapper.coldspringPath#')") />
	<cfset assertTrue(request._modelglue.bootstrap.bootstrapper.primaryModulePath eq expectedMgXmlPath, "primaryModulePath not as expected (expected '#expectedMgXmlPath#', was '#request._modelglue.bootstrap.bootstrapper.primaryModulePath#')") />
	
</cffunction>

<cffunction name="stub_listenerFunction1">
</cffunction>

</cfcomponent>
