<cfsilent>
	<cfset entry = viewState.getValue("entry") />
	<cfset commentBean = viewState.getValue("commentBean") />
	<cfset message = viewState.getValue("message") />
	<cfset isAdmin = viewState.getValue("isAdmin") />
	<cfset myself = viewState.getValue("myself") />
	<cfset fullDateString = "dddd, mmmm dd, yyyy" />
	<cfset shortDateString = "mmm dd, yyyy" />
	<cfset timeString = "h:mm tt" />
</cfsilent>

<!--- entry with comments page --->
<cfoutput>
	
	<!--- output entry --->
	<h1>#entry.getTitle()#</h1>
	<p class="author">Posted by #entry.getPostedBy()#, #dateFormat(entry.getEntryDate(), shortDateString)# @ #timeFormat(entry.getEntryDate(), timeString)#</p>
	<p>#ParagraphFormat(entry.getBody())#</p
	
	<!-- footer at the bottom of every post -->
	<div class="postfooter">
		<span>
			<a href="#myself#comments&entryID=#entry.getEntryID()#">
				<img src="../assets/images/comment_icon.gif" title="Comments" alt="Comments" border="0" />
			</a>
			<a href="#myself#comments&entryID=#entry.getEntryID()#">
				Comments (#entry.getNumComments()#)
			</a>
		</span>
		<span class="right">
			<cfif entry.getCategoryID() neq 0>
				<a href="#myself#home&categoryID=#entry.getCategoryID()#">
					Filed under #entry.getCategory()#
				</a>
			<cfelse>
				Unfiled
			</cfif>
			<!--- 
			<cfif isAdmin>
				<br />
				<a href="#myself#editEntry&entryID=#entry.getEntryID()#">
					<img src="../assets/images/edit_icon.gif" title="Edit Entry" alt="Edit Entry" border="0" />
				</a>
				<a href="javascript:void(0);" onClick="javascript:deleteEntry(#entry.getEntryID()#)">
					<img src="../assets/images/delete_icon.gif" title="Delete Entry" alt="Delete Entry" border="0" />
				</a>
			</cfif>
			--->
		</span>
	</div>
	
	<!--- output comments --->
	<a name="comments"></a>
	<h2>Comments</h2>
	
	<cfset comments = entry.getComments() />
	
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
				<p>#comment.getName()# says ... #ParagraphFormat(comment.getComment())#</p>
		 	</div>
			<p><a href="##content"><img src="../assets/images/top_icon.gif" alt="top" /></a> <a href="##content">top</a></p>
		</cfloop>
	<cfelse>
		<p>No comments yet. Be the first to add a comment!</p>
	</cfif>
	
	<cfif len(message)>
		<p><strong>#message#</strong></p>
	</cfif>
	
	<h2>Add A Comment </h2>
	<form id="comment" name="comment" action="#myself#saveComment" method="post">
		<input type="hidden" name="entryID" value="#entry.getEntryID()#" />
		<label>Your Name<br/>
		<input type="text" name="name" value="#commentBean.getName()#" />
		</label>
		<label>Email (not shared with anyone)<br/>
		<input type="text" name="email" value="#commentBean.getEmail()#" />
		</label>
		<label>URL (linked in your post)<br/>
		<input type="text" name="url" value="#commentBean.getUrl()#" />
		</label>
		<label>Comment<br/>
		<textarea name="comment" class="comment">#commentBean.getComment()#</textarea>
		</label>
		<input type="submit" name="submit" value="Submit" class="adminbutton" />
	</form>
  <p>&nbsp;</p>
	
</cfoutput>
