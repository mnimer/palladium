<cfoutput>

<!---- display entries ---->
<cfif arrayLen(REQUEST.entries)>
	<cfloop from="1" to="#arrayLen(REQUEST.entries)#" index="r">
		<cfset entry = REQUEST.entries[r] />
		<h1>#entry.getTitle()#</h1>
		<p class="author">Posted #dateFormat(entry.getEntryDate())# by #entry.getUserFirstName()#</p>
		<p>#paragraphFormat(entry.getBody())#</p>
		<a href="#REQUEST.myself##XFA.view#&entryID=#entry.getEntryID()#">More</a>
		<!-- footer at the bottom of every post-->
		<div class="postfooter">
			<span>
				<a href="#REQUEST.myself##XFA.view#&entryID=#entry.getEntryID()#"><img src="/assets/images/comment_icon.gif" alt="Comment" border="0" /></a>
				<a href="#REQUEST.myself##XFA.view#&entryID=#entry.getEntryID()#">Comments (#entry.getNumComments()#)</a>
			</span>
			<span class="right">
				<cfif NOT isEmpty(entry.getCategory())>
					Filed under <a href="#REQUEST.myself##XFA.category#&categoryID=#entry.getCategoryID()#">#entry.getCategory()#</a>
				</cfif>
			</span>
		</div>
	</cfloop>
<cfelse>
	<div>There are currently no entries to display</div>
</cfif>

</cfoutput>