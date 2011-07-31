
<!--- categories sidebar --->
<cfsilent>
	<cfset categories = viewState.getValue("categories") />
	<cfset isAdmin = viewState.getValue("isAdmin") />
	<cfset myself = viewState.getValue("myself") />
</cfsilent>

<cfoutput>
	
<cfif isAdmin>
	<script type="text/javascript">
		function deleteCategory(categoryID) {
			if(confirm("Are you sure you want to delete this category?")) {
				location.href = "#myself#deleteCategory&categoryID=" + categoryID;
			}
		}
	</script>
</cfif>
<div>
	<h2>
		Categories
		<cfif isAdmin>
			<a href="#myself#addCategory">
				<img src="../assets/images/add_icon.gif" border="0" title="Add Category" alt="Add Category" />
			</a>
		</cfif>
	</h2>
</div>

<ul>
	
	<cfif arrayLen(categories) lt 1>
		<li><em>no categories</em></li>
	<cfelse>
	
		<cfloop from="1" to="#ArrayLen(categories)#" index="i">
			
			<cfset category = categories[i] />
			<cfset catID = category.getCategoryID() />
			
			<li>
				<a href="#myself#home&categoryID=#catID#">#category.getCategory()#</a> (#category.getNumPosts()#)
				[<a href="#myself#categoryRSS&categoryID=#category.getCategoryID()#&categoryName=#category.getCategory()#">rss</a>]
				<cfif isAdmin>
					&nbsp;
					<a href="#myself#editCategory&categoryID=#catID#">
						<img src="../assets/images/edit_icon.gif" border="0" title="Edit Category" alt="Edit Category" />
					</a>
					<a href="javascript:void(0);" onClick="javascript:deleteCategory(#catID#)">
						<img src="../assets/images/delete_icon.gif" border="0" title="Delete Category" alt="Delete Category" />
					</a>
				</cfif>
			</li>
			
		</cfloop>
		
	</cfif>

</ul>

</cfoutput>