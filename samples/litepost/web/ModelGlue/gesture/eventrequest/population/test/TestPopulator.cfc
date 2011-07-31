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

<cfcomponent extends="modelglue.gesture.test.ModelGlueAbstractTestCase" output="false">

	<cfset this.coldspringPath = "/ModelGlue/gesture/eventrequest/url/test/ColdSpring.xml">

	<cffunction name="setUp" output="false" access="public" returntype="any" hint="">
		<cfset createModelGlueIfNotDefined(this.coldspringPath) />
	</cffunction>


<cffunction name="testStructBasedPopulator" output="false" returntype="void" access="public">
	<cfset var ctx = mg.getEventContextFactory().new() />
	<cfset var pop = createObject("component", "ModelGlue.gesture.eventrequest.population.StructBasedPopulator").init() />
	<cfset var source = {} />
	
	<cfset source.someKey = "someValue" />
	
	<cfset pop.populate(ctx, source) />
	
	<cfset assertTrue(ctx.getValue("someKey") eq "someValue", "value not in context") />
</cffunction>

<cffunction name="testUrlBasedPopulator" output="false" returntype="void" access="public">
	<cfset var urlManager = "" />
	<cfset var ctx = mg.getEventContextFactory().new() /> />
	<cfset var pop = mg.getInternalBean("modelGlue.urlPopulator")/>
	

	<cfset url.someKey = "someUrlValue" />
	
	<cfset pop.populate(ctx) />
	
	<cfset assertTrue(ctx.getValue("someKey") eq "someUrlValue", "value not in context") />
</cffunction>

<cffunction name="testFormBasedPopulator" output="false" returntype="void" access="public">
	<cfset var ctx = mg.getEventContextFactory().new() /> />
	<cfset var pop = mg.getInternalBean("modelGlue.formPopulator") />
	
	<cfset form.someKey = "someFormValue" />
	
	<cfset pop.populate(ctx) />
	
	<cfset assertTrue(ctx.getValue("someKey") eq "someFormValue", "value not in context") />
</cffunction>

</cfcomponent>
