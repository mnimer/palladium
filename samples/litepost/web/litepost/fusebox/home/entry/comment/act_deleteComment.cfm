<!---------------------------

act_deleteComment

Removes the specified comment.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.commentID" default="0" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation.INVALID_ID" message="Missing/Invalid Comment" detail="The specified comment is missing or invalid." />
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.commentID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Comment" detail="You must specify a valid comment." />
</cfif>

<!---- get entry id for forward ---->
<cfquery name="REQUEST.qryComment" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT entryID
	FROM comments
	WHERE commentID = <cfqueryparam value="#ATTRIBUTES.commentID#" cfsqltype="cf_sql_integer" />
</cfquery>
<cfif NOT REQUEST.qryComment.recordCount>
	<cfthrow type="validation.NO_RECORDS_FOUND" message="Missing Comment" detail="The specified comment does not exist." />
</cfif>

<!---- delete comment ---->
<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	DELETE FROM comments
	WHERE commentID = <cfqueryparam value="#ATTRIBUTES.commentID#" cfsqltype="cf_sql_integer" />
</cfquery>