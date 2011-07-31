<!--- categories sidebar --->
<cfsilent>
	<cfset categories = event.getArg("categories") />
</cfsilent>

<cfoutput>
<cfif event.getArg("isAdmin")>
	<script type="text/javascript">
		function deleteCategory(categoryID) {
			if(confirm("Are you sure you want to delete this category?")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=deleteCategory&categoryID=" + categoryID;
			}
		}
	</script>
</cfif>
<div>
	<h2>
		Categories
		<cfif event.getArg("isAdmin")>
			<a href="index.cfm?#getProperty('eventParameter')#=showCategoryForm">
				<img src="../assets/images/add_icon.gif" border="0" title="Add Category" alt="Add Category" />
			</a>
		</cfif>
	</h2>
</div>

<ul>
	<cfif arrayLen(categories) gt 0>
		<cfloop from="1" to="#ArrayLen(categories)#" index="i">
			<cfset category = categories[i] />
			<li>
				<a href="index.cfm?#getProperty('eventParameter')#=showHome&categoryID=#category.getCategoryID()#">
					#category.getCategory()# (#category.getNumPosts()#) 
				</a>
				[<a href="index.cfm?#getProperty('eventParameter')#=showCategoryRSS&categoryID=#category.getCategoryID()#&categoryName=#category.getCategory()#">rss</a>]
				<cfif event.getArg("isAdmin")>
					&nbsp;
					<a href="index.cfm?#getProperty('eventParameter')#=showCategoryForm&categoryID=#category.getCategoryID()#">
						<img src="../assets/images/edit_icon.gif" border="0" title="Edit Category" alt="Edit Category" />
					</a>
					<a href="javascript:void(0);" onClick="javascript:deleteCategory(#category.getCategoryID()#)">
						<img src="../assets/images/delete_icon.gif" border="0" title="Delete Category" alt="Delete Category" />
					</a>
				</cfif>
				<br />
			</li>
		</cfloop>
	<cfelse>
		<li><em>no categories</em></li>
	</cfif>
</ul>
</cfoutput>
