<!---------------------------

act_deleteEntry

Deletes the specified entry

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.entryID" default="0" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Entry" detail="The specified entry is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.entryID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Entry" detail="You must specify a valid entry." />
</cfif>

<!---- entry and related comments ---->
<cftransaction>
	<cftry>
		<!---- delete comments ---->
		<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
			DELETE FROM comments
			WHERE entryID = <cfqueryparam value="#ATTRIBUTES.entryID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<!---- delete entry ---->
		<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
			DELETE FROM entries
			WHERE entryID = <cfqueryparam value="#ATTRIBUTES.entryID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<!---- commit ---->
		<cftransaction action="commit" />
		<cfcatch type="database">
			<cftransaction action="rollback" />
			<cfrethrow />
		</cfcatch>
	</cftry>
</cftransaction>