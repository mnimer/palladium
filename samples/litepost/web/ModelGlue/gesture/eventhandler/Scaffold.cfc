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

<cfcomponent output="false" hint="I represent a scaffold tag used to indicate generation patterns (CRUD) for a specific ORM object.">

<cfproperty name="object" type="string" hint="The ORM object to use." />
<cfproperty name="type" type="string" hint="List of generation patterns to use." />
<cfproperty name="propertyList" type="string" hint="List of available generation patterns." />
<cfproperty name="defaultTypes" type="string" hint="List of available generation patterns." />
<cfproperty name="childXML" type="array" hint="Array of XML child nodes of scaffold tag." />

<cfset this.object = "" />
<cfset this.type = "" />
<cfset this.propertyList = "" />
<cfset this.defaultTypes="list,view,edit,commit,delete" />
<cfset this.childXML = arrayNew(1) />
</cfcomponent>
