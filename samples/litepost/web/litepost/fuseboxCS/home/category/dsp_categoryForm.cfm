<!---- set default values ---->
<cfparam name="ATTRIBUTES.category" default="" type="string" />
<cfparam name="ATTRIBUTES.categoryID" default="0" type="string" />
<cfparam name="XFA.submit" default="" type="string" />

<cfoutput>
<!---- dsp_categoryForm ---->
<h1>Add Category</h1>
			
<form id="editCategory" name="editCategory" method="post" action="#REQUEST.myself##XFA.submit#">
	<label>Category<br /><input name="category" type="text" value="#ATTRIBUTES.category#" /></label>
	<button name="submit">Submit</button>
	<input type="hidden" name="categoryID" value="#ATTRIBUTES.categoryID#" />
</form>

</cfoutput>