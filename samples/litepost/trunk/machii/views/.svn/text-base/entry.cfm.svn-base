<cfsilent>
	<cfset entry = event.getArg("entry") />
	<cfset comments = entry.getComments() />
	<cfset isAdmin = event.getArg("isAdmin") />
	<cfset fullDateString = "dddd, mmmm dd, yyyy" />
	<cfset shortDateString = "mmm dd, yyyy" />
	<cfset timeString = "h:mm tt" />
</cfsilent>


<!--- entry detail page --->
<cfoutput>
	<cfif isAdmin>
	<a href="editEntry.html" class="adminbutton">Edit</a>
	</cfif>
	<h1>#entry.getTitle()#</h1>
	<p class="author">Posted by #entry.getPostedBy()#, #dateFormat(entry.getEntryDate(), shortDateString)# @ #timeFormat(entry.getEntryDate(), timeString)#</p>
	<p>#entry.getBody()#</p>

	<!-- footer at the bottom of every post-->
	<div class="postfooter">
		<span>
			<a href="postDetail.html"><img src="../assets/images/comment_icon.gif" alt="Comment" border="0" /></a> 
			<a href="postDetail.html##comments">Comments (#entry.getNumComments()#)</a>
		</span>
		<span class="right">
			<cfif entry.getCategoryID() neq 0><a href="index.cfm?#getProperty('eventParameter')#=showHome&categoryID=#entry.getCategoryID()#">Filed under #entry.getCategory()#</a><cfelse>Unfiled</cfif>
		</span>
	</div>

	<a name="comments"></a>
	<h2>Comments</h2>
	<cfif arrayLen(comments) gt 0>
		<cfloop index="i" from="1" to="#arrayLen(comments)#">
			<cfset comment = comments[i] />
			<div class="comment">
				<p>
					<strong>
						<cfif comment.getUrl() is not ""><a href="#comment.getUrl()#" target="_blank"></cfif>
						#comment.getName()#
						<cfif comment.getUrl() is not ""></a></cfif>
					</strong> 
					- <em>#dateFormat(comment.getDateCreated(), "mm/dd/yyyy")#</em></p>
				<p>#comment.getName()# says ... #comment.getComment()#</p>
		 	</div>
			<p><a href="##content"><img src="../assets/images/top_icon.gif" alt="top" /></a> <a href="##content">top</a></p>
		</cfloop>
	<cfelse>
		<p>No comments yet. Be the first to add a comment!</p>
	</cfif>
  
	<h2>Add A Comment </h2>
	<form id="comment" name="comment" method="post" action="index.cfm?#getProperty('eventParameter')#=processCommentForm">
		<label>Your Name
		<input type="text" name="name" />
		</label>
		<label>Email (not shared with anyone)
		<input type="text" name="email" />
		</label>
		<label>URL (linked in your post)
		<input type="text" name="url" />
		</label>
		<label>Comment
		<textarea name="comment" class="comment"></textarea>
		</label>
		<input type="submit" name="submit" value="Submit" class="adminbutton" />
		<!--- <button name="submit">Submit</button> --->
		<input type="hidden" name="entryID" value="#entry.getEntryID()#" />
		<input type="hidden" name="includeComments" value="true" />
	</form>
  <p>&nbsp;</p>

</cfoutput>
