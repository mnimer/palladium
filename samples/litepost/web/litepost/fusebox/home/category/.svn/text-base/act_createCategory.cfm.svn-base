<!---------------------------

act_createcategory

Adds a new category.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.category" default="" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation" message="Missing/Invalid Field" detail="One of the required fields is missing or invalid.">
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif isEmpty(ATTRIBUTES.category)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Category Required" detail="You must specify a category name." />
</cfif>

<!---- add category ---->
<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	INSERT INTO categories(category)
	VALUES(<cfqueryparam value="#ATTRIBUTES.category#" cfsqltype="cf_sql_varchar" />)
</cfquery>
<!---- get newly created id ---->
<cfquery name="REQUEST.qryCategory" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT LAST_INSERT_ID() AS NewID
</cfquery>