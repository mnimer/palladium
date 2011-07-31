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

<cffunction name="createPopulator" output="false" access="public">
	<cfreturn createObject("component", "ModelGlue.gesture.externaladapters.beanpopulation.CollectionBeanPopulator").init() />
</cffunction>

<cffunction name="createCollection" output="false" access="public">
	<cfreturn createObject("component", "ModelGlue.gesture.collections.MapCollection") />
</cffunction>

<cffunction name="testCreateAndPopulate" returntype="void" access="public">
	<cfset var pop = createPopulator() />
	<cfset var bean = "" />
	<cfset var values = structNew() />
	<cfset var collection = createCollection() />
	<cfset collection.setValue( "implicitProp", "implicitPropValue") />
	<cfset collection.setValue( "explicitProp", "explicitPropValue") />
	
	<cfset bean = pop.populate("ModelGlue.gesture.externaladapters.beanpopulation.test.Bean", collection) />
	
	<cfset assertTrue(bean.initRan, "Init() did not get invoked.") />
	<cfset assertTrue(bean.explicitProp eq "explicitPropValue", "explicit prop not set") />
	<cfset assertTrue(bean.getImplicitProp() eq "implicitPropValue", "implicit prop not set") />
</cffunction>

<cffunction name="testPopulateExisting" returntype="void" access="public">
	<cfset var pop = createPopulator() />
	<cfset var bean = createObject("component", "ModelGlue.gesture.externaladapters.beanpopulation.test.Bean") />
	<cfset var values = structNew() />
	<cfset var collection = createCollection() />
	
	<cfset values.implicitProp = "implicitPropValue" />
	<cfset values.explicitProp = "explicitPropValue" />
	<cfset collection.init( values ) />
	
	<cfset pop.populate(bean, collection) />
	
	<cfset assertTrue(bean.explicitProp eq "explicitPropValue", "explicit prop not set") />
	<cfset assertTrue(bean.getImplicitProp() eq "implicitPropValue", "implicit prop not set") />
</cffunction>

</cfcomponent>
