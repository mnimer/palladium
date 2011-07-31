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

<cfcomponent extends="ModelGlue.gesture.modules.scaffold.beans.AbstractScaffold" output="false" hint="I am used whever type=""delete"" is used in a scaffold tag.">

<cffunction name="makeModelGlueXMLFragment" output="false" access="public" returntype="string" hint="I make an instance of a modelglue xml fragment for this event">
	<cfargument name="advice" type="struct" required="true"/>
	<cfargument name="alias" type="string" required="true"/>
	<cfargument name="class" type="string" required="true"/>
	<cfargument name="eventtype" type="string" required="true"/>
	<cfargument name="orderedpropertylist" type="string" required="true"/>
	<cfargument name="prefix" type="string" required="true"/>
	<cfargument name="primarykeylist" type="string" required="true"/>
	<cfargument name="properties" type="struct" required="true"/>
	<cfargument name="propertylist" type="string" required="true"/>
	<cfargument name="suffix" type="string" required="true"/>
	
	<cfset var xml = '
		<event-handler name="#arguments.alias#.Delete" access="public"' />
	
	<cfif len(arguments.eventtype)>
		<cfset xml = xml & ' type="#arguments.eventtype#"' />
	</cfif>
	
	<cfset xml = xml & '>
			<broadcasts>
				<message name="ModelGlue.genericDelete">
					<argument name="criteria" value="#arguments.primaryKeyList#" />
					<argument name="object" value="#arguments.alias#" />
				</message>
			</broadcasts>
			<views>
			</views>
			<results>
				<result do="#arguments.alias#.List" redirect="true" preserveState="false" />
			</results>
		</event-handler>
'>
	
	<cfreturn xml />
</cffunction>


<cffunction name="loadMetadata" output="false" access="public" returntype="struct" hint="I load the metadata for this scaffold">
	<cfreturn variables._metadata />	
</cffunction>	

<cffunction name="loadViewTemplate" output="false" access="public" returntype="string" hint="I load the CFtemplate formatted representation for this view">
	<cfreturn this />
</cffunction>
</cfcomponent>

