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

<cfcomponent displayname="AllTests" output="false">

<cffunction name="suite" returntype="org.cfcunit.framework.Test" access="public" output="false">
	<cfset var suite = CreateObject("component", "org.cfcunit.framework.TestSuite").init("Test Suite")>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.test.TestModelGlue"))>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.module.test.TestXMLModuleLoader"))>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.loading.test.TestRequestScopeBootstrapper"))>
	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.loading.test.TestColdSpringBootstrapper"))>
	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.loading.test.TestXMLColdSpringBootstrapper"))>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.eventrequest.population.test.TestPopulator"))>
	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.eventrequest.url.test.TestUrlManager"))>
	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.eventrequest.test.TestEventContext"))>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.eventhandler.test.TestEventHandler"))>


	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.factory.test.TestTypeDefaultMapBasedFactory"))>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.collections.test.TestViewCollection"))>
	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.collections.test.TestMapCollectionImplementation"))>

	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.externaladapters.beaninjection.test.TestColdSpringBeanInjector")) />	
	<cfset suite.addTestSuite(CreateObject("component", "ModelGlue.gesture.externaladapters.beanpopulation.test.TestCollectionBeanPopulator")) />	

	<cfreturn suite/>
</cffunction>

</cfcomponent>
