<!---------------------------

act_createBookmark

Adds a new bookmark.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.name" default="" type="string" />
	<cfparam name="ATTRIBUTES.url" default="" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation" message="Missing/Invalid Field" detail="One of the required fields is missing or invalid.">
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif isEmpty(ATTRIBUTES.name)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Bookmark Required" detail="You must specify a bookmark name." />
</cfif>
<cfif isEmpty(ATTRIBUTES.url)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Url Required" detail="You must specify a bookmark url." />
</cfif>

<!---- add bookmark ---->
<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	INSERT INTO bookmarks(name, url)
	VALUES
	(
		<cfqueryparam value="#ATTRIBUTES.name#" cfsqltype="cf_sql_varchar" null="false" />,
		<cfqueryparam value="#ATTRIBUTES.url#" cfsqltype="cf_sql_varchar" null="false" />
	)
</cfquery>
<!---- get newly created id ---->
<cfquery name="REQUEST.qryBookmark" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT LAST_INSERT_ID() AS NewID
</cfquery>