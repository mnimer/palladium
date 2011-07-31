<!---
	fusebox.init.cfm is included by the framework at the start of every request.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-request initialization and manipulation of the
	Fusebox fuseaction variables.
	
	You can set attributes.fuseaction, for example, to override the default
	fuseaction.
	
	A typical usage is to set "self" and "myself" variables, as shown below,
	for use inside display fuses when creating links.
--->
<cfset REQUEST.self = "index.cfm" />
<cfset REQUEST.myself = "#REQUEST.self#?#myFusebox.getApplication().fuseactionVariable#=" />

<!---- define content variables ---->
<cfset REQUEST.content = structNew() />
<cfset REQUEST.content.body = '' />
<cfset REQUEST.content.title = '' />
<cfset REQUEST.content.head = '' />
<cfset REQUEST.content.footer = '' />

<!---- default session parameters ---->
<cfif NOT structKeyExists(SESSION, 'user')>
	<cfset SESSION.user = structNew() />
	<cfset SESSION.user.username = '' />
	<cfset SESSION.user.password = '' />
	<cfset SESSION.user.role = '' />
	<cfset SESSION.user.fname = '' />
	<cfset SESSION.user.lname = '' />
	<cfset SESSION.user.email = '' />
	<cfset SESSION.user.id = 0 />
	<cfset SESSION.user.isLoggedIn = 'false' />
</cfif>

<!---- load udf to variables scope ---->
<cfif structKeyExists(APPLICATION, 'udf')>
	<cfloop collection="#APPLICATION.udf#" item="key">
		<cfset VARIABLES[key] = APPLICATION.udf[key] />
	</cfloop>
</cfif>