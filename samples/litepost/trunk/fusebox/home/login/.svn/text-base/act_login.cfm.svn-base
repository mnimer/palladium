<!---- qry_login.cfm ---->
<cfparam name="ATTRIBUTES.username" default="" type="string" />
<cfparam name="ATTRIBUTES.password" default="" type="string" />

<!---- query user credentials ---->
<cfquery name="REQUEST.qryLogin" datasource="#APPLICATION.settings.dsn.name#" username="#APPLICATION.settings.dsn.username#" password="#APPLICATION.settings.dsn.password#">
SELECT	U.userID, U.role, U.fName, U.lName, U.email
FROM	users U
WHERE	(U.username = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="15" value="#ATTRIBUTES.username#" />
			AND U.password = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="15" value="#ATTRIBUTES.password#" />)
</cfquery>

<cfif REQUEST.qryLogin.recordCount>
	<cflock scope="SESSION" type="exclusive" throwontimeout="true" timeout="2">
		<cfset SESSION.user = structNew() />
		<cfset SESSION.user.username = ATTRIBUTES.username />
		<cfset SESSION.user.password = ATTRIBUTES.password />
		<cfset SESSION.user.role = REQUEST.qryLogin.role[1] />
		<cfset SESSION.user.fname = REQUEST.qryLogin.fName[1] />
		<cfset SESSION.user.lname = REQUEST.qryLogin.lName[1] />
		<cfset SESSION.user.email = REQUEST.qryLogin.email[1] />
		<cfset SESSION.user.id = REQUEST.qryLogin.userID[1] />
		<cfset SESSION.user.isLoggedIn = 'true' />
	</cflock>
	<cftrace type="information" category="security" text="Login success." />
<cfelse>
	<cfthrow type="security.login" message="Invalid Login" detail="The specified username and/or password is incorrect." />
	<cftrace type="information" category="security" text="Login failed." />
</cfif>