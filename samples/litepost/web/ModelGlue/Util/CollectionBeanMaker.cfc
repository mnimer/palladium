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

<cfcomponent displayname="CollectionBeanMaker" output="false" hint="I make beans out of a GenericCollection.">

<cffunction name="init" output="false" hint="Constructor.">
	<cfreturn this />
</cffunction>

<cffunction name="MakeBean" output="false" returntype="any" hint="I return a bean CFC populated from the collection.">
	<cfargument name="collection" type="any" hint="Some form of ModelGlue MapCollection API." />
	<cfargument name="type" hint="I am either the CFC type to create or an instance of a CFC to populate." />
	<cfargument name="fields" hint="I am the [optional] list of fields to populate." />
	
	<cfset var instance = arguments.type  />
	<cfset var i = "" />
	
	<cfif isSimpleValue(arguments.type)>
		<cfset instance = createObject("component", arguments.type) />
		<cfif structKeyExists(instance, "init")>
			<cfset instance.init() />
		</cfif>
	</cfif>
	
	
	<cfif not structKeyExists(arguments, "fields")>
		<cfset arguments.fields = structKeyList(arguments.collection.getAll()) />
	</cfif>

	<cfloop list="#arguments.fields#" index="i">
		<cfif structKeyExists(instance, "Set#i#") and arguments.collection.Exists(i)>
			<cfinvoke component="#instance#" method="Set#i#">
				<cfinvokeargument name="#i#" value="#arguments.collection.getValue(i)#" />
			</cfinvoke>
		<cfelseif structKeyExists( instance, i)>
			<cfset instance[i] = arguments.collection.getValue(i) />
		</cfif>
	</cfloop>

	<cfreturn instance />
</cffunction>	

</cfcomponent>
