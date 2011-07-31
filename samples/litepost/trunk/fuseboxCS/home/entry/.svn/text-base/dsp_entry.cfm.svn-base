<cfoutput>

<!---- display entry ---->
<!-- post -->
<h1>#REQUEST.entry.getTitle()#</h1>
<p class="author">Posted #dateFormat(REQUEST.entry.getEntryDate())#
<p>#paragraphFormat(REQUEST.entry.getBody())#</p>


<!-- footer at the bottom of every post-->
<div class="postfooter">
	<span>
		<cfif REQUEST.security.isRole('admin')>
			<a href="#REQUEST.myself##XFA.edit#&entryID=#REQUEST.entry.getEntryID()#"><img src="/assets/images/edit_icon.gif" border="0" /></a>
			<a href="#REQUEST.myself##XFA.remove#&entryID=#REQUEST.entry.getEntryID()#"><img src="/assets/images/delete_icon.gif" border="0" /></a>
		</cfif>
	</span>
	<span class="right">
		<cfif NOT isEmpty(REQUEST.entry.getCategory())>
			Filed under <a href="#REQUEST.myself##XFA.category#&categoryID=#REQUEST.entry.getCategoryID()#">#REQUEST.entry.getCategory()#</a>
		</cfif>
	</span>
</div>

<!-- comments -->
<a name="comments"></a>
<h2>Comments</h2>
<cfset REQUEST.comments = REQUEST.entry.getComments() />
<cfloop from="1" to="#arrayLen(REQUEST.comments)#" index="c">
	<cfset comment = REQUEST.comments[c] />
	<div class="comment">
		<p><strong><a href="#comment.getUrl()#" target="_blank">#comment.getName()#</a></strong> - <em>#dateFormat(comment.getDateCreated())#</em></p>
		<p>#paragraphFormat(comment.getComment())#</p>
	</div>
	<p>
		<a href="##content"><img src="/assets/images/top_icon.gif" alt="top" /></a>
		<a href="##content">top</a>
		<cfif REQUEST.security.isRole('admin')>
			<a href="#REQUEST.myself##XFA.removeComment#&commentID=#comment.getCommentID()#"><img src="/assets/images/delete_icon.gif" /></a>
		</cfif>
	</p>
</cfloop>

<!-- comment form -->
<h2>Add A Comment </h2>
<form id="comment" name="comment" method="post" action="#REQUEST.myself##XFA.submit#">
	<label>Your Name<input type="text" name="name" /></label>
	<label>Email (not shared with anyone)<input type="text" name="email" /></label>
	<label>URL (linked in your post)<input type="text" name="url" /></label>
	<label>Comment<textarea name="comment" class="comment"></textarea></label>
	<button name="submit">Submit</button>
	<input type="hidden" name="entryID" value="#REQUEST.entry.getEntryID()#" />
</form>

</cfoutput>