<!---------------------------

qry_getBookmarks

Returns a query containing all
available bookmarks.

----------------------------->


<cfquery name="REQUEST.qryBookmarks" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT	b.name, b.url, b.bookmarkID
	FROM	bookmarks b
	ORDER BY b.name ASC
</cfquery>