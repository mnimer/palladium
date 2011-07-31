<!--
	  
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
-->

<cfcomponent displayname="BlogController" 
			 hint="Main controller for all blog related things" 
			 extends="ModelGlue.Core.Controller" 
			 output="false">
			 
	<cffunction name="Init" access="Public" returnType="litepost.mg.controller.RssController" output="false" 
				hint="I build a new BlogController">
		<cfargument name="ModelGlue" required="true" type="ModelGlue.ModelGlue" />
		<cfargument name="InstanceName" required="true" type="string" />
		<cfset super.Init(arguments.ModelGlue) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setRSSService" access="public" output="false" returntype="void" hint="dependency: injected">
		<cfargument name="rssService" type="net.litepost.component.rss.RSSService" required="true" />
		<cfset variables.rssService = arguments.rssService />
	</cffunction>
	
	<cffunction name="getRSS" access="public" output="false" returntype="string" 
			hint="Returns the RSS for the entire blog. By default returns the same entries displayed on the home page. For a categoryu returns the most recent 20.">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var numEntriesOnHomePage = getModelGlue().getConfigSetting("numEntriesOnHomePage")/>
		<cfset var blogName = getModelGlue().getConfigSetting("blogName")/>
		<cfset var blogURL = getModelGlue().getConfigSetting("blogURL")/>
		<cfset var blogDescription = getModelGlue().getConfigSetting("blogDescription")/>
		<cfset var blogLanguage = getModelGlue().getConfigSetting("blogLanguage")/>
		<cfset var authorEmail = getModelGlue().getConfigSetting("authorEmail")/>
		<cfset var webmasterEmail = getModelGlue().getConfigSetting("webmasterEmail")/>
		<cfset var eventValue = getModelGlue().getConfigSetting("eventValue")/>
		
		<cfset var categoryID = event.getValue("categoryID",0)/>
		<cfset var categoryName = event.getValue("categoryName","")/>
		
		<cfset var rss = ""/>
		
		<cfif arguments.event.argumentExists("category")>
			<cfset rss = variables.rssService.getCategoryRSS(categoryID, 
													"Category: " & categoryID,  
													blogName, 
													blogURL, 
													blogDescription, 
													replace(lcase(blogLanguage), "_", "-", "one"), 
													"LitePost", 
													authorEmail, 
													webmasterEmail, 
													eventValue) />
		<cfelse>
			<cfset rss = variables.rssService.getBlogRSS(numEntriesOnHomePage, 
													blogName, 
													blogURL, 
													blogDescription, 
													replace(lcase(blogLanguage), "_", "-", "one"), 
													"LitePost", 
													authorEmail, 
													webmasterEmail, 
													eventValue) />
		</cfif>
												
		<cfset arguments.event.setValue("rss", rss) />
	</cffunction>
	
</cfcomponent>