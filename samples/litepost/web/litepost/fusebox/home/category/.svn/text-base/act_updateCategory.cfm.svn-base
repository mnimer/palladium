<!---------------------------

act_updateCategory

Updates an existing category.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.categoryID" default="0" type="string" />
	<cfparam name="ATTRIBUTES.category" default="" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation" message="Missing/Invalid Field" detail="One of the required fields is missing or invalid.">
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.categoryID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
</cfif>
<cfif isEmpty(ATTRIBUTES.category)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Category Required" detail="You must specify a category name." />
</cfif>

<!---- add category ---->
<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	UPDATE categories
	SET	category = <cfqueryparam value="#ATTRIBUTES.category#" cfsqltype="cf_sql_intenger" null="false" />
	WHERE categoryID = <cfqueryparam value="#ATTRIBUTES.categoryID#" cfsqltype="cf_sql_intger" null="false" />
</cfquery>