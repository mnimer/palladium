<cfsilent>
	<cfset bookmark = event.getArg("bookmark") />
	<cfif not bookmark.getBookmarkID() eq 0>
		<cfset label="Update" />
	<cfelse>
		<cfset label="Create" />
	</cfif>
</cfsilent>

<cfoutput>
	<h1>#label# Link</h1>
	
	<form id="editBookmark" name="editBookmark" method="post" action="index.cfm?#getProperty('eventParameter')#=processBookmarkForm">
		<label>Link Name<br />
		<input name="name" type="text" value="#bookmark.getName()#" />
		</label>
		<label>Link URL<br />
		<input name="url" type="text" value="#bookmark.getUrl()#" />
		</label>
		<!--- <button name="submit">Submit</button> --->
		<input type="submit" name="submit" value="#label#" class="adminbutton" />
		<input type="hidden" name="bookmarkID" value="#bookmark.getBookmarkID()#" />
	</form>
</cfoutput>