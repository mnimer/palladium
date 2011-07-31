<!---------------------------

qry_getCategories

Returns a query containing the
specified category.

----------------------------->

<!---- set default parameters ---->
<cftry>
	<cfparam name="ATTRIBUTES.id" default="0" type="numeric" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Category" detail="The specified category is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed parameters ---->
<cfif NOT isValidID(ATTRIBUTES.id) OR ATTRIBUTES.id EQ 0>
	<cfthrow type="validation" message="Invalid Category" detail="The specified category is invalid." />
</cfif>

<cfquery name="REQUEST.qryCategory" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT	c.categoryID, c.category
	FROM	categories c
	WHERE	categoryID = <cfqueryparam value="#ATTRIBUTES.id#" cfsqltype="cf_sql_integer" null="false" />
</cfquery>