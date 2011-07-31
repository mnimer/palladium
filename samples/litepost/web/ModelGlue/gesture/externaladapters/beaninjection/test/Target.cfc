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

<cfcomponent beans="bean,bean2">

<cfset setVariablesValue("internallySet") />

<cffunction name="setBean">
	<cfargument name="bean" />
	<cfset variables._bean = arguments.bean />
</cffunction>

<cffunction name="setBean2">
	<cfargument name="bean2" />
	<cfset variables._bean2 = arguments.bean2 />
</cffunction>

<cffunction name="setVariablesValue">
	<cfargument name="value" />
	
	<cfset variables._value = arguments.value />
</cffunction>

<cffunction name="getVariablesValue">
	<cfreturn variables._value />
</cffunction>

</cfcomponent>
