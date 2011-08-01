<cfoutput>
<script>
    function deleteCategory(categoryID)
    {
        if(confirm("Are you sure you want to delete this category?"))
        {
            location.href = "#request.appPath#/category/index.cfm?action=delete&categoryID=" + categoryID;
        }
    }

    function deleteBookmark(bookmarkID)
    {
        if(confirm("Are you sure you want to delete this bookmark?"))
        {
            location.href = "#request.appPath#/bookmark/delete.cfm?bookmarkID=" + bookmarkID;
        }
    }

</script>
	<!-- navigation -->
	<div id="navigation">
		<h2>Navigation</h2>
		<ul>
			<li><a href="#request.appPath#/index.cfm">Home</a></li>
			<cfif isDefined("request.user")>
				<li><a href="#request.appPath#/index.cfm?action=logout">Logout</a></li>
                <cfif request.user.role IS 'admin'>
                    <li><a href="#request.appPath#/post/add.cfm">Add Post</a></li>
                </cfif>
			</cfif>
		</ul>

		
		<cfif isDefined("request.user")>

		<h2>
			Categories
			<cfif request.user.role IS 'admin'>
			    <a href="#request.appPath#/category/index.cfm?action=add"><img src="/litepost/assets/images/add_icon.gif" border="0" /></a></cfif>
		</h2>

		<ul>
            <cfloop index="i" from="1" to="#arrayLen( request.CFJAVAUTILS.toCFArray(request.categories) )#">
            <cfoutput>
            <cfset category = request.categories[i]>
                <li>
                    <a href="#request.appPath#/category/index.cfm?action=view&categoryID=#category.getCategoryID()#">
                        #category.getCategory()# (#category.getEntries().size()#)

                        <cfif request.user.role IS 'admin'>
                            <a href="#request.appPath#/category/index.cfm?action=edit&categoryID=#category.getCategoryID()#"><img src="/litepost/assets/images/edit_icon.gif" border="0" /></a>
                            <a href="javascript:void(0);" onClick="javascript:deleteCategory(#category.getCategoryID()#)">
                                <img src="/litepost/assets/images/delete_icon.gif" border="0" /></a>
                        </cfif>
                    </a>
                    <a href="#request.appPath#/category/rss.cfm?categoryID=#category.getCategoryID()#&rssFormat=atom_1.0"><img src="/litepost/assets/images/rss_icon.gif" border="0" /></a><br />
                </li>
            </cfoutput>
            </cfloop>
        </ul>



		<h2>
			Bookmarks
			<cfif request.user.role IS 'admin'>
			    <a href="#request.appPath#/bookmark/add.cfm"><img src="/litepost/assets/images/add_icon.gif" border="0" /></a></cfif>
		</h2>

		<ul>
		    <cfloop index="i" from="1" to="#arrayLen( request.CFJAVAUTILS.toCFArray(request.bookmarks) )#">
            <cfoutput>
            <cfset bookmark = request.bookmarks[i]>
		    <li>
				<a href="http://www.mikenimer.com" target="_blank">#bookmark.getName()#</a>
					&nbsp;
					<a href="#request.appPath#/bookmark/edit.cfm?bookmarkID=#bookmark.getBookmarkID()#">
						<img src="/litepost/assets/images/edit_icon.gif" border="0" title="Edit Link" alt="Edit Link" />
					</a>
					<a href="javascript:void(0);" onClick="javascript:deleteBookmark(#bookmark.getBookmarkID()#)">
						<img src="/litepost/assets/images/delete_icon.gif" border="0" title="Delete Link" alt="Delete Link" />
					</a>                                                         				
			</li>
			</cfoutput>
            </cfloop>
		</ul>
		</cfif>
		
	</div>
</cfoutput>