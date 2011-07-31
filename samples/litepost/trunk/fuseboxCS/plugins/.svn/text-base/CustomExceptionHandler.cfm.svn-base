<!--------------------------------------------------------------------
	FB50 plugin: CustomExceptionHandler
	
	Copyright:	(c) 2006, by Adam Wayne Lehman (adrocknaphobia.com). You are free to use this FB50 plugin and to modify it as long as you keep on rocking!
	Usage:		Include the following entry under the 'fuseactionException' phase for plugins in the fusebox.xml.cfm file.
				<plugin name="CustomExceptionHandler" template="CustomExceptionHandler.cfm">
					<parameter name="filePrefix" value="custom" />
					<parameter name="genericErrorTemplate" value="genericErrorMessage" />
				</plugin>
	Overview:	If an exception occurs this plugin will attempt to locate an error template based on the
				type of exception throw.
					1) Exception based on both tokens of cfcatch exception type
						Example: "validation.empty_string"
					2) Exception based on primary token of cfcatch exception type
						Example: "validation"
					3) General exception template
---------------------------------------------------------------------->
<cfparam name="filePrefix" default="custom" type="string" />
<cfparam name="genericErrorTemplate" default="genericErrorMessage" />

<cfcatch type="any">
	
	<cfset plugin = structNew() />
	<cfset plugin.application = myFuseBox.getApplication() />
	<cfset plugin.applicationRoot = plugin.application.getApplicationRoot() />
	<cfset plugin.relativeErrorTemplatePath = plugin.application.relativePath(plugin.applicationRoot & plugin.application.pluginsPath, plugin.applicationRoot & plugin.application.errorTemplatesPath) />	
	<cfset plugin.absoluteErrorTemplatePath = plugin.applicationRoot & plugin.application.errorTemplatesPath />
	<cfif len(trim(filePrefix))>
		<cfset plugin.relativeErrorTemplatePath = plugin.relativeErrorTemplatePath & filePrefix & '.' />
		<cfset plugin.absoluteErrorTemplatePath = plugin.absoluteErrorTemplatePath & filePrefix & '.' />
	</cfif>
	
	<!---- look for exact exception type match ---->
	<cfif fileExists(plugin.absoluteErrorTemplatePath & CFCATCH.type & '.cfm')>
		<cfinclude template="#plugin.relativeErrorTemplatePath##CFCATCH.type#.cfm" />
		<cftrace type="information" text="Custom type-based exception handler called (#plugin.absoluteErrorTemplatePath##CFCATCH.type#).">
	<cfelse>
		<!---- look for top-level handler ---->
		<cfif fileExists(plugin.absoluteErrorTemplatePath & getToken(CFCATCH.type, 1, '.') & '.cfm')>
			<cfinclude template="#plugin.relativeErrorTemplatePath##getToken(CFCATCH.type, 1, '.')#.cfm" />
			<cftrace type="information" text="Custom type-based exception handler called (#plugin.absoluteErrorTemplatePath##getToken(CFCATCH.type,1,'.')#).">
		<cfelse>
			<!---- look for generic handler ---->
			<cfif fileExists(plugin.absoluteErrorTemplatePath & genericErrorTemplate & '.cfm')>
				<cfinclude template="#plugin.relativeErrorTemplatePath##genericErrorTemplate#.cfm" />
				<cftrace type="information" text="Custom generic exception handler called (#plugin.absoluteErrorTemplatePath##genericErrorTemplate#).">
			<cfelse>
				<!---- no custom template found to handle error ---->
				<cftrace type="information" text="Custom exception handler not found.">
				<cfrethrow />
			</cfif>
		</cfif>
	</cfif>
</cfcatch>