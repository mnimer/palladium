<cfsilent>
	<cfset entry = event.getArg("entry") />
	<cfset categoriesForSelect = event.getArg("categoriesForSelect") />
	<cfset message = event.getArg("message", "") />
	<cfset isAdmin = event.getArg("isAdmin") />
	
	<cfif not entry.getEntryID() eq 0>
		<cfset label = "Update" />
	<cfelse>
		<cfset label = "Add" />
	</cfif>
</cfsilent>

<cfoutput>

	<h1>#label# Entry </h1>
	
	<cfif message is not "">
		<p><strong>#message#</strong></p>
	</cfif>
	
	<form id="editEntry" name="editEntry" method="post" action="index.cfm?#getProperty('eventParameter')#=processEntryForm">
		<label>Title<br />
		<input name="title" type="text" value="#entry.getTitle()#" />
		</label>
		<label>Entry<br />
		<textarea name="body" class="entry" cols="" rows="">#entry.getBody()#</textarea>
		</label>
		<label>Category<br />
		<select name="categoryID">
			<cfloop index="i" from="1" to="#arrayLen(categoriesForSelect)#">
				<cfset category = categoriesForSelect[i] />
				<option value="#category.getCategoryID()#"<cfif category.getCategoryID() eq entry.getCategoryID()> selected</cfif>>#category.getCategory()#</option>
			</cfloop>
		</select>
		</label>
		<input type="submit" name="submit" value="#label# Entry" class="adminbutton" />
		<!--- <button name="submit">Submit</button> --->
		<input type="hidden" name="entryID" value="#entry.getEntryID()#" />
	</form>
</cfoutput>