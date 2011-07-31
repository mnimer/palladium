<!---------------------------

qry_getBookmark

Returns a query containing the
specified bookmark.

----------------------------->

<!---- set default parameters ---->
<cftry>
	<cfparam name="ATTRIBUTES.id" default="0" type="numeric" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Bookmark" detail="The specified bookmark is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed parameters ---->
<cfif NOT isValidID(ATTRIBUTES.id) OR ATTRIBUTES.id EQ 0>
	<cfthrow type="validation" message="Invalid Bookmark" detail="The specified bookmark is invalid." />
</cfif>

<cfquery name="REQUEST.qryBookmark" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT	b.name, b.url, b.bookmarkID
	FROM	bookmarks b
	WHERE	bookmarkID = <cfqueryparam value="#ATTRIBUTES.id#" cfsqltype="cf_sql_integer" null="false" />
</cfquery>