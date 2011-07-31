<!---------------------------

act_deleteCategory

Deletes the specified category

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.categoryID" default="0" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Category" detail="The specified category is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.categoryID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
</cfif>

<!---- delete category and update related entries ---->
<cftransaction>
	<cftry>
		<!---- update entries ---->
		<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
			UPDATE 	entries
			SET		categoryID = 0
			WHERE	categoryID = <cfqueryparam value="#ATTRIBUTES.categoryID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<!---- delete entry ---->
		<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
			DELETE FROM categories
			WHERE categoryID = <cfqueryparam value="#ATTRIBUTES.categoryID#" cfsqltype="cf_sql_integer" />
		</cfquery>
		<!---- commit ---->
		<cftransaction action="commit" />
		<cfcatch type="database">
			<cftransaction action="rollback" />
			<cfrethrow />
		</cfcatch>
	</cftry>
</cftransaction>