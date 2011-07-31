<!---------------------------

qry_getCategories

Returns a query containing all
available categories.

----------------------------->


<cfquery name="REQUEST.qryCategories" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT	c.categoryID, c.category, COUNT(e.entryID) AS entryCount
	FROM	categories c LEFT OUTER JOIN entries e ON e.categoryID = c.categoryID
	GROUP BY c.categoryID, c.category
	ORDER BY category ASC
</cfquery>