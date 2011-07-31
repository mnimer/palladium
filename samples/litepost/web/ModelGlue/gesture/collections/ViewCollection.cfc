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

<cfcomponent displayName="ViewCollection" output="false" hint="I am a collection of rendered views.">

<cffunction name="init" access="public" returnType="any" output="false" hint="I build a new ViewCollection.">
  <cfset variables.viewCollection = structNew() />
  <cfset variables.finalViewKey = "" />
  <cfreturn this />
</cffunction>

<cffunction name="addRenderedView" access="public" returnType="void" output="false" hint="I add a rendered view to the collection.">
  <cfargument name="key" type="string" required="true" hint="I am the name of the view to add.">
  <cfargument name="content" type="string" required="true" hint="I am the HTML of the view.">
  <cfargument name="append" type="boolean" required="false" default="false" hint="Should the HTML be appended on to an existing view of the same name?">
  
  <cfif not append or not structKeyExists(variables.viewCollection, arguments.key)>
    <cfset variables.viewCollection[arguments.key] = arguments.content />
  <cfelse>
    <cfset variables.viewCollection[arguments.key] = variables.viewCollection[arguments.key] & arguments.content />
  </cfif>
  
  <cfset variables.finalViewKey = arguments.key />
</cffunction>

<cffunction name="getView" access="public" output="false" hint="I get a rendered view by name.">
  <cfargument name="name" required="true" hint="I am the name of the view to get.">
<cftry>
   <cfreturn variables.viewCollection[arguments.name] />
   <cfcatch>
   	<cfreturn "" />
   </cfcatch>
 </cftry>
</cffunction>

<cffunction name="exists" access="public" returnType="string" output="false" hint="Does a view with a given name exist in this collection?">
  <cfargument name="name" type="string" required="true" hint="I am the name of the view to check.">
    <cfreturn structKeyExists(variables.viewCollection, arguments.name) />
</cffunction>

<cffunction name="getAll" access="public" returnType="struct" output="false" hint="I get all rendered views (by value).">
	<cfreturn duplicate(variables.viewCollection) />
</cffunction>

<cffunction name="getFinalView" access="public" output="false" hint="I get the last view entered into the view collection.">
  <cfif structKeyExists(viewCollection, variables.finalViewKey)>
    <cfreturn variables.viewCollection[variables.finalViewKey] />
  <cfelse>
    <cfreturn "" />
  </cfif>
</cffunction>

<cffunction name="getFinalViewKey" access="public" output="false" hint="I get the key of last view entered into the view collection.">
	<cfreturn variables.finalViewKey />
</cffunction>

</cfcomponent>
