<!---
	fusebox.appinit.cfm is included by the framework when the application is
	started, i.e., on the very first request (in production mode) or whenever
	the framework is reloaded, either with development-full-load mode or when
	fusebox.load=true or fusebox.loadclean=true is specified.
	It is included within a cfsilent tag so it cannot generate output. It is
	intended to be for per-application initialization that can not easily be
	done in the appinit global fuseaction.
	It is included inside a conditional lock, ensuring that only one request
	can execute this file.
	
	For example, if you are sharing application variables between a Fusebox
	application and a non-Fusebox application, you can initialize them here
	and then cfinclude this file into your non-Fusebox application.
--->
<cflock scope="Application" type="exclusive" timeout="10" throwontimeout="true">
	

	<!----
	
	LitePost Settings
	
	----->

	<!---- define application settings ---->
	<cfset APPLICATION.settings = structNew() />
	
	<!---- general settings ---->
	<cfset APPLICATION.settings.name = 'LiteWire FBCS' />
	<cfset APPLICATION.settings.version = '0.00.01'>
	
	<!---- datasource ---->
	<cfset APPLICATION.settings.dsn = structNew() />
	<cfset APPLICATION.settings.dsn.name = 'LitePost' />
	<cfset APPLICATION.settings.dsn.username = '' />
	<cfset APPLICATION.settings.dsn.password = '' />
	
	<!----
	
	Blog Settings
	
	----->
	
	<cfset APPLICATION.settings.blog = structNew() />
	<cfset APPLICATION.settings.blog.name = 'LitePost - Fusebox/ColdSpring Edition' />
	<cfset APPLICATION.settings.blog.url = 'http://192.168.3.100/fuseboxCS/' />
	<cfset APPLICATION.settings.blog.description = 'The FuseBox 5.1 / ColdSpring Edition of LitePost.' />
	<cfset APPLICATION.settings.blog.language = 'en_US' />
	<cfset APPLICATION.settings.blog.email.author = 'adrocknaphobia@gmail.com' />
	<cfset APPLICATION.settings.blog.email.webmaster = 'adrocknaphobia@gmail.com' />
	<cfset APPLICATION.settings.blog.numOfEntries = 20 />
	

	<!----
	
	udfs
	
	----->
	
	<cfscript>
		APPLICATION.udf = structNew();
		
		function isValidID(arg)
		{
			if(NOT isNumeric(ARGUMENTS.arg))return false;
			if(ARGUMENTS.arg LTE -1)return false;
			return true;
		}
		APPLICATION.udf.isValidID = isValidID;
		
		function isEmpty(arg)
		{
			if(len(trim(arg)))return false;
			return true;
		}
		APPLICATION.udf.isEmpty = isEmpty;
	</cfscript>

</cflock>

<cftrace type="information" category="init" text="Application settings initialized." inline="false" />