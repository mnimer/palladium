<!---------------------------

act_createEntry

Adds a new entry.

----------------------------->

<!---- set default parametes ---->
<cftry>
	<cfparam name="ATTRIBUTES.categoryID" default="0" type="string" />
	<cfparam name="ATTRIBUTES.title" default="" type="string" />
	<cfparam name="ATTRIBUTES.body" default="" type="string" />
	<cfcatch type="any">
		<cfthrow type="validation" message="Missing/Invalid Field" detail="One of the required fields is missing or invalid.">
	</cfcatch>
</cftry>

<!---- validate passed arguments ---->
<cfif NOT isValidID(ATTRIBUTES.categoryID)>
	<cfthrow type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
</cfif>
<cfif isEmpty(ATTRIBUTES.title)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Entry Title Required" detail="You must specify a title for the entry." />
</cfif>
<cfif isEmpty(ATTRIBUTES.body)>
	<cfthrow type="validation.REQUIRED_FIELD" message="Entry Body Required" detail="You must specify the body of the entry." />
</cfif>

<!---- create new post and return new id ---->
<cftransaction>
	<cftry>
		<!----insert new entry ---->
		<cfquery datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
		INSERT INTO entries
		(
			categoryID, title, body, userID, dateCreated, dateLastUpdated
		)
		VALUES
		(
			<cfqueryparam cfsqltype="cf_sql_integer" value="#ATTRIBUTES.categoryID#"  />,
			<cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#ATTRIBUTES.title#" />,
			<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#ATTRIBUTES.body#" />,
			<cfqueryparam cfsqltype="cf_sql_integer" value="#SESSION.user.id#" />,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#" />,
			<cfqueryparam cfsqltype="cf_sql_timestamp" value="#Now()#" />
		)
		</cfquery>
		<!---- get newly created ID ---->
		<cfquery name="REQUEST.qryEntry" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
			SELECT LAST_INSERT_ID() AS NewID
		</cfquery>
		<!---- commit ---->
		<cftransaction action="commit" />
		<cfcatch type="database">
			<cftransaction action="rollback" />
			<cfrethrow />
		</cfcatch>
	</cftry>
</cftransaction>