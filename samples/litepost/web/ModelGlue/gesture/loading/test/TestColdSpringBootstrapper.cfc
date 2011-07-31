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

<cfcomponent extends="modelglue.gesture.test.ModelGlueAbstractTestCase">
		
	<cfset this.coldspringPath = "/ModelGlue/gesture/loading/test/ColdSpring.xml">

	<cffunction name="setUp">
		<cfset createModelGlueIfNotDefined() />	
	</cffunction>

	<cffunction name="testCreateBeanFactory" returntype="void" access="public">
		<cfset assertEquals("ModelGlue.gesture.ModelGlue", getMetadata(mg).name, "ModelGlue instance not created from bean factory.") />
	</cffunction>
	
	<cffunction name="testCreateBeanFactory_WithParent" returntype="void" access="public">
		<cfset var boot = createBootstrapper(this.coldspringPath) />
		<cfset var parentBeanFactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init() />
		<cfset var bf = "" />
		<cfset var bean = "" />
		
		<cfset parentBeanFactory.loadBeans(expandPath("/ModelGlue/gesture/loading/test/ParentBeans.xml")) />
		<cfset boot.parentBeanFactory = parentBeanFactory />
		
		<cfset bf = boot.createBeanFactory() />
		<cfset bean = bf.getBean("beanFromParentFactory") />
		
		<cfset assertEquals("ModelGlue.gesture.collections.MapCollection", getMetadata(bean).name, "MapCollection instance not created from bean factory.") />
	</cffunction>
	
	<cffunction name="testInternalBeanFactory" returntype="void" access="public">
		<cfset var cfg = mg.getInternalBean("modelglue.ModelGlueConfiguration") />
		<cfset assertEquals("ModelGlue.gesture.configuration.ModelGlueConfiguration",getMetadata(cfg).name, "Configuration instance not created from bean factory.") />
	</cffunction>
		
	<cffunction name="testDefaultDynamicProperties" returntype="void" access="public">
		<cfset var boot = createBootstrapper(this.coldspringPath) />
		<cfset var bf = "" />
		<cfset var bean = "" />
		<cfset var dynProps = structNew() >
		<cfset dynProps.AValueOriginatingOutside = "Dynamic">
		<cfset boot.defaultColdSpringProperties = dynProps />
		<cfset bf = boot.createBeanFactory() />
		<cfset bean = bf.getBean("DynamicPropertyContainer") />
		
		<cfset assertEquals(bean.MyValueWillBeDynamic, "Dynamic", "Dynamic Property not set in bean") />
	</cffunction>

</cfcomponent>
