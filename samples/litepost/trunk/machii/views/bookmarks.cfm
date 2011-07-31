
<!--- bookmarks sidebar --->
<cfsilent>
	<cfset bookmarks = event.getArg("bookmarks") />
	<cfset isAdmin = event.getArg("isAdmin") />
</cfsilent>

<cfoutput>
	
<cfif isAdmin>
	<script type="text/javascript">
		function deleteBookmark(bookmarkID) {
			if(confirm("Are you sure you want to delete this link?")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=deleteBookmark&bookmarkID=" + bookmarkID;
			}
		}
	</script>
</cfif>
<div>
	<h2>
		Links
		<cfif isAdmin>
			<a href="index.cfm?#getProperty('eventParameter')#=showBookmarkForm">
				<img src="../assets/images/add_icon.gif" border="0" title="Add Link" alt="Add Link" />
			</a>
		</cfif>
	</h2>
</div>

<ul>
	
	<cfif arrayLen(bookmarks) lt 1>
		<li><em>no links</em></li>
	<cfelse>

		<cfloop from="1" to="#arrayLen(bookmarks)#" index="i">
			
			<cfset bookmark = bookmarks[i] />
			<cfset linkUrl = bookmark.getUrl() />
			<cfset bkmkID = bookmark.getBookmarkID() />
			
			<cfif Left(linkUrl,7) NEQ "http://">
				<cfset linkUrl = "http://" & linkUrl />
			</cfif>
			
			<li>
				<a href="#linkUrl#" target="_blank">#bookmark.getName()#</a>
				<cfif isAdmin>
					&nbsp;
					<a href="index.cfm?#getProperty('eventParameter')#=showBookmarkForm&bookmarkID=#bkmkID#">
						<img src="../assets/images/edit_icon.gif" border="0" title="Edit Link" alt="Edit Link" />
					</a>
					<a href="javascript:void(0);" onClick="javascript:deleteBookmark(#bkmkID#)">
						<img src="../assets/images/delete_icon.gif" border="0" title="Delete Link" alt="Delete Link" />
					</a>
				</cfif>
			</li>
			<!--- NO ADMIN YET... 
			<cfif isAdmin>
			<div class="postlinks">
				<a href="">edit</a> | 
				<cfif i eq ArrayLen(bookmarks)><a href="">+</a> | </cfif>
				<a href="">-</a>
			</div>
			</cfif>
			--->
		</cfloop>
		
	</cfif>

</ul>

</cfoutput>