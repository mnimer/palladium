<cfset publishDate = DateFormat(Now(), "ddd, dd mmm yyyy") & " " & TimeFormat(Now(), "HH:mm:ss") & " -" 
							& NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
							
<cfset lastBuildDate = DateFormat(REQUEST.qryEntry.dateCreated[1], "ddd, dd mmm yyyy") & " " 
							& TimeFormat(REQUEST.qryEntry.dateCreated[1], "HH:mm:ss") 
							& " -" & NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
							
							
<cfoutput>
<rss version="2.0">
	<channel>
	<title>#xmlFormat(APPLICATION.settings.blog.name)#</title>
	<link>#xmlFormat(APPLICATION.settings.blog.url)#</link>
	<description>#xmlFormat(APPLICATION.settings.blog.description)#</description>
	<language>#APPLICATION.settings.blog.language#</language>
	<pubDate>#publishDate#</pubDate>
	<lastBuildDate>#lastBuildDate#</lastBuildDate>
	<generator>#APPLICATION.settings.name#</generator>
	<docs>http://blogs.law.harvard.edu/tech/rss</docs>
	<managingEditor>#xmlFormat(APPLICATION.settings.blog.email.author)#</managingEditor>
	<webMaster>#xmlFormat(APPLICATION.settings.blog.email.webmaster)#</webMaster>
	<cfloop index="i" from="1" to="#REQUEST.qryEntry.recordCount#">
		<cfset entryDate = DateFormat(REQUEST.qryEntry.dateCreated[i], "ddd, dd mmm yyyy") & " " 
							& TimeFormat(REQUEST.qryEntry.dateCreated[i], "HH:mm:ss") 
							& " -" & NumberFormat(getTimeZoneInfo().utcHourOffset, "00") & "00" />
		<item>
			<title>#xmlFormat(REQUEST.qryEntry.title[i])#</title>
			<link>#xmlFormat(APPLICATION.settings.blog.url & REQUEST.myself & 'entry.display&entryID=' & REQUEST.qryEntry.entryID[i])#</link>
			<description>
			<!--- Regex operation removes HTML code from blog body output --->
			<cfif Len(REReplaceNoCase(REQUEST.qryEntry.body[i], "<[^>]*>", "", "ALL")) GTE 250>
			#xmlFormat(Left(REReplace(REQUEST.qryEntry.body[i], "<[^>]*>", "", "ALL"), 250))#...
			<cfelse>#xmlFormat(REReplace(REQUEST.qryEntry.body[i], "<[^>]*>", "", "ALL"))#</cfif>
			</description>
			<category>#xmlFormat(REQUEST.qryEntry.category[i])#</category>
			<pubDate>#REQUEST.qryEntry.entryDate[i]#</pubDate>
			<guid>#xmlFormat(APPLICATION.settings.blog.url & REQUEST.myself & 'entry.display&entryID=' & REQUEST.qryEntry.entryID[i])#</guid>
		</item>
	</cfloop>
	</channel>
</rss>
</cfoutput>
