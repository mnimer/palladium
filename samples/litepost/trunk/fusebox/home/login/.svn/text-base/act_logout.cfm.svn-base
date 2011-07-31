	<cflock scope="SESSION" type="exclusive" throwontimeout="true" timeout="2">
		<cfset SESSION.user = structNew() />
		<cfset SESSION.user.username = '' />
		<cfset SESSION.user.password = '' />
		<cfset SESSION.user.role = '' />
		<cfset SESSION.user.fname = '' />
		<cfset SESSION.user.lname = '' />
		<cfset SESSION.user.email = '' />
		<cfset SESSION.user.id = '' />
		<cfset SESSION.user.isLoggedIn = 'false' />
	</cflock>
	<cftrace type="information" category="security" text="Logout success." />