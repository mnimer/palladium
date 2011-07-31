<cfoutput>
<!---- display entries ---->
<cfif REQUEST.qryEntry.recordCount>
	<cfloop from="1" to="#REQUEST.qryEntry.recordCount#" index="r">
		<!-- post -->
		<h1>#REQUEST.qryEntry.title[r]#</h1>
		<p class="author">Posted #dateFormat(REQUEST.qryEntry.entryDate[r])# by #REQUEST.qryEntry.author[r]#</p>
		<p>#paragraphFormat(REQUEST.qryEntry.body[r])#</p>
		<a href="#REQUEST.myself##XFA.view#&entryID=#REQUEST.qryEntry.entryID[r]#">More</a>
		<!-- footer at the bottom of every post-->
		<div class="postfooter">
			<span>
				<a href="#REQUEST.myself##XFA.view#&entryID=#REQUEST.qryEntry.entryID[r]#"><img src="assets/images/comment_icon.gif" alt="Comment" border="0" /></a>
				<a href="#REQUEST.myself##XFA.view#&entryID=#REQUEST.qryEntry.entryID[r]#">Comment (#REQUEST.qryEntry.numComments[r]#)</a>
			</span>
			<span class="right">
				<cfif NOT isEmpty(REQUEST.qryEntry.category[r])>
					Filed under <a href="#REQUEST.myself##XFA.category#&categoryID=#REQUEST.qryEntry.categoryID[r]#">#REQUEST.qryEntry.category[r]#</a>
				</cfif>
			</span>
		</div>
	</cfloop>
<cfelse>
	<div>There are currently no entries to display</div>
</cfif>

</cfoutput>