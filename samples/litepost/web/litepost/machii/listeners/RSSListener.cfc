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

Notes:
This listener is autowired by ColdSpring.
The vast majority of the RSS functionality is borrowed liberally from Ray Camdent's BlogCFC (http://www.blogcfc.com).
THANKS RAY!!!!
--->
<cfcomponent displayname="RSSListener" output="false" extends="MachII.framework.Listener" hint="RSSListener for LitePost">
	<cffunction name="configure" access="public" output="false" returntype="void">
		<!--- don't need anything here for now --->
	</cffunction>
	
	<cffunction name="setRSSService" access="public" output="false" returntype="void" hint="dependency: injected">
		<cfargument name="rssService" type="net.litepost.component.rss.RSSService" required="true" />
		<cfset variables.rssService = arguments.rssService />
	</cffunction>
	<cffunction name="getRSSService" access="public" output="false" returntype="net.litepost.component.rss.RSSService">
		<cfreturn variables.rssService />
	</cffunction>
	
	<cffunction name="getBlogRSS" access="public" output="false" returntype="string" 
			hint="Returns the RSS for the entire blog.  By default returns the same entries displayed on the home page.">
		<cfreturn getRSSService().getBlogRSS(getProperty("numEntriesOnHomePage"), getProperty("blogName"), getProperty("blogURL"), 
												getProperty("blogDescription"), replace(lcase(getProperty("blogLanguage")), "_", "-", "one"), 
												"LitePost", getProperty("authorEmail"), getProperty("webmasterEmail"), 
												getProperty("eventParameter")) />
	</cffunction>
	
	<cffunction name="getCategoryRSS" access="public" output="false" returntype="string" 
			hint="Returns the RSS for a particular category.  By default returns the most recent 20 entries.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn getRSSService().getCategoryRSS(arguments.event.getArg("categoryID"), 
													"Category: " & #arguments.event.getArg("categoryName")#, 
													getProperty("blogName"), getProperty("blogURL"), 
													getProperty("blogDescription"), 
													replace(lcase(getProperty("blogLanguage")), "_", "-", "one"), 
													"LitePost", getProperty("authorEmail"), 
													getProperty("webmasterEmail"), getProperty("eventParameter")) />
	</cffunction>
</cfcomponent>
