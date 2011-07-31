<!---- set default values ---->
<cfparam name="ATTRIBUTES.name" default="" type="string" />
<cfparam name="ATTRIBUTES.url" default="" type="string" />
<cfparam name="ATTRIBUTES.bookmarkID" default="0" type="string" />
<cfparam name="XFA.submit" default="" type="string" />

<cfoutput>
<!---- dsp_categoryForm ---->
<h1>Add Bookmark</h1>
			
<form id="bookmarkForm" name="bookmarkForm" method="post" action="#REQUEST.myself##XFA.submit#">
	<label>Name<br /><input name="name" type="text" value="#ATTRIBUTES.name#" /></label>
	<label>URL<br /><input name="url" type="text" value="#ATTRIBUTES.url#" /></label>
	<button name="submit">Submit</button>
	<input type="hidden" name="bookmarkID" value="#ATTRIBUTES.bookmarkID#" />
</form>

</cfoutput>