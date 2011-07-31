<!---------------------------

act_deleteBookmark

Deletes the specified bookmark

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.bookmarkID" default="0" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Bookmark" detail="The specified bookmark is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.bookmarkID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Bookmark" detail="You must specify a valid bookmark." />
</cfif>

<!---- delete bookmark ---->
<cftransaction>
	<cftry>
		<!---- delete bookmark ---->
		<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
			DELETE FROM bookmarks
			WHERE bookmarkID = <cfqueryparam value="#ATTRIBUTES.bookmarkID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<!---- commit ---->
		<cftransaction action="commit" />
		<cfcatch type="database">
			<cftransaction action="rollback" />
			<cfrethrow />
		</cfcatch>
	</cftry>
</cftransaction>