<cfsilent>
	<cfset entries = viewState.getValue("entries") />
	<cfset message = viewState.getValue("message", "") />
	<cfset isAdmin = viewState.getValue("isAdmin") />
	<cfset myself = viewState.getValue("myself") />
	<cfset fullDateString = "dddd, mmmm dd, yyyy" />
	<cfset shortDateString = "mmm/dd/yyyy" />
	<cfset timeString = "h:mm tt" />
</cfsilent>

<!--- main entries page --->

<cfoutput>
	
	<cfif isAdmin>
	<script type="text/javascript">
		function deleteEntry(entryID) {
			if(confirm("Are you sure you want to delete this entry?")) {
				location.href = "#myself#deleteEntry&entryID=" + entryID;
			}
		}
	</script>
	
	<div align="right">
		<a href="#myself#addEntry">
			<img src="../assets/images/add_icon.gif" title="Add Entry" alt="Add Entry" border="0" />
		</a>
		<a href="#myself#addEntry">
			Add Entry
		</a>
	</div>
	</cfif>
	
	<cfif len(message)>
		<p><strong>#message#</strong></p>
	</cfif>
	
	<cfif arrayLen(entries) lt 1>
		<em>no entries</em>
	<cfelse>
	
		<cfloop from="1" to="#ArrayLen(entries)#" index="i">
			<cfset entry = entries[i] />
			
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
					<cfif isAdmin>
						<br />
						<a href="#myself#editEntry&entryID=#entry.getEntryID()#">
							<img src="../assets/images/edit_icon.gif" title="Edit Entry" alt="Edit Entry" border="0" />
						</a>
						<a href="javascript:void(0);" onClick="javascript:deleteEntry(#entry.getEntryID()#)">
							<img src="../assets/images/delete_icon.gif" title="Delete Entry" alt="Delete Entry" border="0" />
						</a>
					</cfif>
				</span>
			</div>
			
		</cfloop>
	
	</cfif>

</cfoutput>

