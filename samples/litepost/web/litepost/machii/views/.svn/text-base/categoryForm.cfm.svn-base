<cfsilent>
	<cfset category = event.getArg("category") />
	<cfif not category.getCategoryID() eq 0>
		<cfset label="Update" />
	<cfelse>
		<cfset label="Create" />
	</cfif>
</cfsilent>

<cfoutput>
	<h1>#label# Category</h1>
	
	<form id="editCategory" name="editCategory" method="post" action="index.cfm?#getProperty('eventParameter')#=processCategoryForm">
		<label>Category<br />
		<input name="category" type="text" value="#category.getCategory()#" />
		</label>
		<!--- <button name="submit">Submit</button> --->
		<input type="submit" name="submit" value="#label#" class="adminbutton" />
		<input type="hidden" name="categoryID" value="#category.getCategoryID()#" />
	</form>
</cfoutput>