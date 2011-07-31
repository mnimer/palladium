<!---------------------------

qry_getComments

Returns a query containing all
comments.

----------------------------->
<!---- set default parameters ---->
<cftry>
	<cfparam name="ATTRIBUTES.id" default="0" type="numeric" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Entry" detail="The specified entry is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed parameters ---->
<cfif NOT isValidID(ATTRIBUTES.id) OR ATTRIBUTES.id EQ 0>
	<cfthrow type="validation" message="Invalid Entry" detail="The specified entry is invalid." />
</cfif>

<cfquery name="REQUEST.qryComment" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT commentID, entryID, comment, name, email, url, dateCreated 
	FROM comments
	WHERE entryID = <cfqueryparam value="#ATTRIBUTES.id#" cfsqltype="cf_sql_integer" />
</cfquery>