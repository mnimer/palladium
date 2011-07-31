<cfsetting enablecfoutputonly="true" />
<cfprocessingdirective pageencoding="utf-8" />
<!--- circuit: entry --->
<!--- fuseaction: category --->
<cftry>
<cfset myFusebox.thisPhase = "appinit">
<cfset myFusebox.thisCircuit = "entry">
<cfset myFusebox.thisFuseaction = "category">
<cfif myFusebox.applicationStart>
	<cfif not myFusebox.getApplication().applicationStarted>
		<cflock name="#application.ApplicationName#_fusebox_#FUSEBOX_APPLICATION_KEY#_appinit" type="exclusive" timeout="30">
			<cfif not myFusebox.getApplication().applicationStarted>
<!--- do action="home.initColdSpring" --->
<cfset myFusebox.thisCircuit = "home">
<cfset myFusebox.thisFuseaction = "initColdSpring">
<cfset myFusebox.getApplication().getApplicationData().servicefactory = createObject("component", "coldspring.beans.DefaultXmlBeanFactory").init( defaultProperties="#structnew()#" )/>
<cfset myFusebox.getApplication().getApplicationData().servicefactory.loadBeansFromXmlFile( beanDefinitionFile="#expandPath('/config/litepost-services.xml')#" ) />
<cfset myFusebox.thisCircuit = "entry">
<cfset myFusebox.thisFuseaction = "category">
				<cfset myFusebox.getApplication().applicationStarted = true />
			</cfif>
		</cflock>
	</cfif>
</cfif>
<!--- do action="home.globalXFA" --->
<cftry>
<cfset myFusebox.thisPhase = "preprocessFuseactions">
<cfset myFusebox.thisCircuit = "home">
<cfset myFusebox.thisFuseaction = "globalXFA">
<cfset xfa.home = "entry.recent" />
<cfset xfa.view = "entry.display" />
<cfset xfa.addPost = "entry.addForm" />
<cfset xfa.addCategory = "category.addForm" />
<cfset xfa.editCategory = "category.editForm" />
<cfset xfa.removeCategory = "category.remove" />
<cfset xfa.addBookmark = "bookmark.addForm" />
<cfset xfa.editBookmark = "bookmark.editForm" />
<cfset xfa.removeBookmark = "bookmark.remove" />
<cfset xfa.login = "login.form" />
<cfset xfa.logout = "login.logout" />
<cfset xfa.category = "entry.category" />
<cfset xfa.rss = "entry.rss" />
<cfset xfa.rssCategory = "entry.rssCategory" />
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
</cftry>
<!--- do action="category.getAll" --->
<cftry>
<cfset myFusebox.thisCircuit = "category">
<cfset myFusebox.thisFuseaction = "getAll">
<cfset REQUEST.categoryService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="CategoryService")/> 
<cfset REQUEST.categories = "#REQUEST.categoryService.getCategories()#" />
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
</cftry>
<!--- do action="bookmark.getAll" --->
<cftry>
<cfset myFusebox.thisCircuit = "bookmark">
<cftry>
<cfoutput><cfinclude template="../home/bookmark/qry_getBookmarks.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 20 and right(cfcatch.MissingFileName,20) is "qry_getBookmarks.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse qry_getBookmarks.cfm in circuit bookmark which does not exist (from fuseaction bookmark.getAll).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
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
</cftry>
<!--- do action="home.getSecurity" --->
<cftry>
<cfset myFusebox.thisCircuit = "home">
<cfset myFusebox.thisFuseaction = "getSecurity">
<cfset REQUEST.security = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="securityService")/> 
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
</cftry>
<cftry>
<cfset myFusebox.thisPhase = "requestedFuseaction">
<cfset myFusebox.thisCircuit = "entry">
<cfset myFusebox.thisFuseaction = "category">
<cfif NOT structKeyExists(ATTRIBUTES, 'categoryID')>
<cfthrow type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category.">
</cfif>
<!--- do action="getRecent" --->
<cftry>
<cfset myFusebox.enterStackFrame() >
<cfif isDefined("ATTRIBUTES.categoryID")><cfset myFusebox.stack["ATTRIBUTES.categoryID"] = ATTRIBUTES.categoryID ></cfif>
<cfset ATTRIBUTES.categoryID = "#ATTRIBUTES.categoryID#" >
<cfset myFusebox.thisFuseaction = "getRecent">
<cfif not isDefined("ATTRIBUTES.categoryID")><cfset ATTRIBUTES.categoryID = "0" /></cfif>
<cfset REQUEST.entryService = myFusebox.getApplication().getApplicationData().servicefactory.getBean(beanName="EntryService")/> 
<cfif ATTRIBUTES.categoryID>
<cfset REQUEST.entries = "#REQUEST.entryService.getEntriesByCategoryID(ATTRIBUTES.categoryID)#" />
<cfelse>
<cfset REQUEST.entries = "#REQUEST.entryService.getEntries()#" />
</cfif>
<cfif structKeyExists(myFusebox.stack,"ATTRIBUTES.categoryID")><cfset ATTRIBUTES.categoryID = myFusebox.stack["ATTRIBUTES.categoryID"] ></cfif>
<cfif structKeyExists(myFusebox.stack,"ATTRIBUTES.categoryID")><cfset ATTRIBUTES.categoryID = myFusebox.stack["ATTRIBUTES.categoryID"] ><cfelse><cfset structDelete(ATTRIBUTES,"categoryID")></cfif>
<cfset myFusebox.leaveStackFrame() >
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
</cftry>
<cfset myFusebox.thisFuseaction = "category">
<cftry>
<cfsavecontent variable="REQUEST.content.body"><cfoutput><cfinclude template="../home/entry/dsp_entries.cfm"></cfoutput></cfsavecontent>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 15 and right(cfcatch.MissingFileName,15) is "dsp_entries.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse dsp_entries.cfm in circuit entry which does not exist (from fuseaction entry.category).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
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
</cftry>
<!--- do action="home.output" --->
<cftry>
<cfset myFusebox.thisPhase = "postprocessFuseactions">
<cfset myFusebox.thisCircuit = "home">
<cfset myFusebox.thisFuseaction = "output">
<cfif structKeyExists(REQUEST.content, 'rss')>
<cftry>
<cfoutput><cfinclude template="../home/../layout/lay_rss.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 21 and right(cfcatch.MissingFileName,21) is "../layout/lay_rss.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse ../layout/lay_rss.cfm in circuit home which does not exist (from fuseaction home.output).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
<cfelse>
<cftry>
<cfoutput><cfinclude template="../home/../layout/lay_main.cfm"></cfoutput>
<cfcatch type="missingInclude"><cfif len(cfcatch.MissingFileName) gte 22 and right(cfcatch.MissingFileName,22) is "../layout/lay_main.cfm">
<cfthrow type="fusebox.missingFuse" message="missing Fuse" detail="You tried to include a fuse ../layout/lay_main.cfm in circuit home which does not exist (from fuseaction home.output).">
<cfelse><cfrethrow></cfif></cfcatch></cftry>
</cfif>
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
</cftry>
<cfcatch><cfrethrow></cfcatch>
</cftry>
<cfsetting enablecfoutputonly="false" />

