<cfcomponent displayname="SimpleFactoryTests" 
			hint="test factory bean methods" 
			extends="org.cfcunit.framework.TestCase">
	
	<cffunction name="setUp" access="private" returntype="void" output="false">
		<cfset var path = GetDirectoryFromPath(getMetaData(this).path) />
		<cfset var bf = 0 />
		<cfset var bean = 0 />
		
		<cfset variables.sys = CreateObject('java','java.lang.System') />
	
		<cfset variables.sys.out.println("Loading bean factory...") />
		<!--- create a new bean factory --->
		<cfset bf = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
		<!--- load the bean defs --->
		<cfset bf.loadBeansFromXmlFile(path&'/litepost-services.xml')/>
		
		<cfset variables.sys.out.println("Loading all services") />
		<!--- make sure we can load the services --->
		<cfset variables.sys.out.println("entryService...") />
		<cfset bean = bf.getBean("entryService") />
		<cfset variables.sys.out.println("commentService...") />
		<cfset bean = bf.getBean("commentService") />
		<cfset variables.sys.out.println("categoryService...") />
		<cfset bean = bf.getBean("categoryService") />
		<cfset variables.sys.out.println("bookmarkService...") />
		<cfset bean = bf.getBean("bookmarkService") />
		
		
		
	</cffunction>
	
	<cffunction name="testNothing" access="public" returntype="void" output="false">
		<cfset assertTrue(true)/>
	</cffunction>
	
</cfcomponent>