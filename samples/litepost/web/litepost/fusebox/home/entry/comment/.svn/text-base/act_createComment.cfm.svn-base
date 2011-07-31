<!---------------------------

act_createComment

Adds a new comment to the
specified entry.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.entryID" default="0" type="string" />
	<cfparam name="ATTRIBUTES.comment" default="" type="string" />
	<cfparam name="ATTRIBUTES.name" default="" type="string" />
	<cfparam name="ATTRIBUTES.email" default="" type="string" />
	<cfparam name="ATTRIBUTES.url" default="" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation" message="Missing/Invalid Field" detail="One of the required fields is missing or invalid.">
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.entryID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Entry" detail="You must specify a valid entry." />
</cfif>
<cfif isEmpty(ATTRIBUTES.comment)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Comment Required" detail="You must specify your comment." />
</cfif>
<cfif isEmpty(ATTRIBUTES.name)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Name Required" detail="You must specify your name." />
</cfif>
<cfif isEmpty(ATTRIBUTES.email)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Email Required" detail="You must specify your email address." />
</cfif>

<!---- add comment ---->
<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	INSERT INTO comments
	(
		entryID, 
		comment, 
		name, 
		email, 
		url, 
		dateCreated
	)
	VALUES
	(
		<cfqueryparam value="#ATTRIBUTES.entryID#" cfsqltype="cf_sql_integer" />, 
		<cfqueryparam value="#ATTRIBUTES.comment#" cfsqltype="cf_sql_varchar" />, 
		<cfqueryparam value="#ATTRIBUTES.name#" cfsqltype="cf_sql_varchar" />, 
		<cfqueryparam value="#ATTRIBUTES.email#" cfsqltype="cf_sql_varchar" />, 
		<cfqueryparam value="#ATTRIBUTES.url#" cfsqltype="cf_sql_varchar" />, 
		<cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp" />
	)
</cfquery>
<!---- get newly created id ---->
<cfquery name="REQUEST.qryComment" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
	SELECT LAST_INSERT_ID() AS NewID
</cfquery>