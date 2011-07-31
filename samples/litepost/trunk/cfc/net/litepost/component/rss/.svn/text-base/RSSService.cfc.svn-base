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

  $Id:  $

Notes:
The vast majority of the RSS functionality is borrowed liberally from Ray Camdent's BlogCFC (http://www.blogcfc.com).
THANKS RAY!!!!
--->

<cfcomponent displayname="RssService" output="false" hint="RssService for MachBlog">
	<cffunction name="init" access="public" output="false" returntype="RSSService">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="setEntryService" access="public" output="false" returntype="void">
		<cfargument name="entryService" type="net.litepost.component.entry.EntryService" required="true" />
		<cfset variables.entryService = arguments.entryService />
	</cffunction>
	<cffunction name="getEntryService" access="public" output="false" returntype="net.litepost.component.entry.EntryService">
		<cfreturn variables.entryService />
	</cffunction>
	
	<cffunction name="getBlogRSS" access="public" output="false" returntype="string" 
			hint="Returns the RSS feed for the entire blog. By default returns the same entries as displayed on the home page.">
		<cfargument name="numEntries" type="numeric" required="true" />
		<cfargument name="blogName" type="string" required="true" />
		<cfargument name="blogURL" type="string" required="true" />
		<cfargument name="blogDescription" type="string" required="true" />
		<cfargument name="blogLanguage" type="string" required="true" />
		<cfargument name="generator" type="string" required="true" />
		<cfargument name="authorEmail" type="string" required="true" />
		<cfargument name="webmasterEmail" type="string" required="true" />
		<cfargument name="eventParameter" type="string" required="true" />
		<cfargument name="eventLocation" type="string" required="false" default="showEntry" />
		
		<cfset var entries = getEntryService().getEntries(arguments.numEntries, true) />
		<cfset var publishDate = DateFormat(Now(), "ddd, dd mmm yyyy") & " " & TimeFormat(Now(), "HH:mm:ss") & " -" 
									& NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
		<cfset var lastBuildDate = "" />
		<cfset var entryDate = "" />
		<cfset var rss = "" />
		<cfset var i = 0 />
		
		<cfif arrayLen(entries)>
			<cfset lastBuildDate = DateFormat(entries[1].getDateCreated(), "ddd, dd mmm yyyy") & " " 
									& TimeFormat(entries[1].getDateCreated(), "HH:mm:ss") 
									& " -" & NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
		</cfif>
		
		<cfsavecontent variable="rss">
		<cfoutput>
			<rss version="2.0">
			<channel>
			<title>#xmlFormat(arguments.blogName)#</title>
			<link>#xmlFormat(arguments.blogURL)#</link>
			<description>#xmlFormat(arguments.blogDescription)#</description>
			<language>#arguments.blogLanguage#</language>
			<pubDate>#publishDate#</pubDate>
			<lastBuildDate>#lastBuildDate#</lastBuildDate>
			<generator>#arguments.generator#</generator>
			<docs>http://blogs.law.harvard.edu/tech/rss</docs>
			<managingEditor>#xmlFormat(arguments.authorEmail)#</managingEditor>
			<webMaster>#xmlFormat(arguments.webmasterEmail)#</webMaster>
			<cfloop index="i" from="1" to="#arrayLen(entries)#">
				<cfset entryDate = DateFormat(entries[i].getDateCreated(), "ddd, dd mmm yyyy") & " " 
									& TimeFormat(entries[i].getDateCreated(), "HH:mm:ss") 
									& " -" & NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
				<item>
					<title>#xmlFormat(entries[i].getTitle())#</title>
					<link>#xmlFormat(arguments.blogUrl & "/index.cfm?" & arguments.eventParameter & "=" & arguments.eventLocation & "&entryId=" & entries[i].getEntryID())#</link>
					<description>
					<!--- Regex operation removes HTML code from blog body output --->
					<cfif Len(REReplaceNoCase(entries[i].getBody(), "<[^>]*>", "", "ALL")) GTE 250>
					#xmlFormat(Left(REReplace(entries[i].getBody(), "<[^>]*>", "", "ALL"), 250))#...
					<cfelse>#xmlFormat(REReplace(entries[i].getBody(), "<[^>]*>", "", "ALL"))#</cfif>
					</description>
					<category>#xmlFormat(entries[i].getCategory())#</category>
					<pubDate>#entryDate#</pubDate>
					<guid>#xmlFormat(arguments.blogUrl & "/index.cfm?" & arguments.eventParameter & "=" & arguments.eventLocation & "&entryId=" & entries[i].getEntryID())#</guid>
				</item>
			</cfloop>
			</channel>
			</rss>
		</cfoutput>
		</cfsavecontent>
		
		<cfreturn rss />
	</cffunction>
	
	<cffunction name="getCategoryRss" access="public" output="false" returntype="string" 
			hint="Returns the RSS feed for a particular category.  By default returns the most recent 20 entries.">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfargument name="categoryName" type="string" required="true" />
		<cfargument name="blogName" type="string" required="true" />
		<cfargument name="blogURL" type="string" required="true" />
		<cfargument name="blogDescription" type="string" required="true" />
		<cfargument name="blogLanguage" type="string" required="true" />
		<cfargument name="generator" type="string" required="true" />
		<cfargument name="authorEmail" type="string" required="true" />
		<cfargument name="webmasterEmail" type="string" required="true" />
		<cfargument name="eventParameter" type="string" required="true" />
		
		<cfset var entries = getEntryService().getEntriesByCategoryID(arguments.categoryID, 20, true) />
		<cfset var publishDate = DateFormat(Now(), "ddd, dd mmm yyyy") & " " & TimeFormat(Now(), "HH:mm:ss") & " -" 
									& NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
		<cfset var lastBuildDate = "" />
		<cfset var entryDate = "" />
		<cfset var category = "" />
		<cfset var rss = "" />
		<cfset var i = 0 />
		
		<cfif arrayLen(entries)>
			<cfset lastBuildDate = DateFormat(entries[1].getDateCreated(), "ddd, dd mmm yyyy") & " " 
									& TimeFormat(entries[1].getDateCreated(), "HH:mm:ss") 
									& " -" & NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
		</cfif>
		
		<cfsavecontent variable="rss">
		<cfoutput>
			<rss version="2.0">
			<channel>
			<title>#xmlFormat(arguments.blogName)# - #xmlFormat(arguments.categoryName)#</title>
			<link>#xmlFormat(arguments.blogURL)#</link>
			<description>#xmlFormat(arguments.blogDescription)#</description>
			<language>#arguments.blogLanguage#</language>
			<pubDate>#publishDate#</pubDate>
			<lastBuildDate>#lastBuildDate#</lastBuildDate>
			<generator>#arguments.generator#</generator>
			<docs>http://blogs.law.harvard.edu/tech/rss</docs>
			<managingEditor>#xmlFormat(arguments.authorEmail)#</managingEditor>
			<webMaster>#xmlFormat(arguments.webmasterEmail)#</webMaster>
			<cfloop index="i" from="1" to="#arrayLen(entries)#">
				<cfset entryDate = DateFormat(entries[i].getDateCreated(), "ddd, dd mmm yyyy") & " " 
									& TimeFormat(entries[i].getDateCreated(), "HH:mm:ss") 
									& " -" & NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
				<item>
					<title>#xmlFormat(entries[i].getTitle())#</title>
					<link>#xmlFormat(arguments.blogUrl & "/index.cfm?" & arguments.eventParameter & "=" & arguments.eventLocation & "&entryId=" & entries[i].getEntryID())#</link>
					<description>
					<!--- Regex operation removes HTML code from blog body output --->
					<cfif Len(REReplaceNoCase(entries[i].getBody(), "<[^>]*>", "", "ALL")) GTE 250>
					#xmlFormat(Left(REReplace(entries[i].getBody(), "<[^>]*>", "", "ALL"), 250))#...
					<cfelse>#xmlFormat(REReplace(entries[i].getBody(), "<[^>]*>", "", "ALL"))#</cfif>
					</description>
					<category>#xmlFormat(entries[i].getCategory())#</category>
					<pubDate>#entryDate#</pubDate>
					<guid>#xmlFormat(arguments.blogUrl & "/index.cfm?" & arguments.eventParameter & "=" & arguments.eventLocation & "&entryId=" & entries[i].getEntryID())#</guid>
				</item>
			</cfloop>
			</channel>
			</rss>
		</cfoutput>
		</cfsavecontent>
		
		<cfreturn rss />
	</cffunction>
</cfcomponent>