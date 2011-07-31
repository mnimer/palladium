<!---------------------------

qry_getEntries

Returns a query containing all the existing entires.

----------------------------->
<cfparam name="ATTRIBUTES.categoryID" default="0" type="numeric" />
<cfparam name="ATTRIBUTES.activeOnly" default="false" type="boolean" />
<cfparam name="ATTRIBUTES.numToReturn" default="0" type="numeric" />

<cfquery name="REQUEST.qryEntry" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT	e.entryID, e.title, e.body, DATE(e.dateCreated) AS entryDate,
			e.dateCreated, e.dateLastUpdated, e.categoryID, ct.category, COUNT(c.commentID) AS numComments,
			u.fname AS author
	FROM	entries e INNER JOIN users u ON e.userID = u.userID
			LEFT OUTER JOIN categories ct ON e.categoryID = ct.categoryID 
			LEFT OUTER JOIN comments c ON e.entryID = c.entryID
	WHERE 1=1 
		<cfif ATTRIBUTES.activeOnly>
			AND (e.dateCreated <= <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" />)
		</cfif>
		<cfif ATTRIBUTES.categoryID neq 0>
			AND (e.categoryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ATTRIBUTES.categoryID#" />)
		</cfif>
	GROUP BY e.entryID, e.title, e.body, e.dateCreated, e.dateLastUpdated 
	ORDER BY dateCreated DESC 
	<cfif ATTRIBUTES.numToReturn GT 0>
		LIMIT <cfqueryparam cfsqltype="cf_sql_integer" value="#ATTRIBUTES.numToReturn#" /> 
	</cfif>
</cfquery>