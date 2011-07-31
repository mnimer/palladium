<!---------------------------

act_updateBookmark

Updates an existing bookmark.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.bookmarkID" default="0" type="string" />
	<cfparam name="ATTRIBUTES.name" default="" type="string" />
	<cfparam name="ATTRIBUTES.url" default="" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation" message="Missing/Invalid Field" detail="One of the required fields is missing or invalid.">
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.bookmarkID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Bookmark" detail="You must specify a valid bookmark." />
</cfif>
<cfif isEmpty(ATTRIBUTES.name)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Bookmark Required" detail="You must specify a bookmark name." />
</cfif>
<cfif isEmpty(ATTRIBUTES.url)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Url Required" detail="You must specify a bookmark url." />
</cfif>

<!---- add category ---->
<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	UPDATE  bookmarks
	SET		name = <cfqueryparam value="#ATTRIBUTES.name#" cfsqltype="cf_sql_varchar" null="false" />,
			url = <cfqueryparam value="#ATTRIBUTES.url#" cfsqltype="cf_sql_varchar" null="false" />
	WHERE bookmarkID = <cfqueryparam value="#ATTRIBUTES.bookmarkID#" cfsqltype="cf_sql_intger" null="false" />
</cfquery>