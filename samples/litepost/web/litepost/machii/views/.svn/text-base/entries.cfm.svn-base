<cfsilent>
	<cfset entries = event.getArg("entries") />
	<cfset message = event.getArg("message", "") />
	<cfset isAdmin = event.getArg("isAdmin") />
	<cfset fullDateString = "dddd, mmmm dd, yyyy" />
	<cfset shortDateString = "mmm dd, yyyy" />
	<cfset timeString = "h:mm tt" />
</cfsilent>

<!--- main entries page --->
<cfoutput>
	<cfif isAdmin>
	<script type="text/javascript">
		function deleteEntry(entryID) {
			if(confirm("Are you sure you want to delete this entry?")) {
				location.href = "index.cfm?#getProperty('eventParameter')#=deleteEntry&entryID=" + entryID;
			}
		}
	</script>
	
	<div align="right">
		<a href="index.cfm?#getProperty('eventParameter')#=showEntryForm">
			<img src="../assets/images/add_icon.gif" title="Add Entry" alt="Add Entry" border="0" />
		</a>
		<a href="index.cfm?#getProperty('eventParameter')#=showEntryForm">
			Add Entry
		</a>
	</div>
	</cfif>
	
	<cfif message is not "">
		<p><strong>#message#</strong></p>
	</cfif>
	
	<cfif arrayLen(entries) gt 0>
		<cfloop from="1" to="#ArrayLen(entries)#" index="i">
			<cfset entry = entries[i] />
			<h1>#entry.getTitle()#</h1>
			<p class="author">Posted by #entry.getPostedBy()#, #dateFormat(entry.getEntryDate(), shortDateString)# @ #timeFormat(entry.getEntryDate(), timeString)#</p>
			<p>#entry.getBody()#</p>

			<!-- footer at the bottom of every post-->
			<div class="postfooter">
				<span>
					<a href="index.cfm?#getProperty('eventParameter')#=showEntry&entryID=#entry.getEntryID()#&includeComments=true">
						<img src="../assets/images/comment_icon.gif" title="Comments" alt="Comments" border="0" />
					</a>
					<a href="index.cfm?#getProperty('eventParameter')#=showEntry&entryID=#entry.getEntryID()#&includeComments=true">
						Comments (#entry.getNumComments()#)
					</a>
				</span>
				<span class="right">
					<cfif entry.getCategoryID() neq 0>
						<a href="index.cfm?#getProperty('eventParameter')#=showHome&categoryID=#entry.getCategoryID()#">
							Filed under #entry.getCategory()#
						</a>
					<cfelse>
						Unfiled
					</cfif>
					<cfif isAdmin>
						<br />
						<a href="index.cfm?#getProperty('eventParameter')#=showEntryForm&entryID=#entry.getEntryID()#">
							<img src="../assets/images/edit_icon.gif" title="Edit Entry" alt="Edit Entry" border="0" />
						</a>
						<a href="javascript:void(0);" onClick="javascript:deleteEntry(#entry.getEntryID()#)">
							<img src="../assets/images/delete_icon.gif" title="Delete Entry" alt="Delete Entry" border="0" />
						</a>
					</cfif>
				</span>
			</div>
		</cfloop>
	<cfelse>
		<em>no entries</em>
	</cfif>

</cfoutput>
