<!---------------------------

qry_getEntry

Returns a query containing the
specified entry.

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

<cfquery name="REQUEST.qryEntry" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT	e.entryID, e.title, e.body, DATE(e.dateCreated) AS entryDate, 
			e.dateCreated, e.dateLastUpdated, e.categoryID, ct.category, COUNT(c.commentID) AS numComments,
			u.fname AS author
	FROM	entries e INNER JOIN users u ON e.userID = u.userID
			LEFT OUTER JOIN categories ct ON e.categoryID = ct.categoryID 
			LEFT OUTER JOIN comments c ON e.entryID = c.entryID
	WHERE e.entryID = <cfqueryparam value="#ATTRIBUTES.entryID#" cfsqltype="cf_sql_integer" />
	GROUP BY e.entryID, e.title, e.body, e.dateCreated, e.dateLastUpdated 
</cfquery>