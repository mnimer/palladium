<!--- 
	  
  Copyright (c) 2006, Chris Scott, Matt Woodward, Adam Wayne Lehman, Dave Ross
  All rights reserved.
	
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
       http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

	$Id: $
--->

<cfprocessingdirective pageencoding="utf-8" />
<cfset setEncoding("form", "utf-8") />
<cfset setEncoding("url", "utf-8") />

<!--- Set the path to the application's mach-ii.xml file. --->
<cfset MACHII_CONFIG_PATH = ExpandPath("./config/mach-ii.xml") />

<!--- Check if reloadApp via url --->
<cfif StructKeyExists(URL, "init")>
	<cfset MACHII_CONFIG_MODE = 1 />
	<cfsetting requesttimeout="120" />
	<cfobjectcache action="CLEAR" />
<cfelse>
	<!--- Set the configuration mode (when to reload): -1=never, 0=dynamic, 1=always --->
	<cfset MACHII_CONFIG_MODE = 0 />
</cfif>
<!--- Set the app key for sub-applications within a single cf-application. --->
<cfset MACHII_APP_KEY = GetFileFromPath(ExpandPath(".")) />
<!---
Whether or not to validate the XML configuration file before parsing.
Only works on CFMX7. Default to false.
--->
<cfset MACHII_VALIDATE_XML = false />
<!--- Set the path to the Mach-II's DTD file.  Default to ./config/mach-ii_1_1.dtd. --->
<cfset MACHII_DTD_PATH = ExpandPath('./config/mach-ii_1_1.dtd') />
<!--- Include the mach-ii.cfm file included with the core code. --->
<cfinclude template="/MachII/mach-ii.cfm" />