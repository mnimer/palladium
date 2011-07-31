<!---
License:
Copyright (c) 2007, David Ross, Chris Scott, Kurt Wiersma, Sean Corfield, Peter J. Farrell

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0
  
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
		
$Id: ColdspringProperty.cfc,v 1.6 2007/08/29 22:43:49 pjf Exp $

Description:
A Mach-II property that provides easy ColdSpring integration with Mach-II applications.

Special thanks to GreatBizTools, LLC and Peter J. Farrell for donating the improvements 
to this integration component for Mach-II.

N.B.
Compatible with Mach-II 1.5.0 or higher.

Usage:
<property name="coldSpringProperty" type="coldspring.machii.ColdspringProperty">
	<parameters>
		<!-- Name of a Mach-II property name that will hold a reference to the ColdSpring beanFactory
			Default: 'coldspring.beanfactory.root' -->
		<parameter name="beanFactoryPropertyName" value="serviceFactory"/>

		<!-- Takes the path to the ColdSpring config file 
			(required) -->
		<parameter name="configFile" value="/path/to/services.xml"/>
		
		<!-- Flag to indicate whether supplied config path is relative (mapped) or absolute 
			Default: FALSE (absolute path) -->
		<parameter name="configFilePathIsRelative" value="true"/>
		
		<!-- Flag to indicate whether to resolve dependencies for listeners/filters/plugins 
			Default: FALSE -->
		<parameter name="resolveMachIIDependencies" value="false"/>
		
		<!-- Indicate a scope to pull in a parent bean factory into a child bean factory 
			 default: application -->
		<parameter name="parentBeanFactoryScope" value="application"/>
		
		<!-- Indicate a key to pull in a parent bean factory from the application scope
			Default: FALSE -->
		<parameter name="parentBeanFactoryKey" value="serviceFactory"/>
			
		<!-- Indicate whether or not to place the bean factory in the application scope 
			 Default: FALSE -->
		<parameter name="placeFactoryInApplicationScope" value="false" />

		<!-- Indicate whether or not to place the bean factory in the server scope 
			 Default: FALSE -->
		<parameter name="placeFactoryInServerScope" value="false" />
		
		<!-- Struct of bean names and corresponding Mach-II property names for injecting back into Mach-II
			Default: does nothing if struct is not defined -->
		<parameter name="beansToMachIIProperties">
			<struct>
				<key name="ColdSpringBeanName1" value="MachIIPropertyName1" />
				<key name="ColdSpringBeanName2" value="MachIIPropertyName2" />
			</struct>
		</parameter>
	</parameters>
</property>

The [beanFactoryPropertyName] parameter value is the name of the Mach-II property name 
that will hold a reference to the ColdSpring beanFactory. This parameter 
defaults to "coldspring.beanfactory.root" if not defined.

The [configFile] paramater value holds the path of the ColdSpring configuration file. The path 
can be an relative, ColdFusion mapped or absolute path. If you are using a relative or mapped
path, be sure to set the [configFilePathIsRelative] parameter to TRUE or the ColdSpring will
not find your configuration file.

The [configGilePathIsRelative] parameter value defines if the configure file is an relative
(including ColdFusion mapped) or absolute path. If you are using a relative or mapped
path, be sure to set the [configFilePathIsRelative] parameter to TRUE or the property will
not find your configuration file.
- TRUE (for relative or mapped configuration file paths)
- FALSE (for absolute configuration file paths)

The [resolveMachIIDependencies] parameter value indicates if the property to "automagically"
wire Mach-II listeners/filters/plugins/properties.  This parameter defaults to FALSE if not defined.
- TRUE (resolves all Mach-II dependencies)
- FALSE (does not resolve Mach-II dependencies)

The [parentBeanFactoryScope] parameter values defines which scope to pull in a parent bean 
factory. This parameter defaults to 'false' if not defined and indicates that a parent bean
factory does not need to be referenced.

The [parentBeanFactoryKey] parameter values defines a key to pull in a parent bean factory
from the scope specified in the [parentBeanFactoryKey] parameter.  This parameter defaults 
to 'false' if not defined and indicates that a parent bean factory does not need to be referenced.

The [placeFactoryInApplicationScope] parameter indicates whether or not to place the bean factory 
in the application scope.  This parameter is used to for setting your bean factory for use as a
parent.  The key that used is driven from the value from of the [beanFactoryPropertyName] parameter.
If the parent uses the same value for the beanFactoryPropertyName, the module name (e.g. "_account")
is append to the end of the key to eliminate namespace conflicts in the application scope.
This parameter defaults to 'false' if not defined and indicates that this bean factory should not
be placed in the application scope.

The [placeFactoryInServerScope] parameter indicates whether or not to place the bean factory 
in the server scope.  This parameter is used to for setting your bean factory for use as a
parent.  The key that used is driven from the value from of the [beanFactoryPropertyName] parameter.
If the parent uses the same value for the beanFactoryPropertyName, the module name (e.g. "_account")
is append to the end of the key to eliminate namespace conflicts in the server scope.
This parameter defaults to 'false' if not defined and indicates that this bean factory should not
be placed in the server scope.

The [beansToMachIIProperties] parameter holds a struct of bean names and corresponding
Mach-II property names. This parameter will inject the specified beans in the Mach-II property
manager as the bean factory has been loaded.  In the past, a seperate property has to be written 
to accomplish this task. This should be used for framework required "utility" objects that you 
want to be managed by ColdSpring such as UDF, i18n or session facade objects. Do not use this 
feature to inject your model objects into the Mach-II property manager.

Parent/Child Bean Factories Configuration for Use with Modules:

Base Mach-II Config File (i.e. Parent Factory)
<property name="ColdSpring" type="coldspring.machii.ColdspringProperty">
	<parameters>
		<parameter name="beanFactoryPropertyName" value="serviceFactory"/>
		<parameter name="configFile" value="/path/to/config/services.xml"/>
		<parameter name="configFilePathIsRelative" value="true"/>
		<parameter name="placeFactoryInApplicationScope" value="true"/>
		<parameter name="resolveMachIIDependencies" value="true"/>
</property>

You must put the parent bean factory in the application (or server scope) in order
for a module to inherit from a parent factory. This example put the parent factory
into the application.serviceFactory variable.

Account Module Config File (i.e. Child Factory):
<property name="ColdSpring" type="coldspring.machii.ColdspringProperty">
	<parameters>
		<parameter name="beanFactoryPropertyName" value="serviceFactory"/>
		<parameter name="configFile" value="/path/to/modules/account/config/services_account.xml"/>
		<parameter name="configFilePathIsRelative" value="true"/>
		<parameter name="resolveMachIIDependencies" value="true"/>
		<parameter name="placeFactoryInApplicationScope" value="true"/>
		<parameter name="parentBeanFactoryScope" value="application"/>
		<parameter name="parentBeanFactoryKey" value="serviceFactory"/>
	</parameters>
</property>

You are NOT required to put child factories into the application (or server scope) for
modules to inherit froma a parent factory. However, in this example the account module
puts this child factory into the application scope. Since the parent and module use the
same beanFactoryPropertyName, an application scope namespace conflict would occur - so
the Property appends the module name to the end. This factory would be located in 
application.serviceFactory_account variable.

--->
<cfcomponent
	name="ColdspringProperty"
	extends="MachII.framework.Property"
	hint="A Mach-II application property for easy ColdSpring integration"
	output="false">
	
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="I initialize this property during framework startup.">
		
		<!--- Default vars --->
		<cfset var bf = "" />
		<cfset var factoryKey = "" />
		<cfset var i = 0 />
		
		<!--- Get the Mach-II property manager (gets the a module's property manager if this is a module) --->
		<cfset var propertyManager = getPropertyManager() />
	
		<!--- Determine the location of the bean def xml file --->
		<cfset var serviceDefXmlLocation = "" />
		
		<!--- Get all properties to pass to bean factory
			Create a new struct instead of doing a direct assignment otherwise parent
			property managers will suddendly have properties from modules since
			structs are by passed by reference
		--->
		<cfset var defaultProperties = StructNew() />
		
		<!--- todo: Default attributes set via mach-ii params --->
		<cfset var defaultAttributes = StructNew() />
		
		<!--- Locating and storing bean factory (from properties/params) --->
		<cfset var bfUtils = CreateObject("component", "coldspring.beans.util.BeanFactoryUtils").init() />

		<cfset var parentBeanFactoryScope = getParameter("parentBeanFactoryScope", "application") />
		<cfset var parentBeanFactoryKey = getParameter("parentBeanFactoryKey", "") />

		<cfset var localBeanFactoryKey = getParameter("beanFactoryPropertyName", bfUtils.DEFAULT_FACTORY_KEY) />
		
		<!--- Get the config file path --->
		<cfif isParameterDefined("configFile")>
			<cfset serviceDefXmlLocation = getParameter("configFile") />
		<cfelse>
			<cfthrow type="ColdspringProperty.configFileParameterNotDefined"
				message="You must specify a parameter named 'configFile'." />
		</cfif>
		
		<!--- Get the properties from the current property manager --->
		<cfset StructAppend(defaultProperties, propertyManager.getProperties()) />
		
		<!--- Append the parent's default properties if we have a parent --->
		<cfif IsObject(getAppManager().getParent())>
			<cfset StructAppend(defaultProperties, propertyManager.getParent().getProperties(), false) />
		</cfif>		
		
		<!--- Evaluate any dynamic properties --->
		<cfloop collection="#defaultProperties#" item="i">
			<cfif IsSimpleValue(defaultProperties[i]) AND REFindNoCase("\${(.)*?}", defaultProperties[i])>
				<cfset defaultProperties[i] = Evaluate(Mid(defaultProperties[i], 3, Len(defaultProperties[i]) -3)) />
			</cfif>
		</cfloop>
		
		<!--- Create a new bean factory --->
		<cfset bf = CreateObject("component", "coldspring.beans.DefaultXmlBeanFactory").init(defaultAttributes, defaultProperties) />
		
		<!--- If necessary setup the parent bean factory using the new ApplicationContextUtils --->
		<cfif len(parentBeanFactoryKey) AND bfUtils.namedFactoryExists(parentBeanFactoryScope, parentBeanFactoryKey)>
			<cfset bf.setParent(bfUtils.getNamedFactory(parentBeanFactoryScope, parentBeanFactoryKey))/>
		</cfif>
		
		<!--- Expand path for relative and mapped config file paths --->
		<cfif getParameter("configFilePathIsRelative", false)>
			<cfset serviceDefXmlLocation = ExpandPath(serviceDefXmlLocation) />
		</cfif>
		
		<!--- Load the bean defs --->
		<cfset bf.loadBeansFromXmlFile(serviceDefXmlLocation, true) />

		<!--- Put a bean factory reference into Mach-II property manager --->
		<cfset setProperty("beanFactoryName", localBeanFactoryKey) />
		<cfset setProperty(localBeanFactoryKey, bf) />
		
		<!--- Figure out application/server key --->
		<cfset factoryKey = localBeanFactoryKey />
		
		<!--- Append the module the parent and child are using the same property name for the bean factory --->
		<cfif Len(getAppManager().getModuleName()) AND getAppManager().getParent().getPropertyManager().isPropertyDefined(localBeanFactoryKey)>
			<cfset factoryKey = factoryKey & "_" & getAppManager().getModuleName() />
		</cfif>
		
		<!--- Put a bean factory reference into the application or server scopes if required --->
		<cfif getParameter("placeFactoryInApplicationScope", false)>
			<cfset bfUtils.setNamedFactory("application", factoryKey, bf) />
		</cfif>
		<cfif getParameter("placeFactoryInServerScope", false)>
			<cfset bfUtils.setNamedFactory("server", factoryKey, bf) />
		</cfif>
		
		<!--- Resolve Mach-II dependences if required --->
		<cfif getParameter("resolveMachIIDependencies", false)>
			<cfset resolveDependencies() />
		</cfif>
		
		<!--- Place bean references into the Mach-II properties if required --->
		<cfif isParameterDefined("beansToMachIIProperties")>
			<cfif IsStruct(getParameter("beansToMachIIProperties"))>
				<cfset referenceBeansToMachIIProperties(getParameter("beansToMachIIProperties")) />
			<cfelse>
				<cfthrow type="ColdspringProperty.beansToMachIIPropertiesInvalidType"
					message="The value of a parameter named 'beansToMachIIProperties' must contain a struct." />
			</cfif>
		</cfif>
				
		<!--- Build the config files and hash --->
		<cfset setConfigFilePaths(buildConfigFilePaths(serviceDefXmlLocation)) />
		<cfset setLastReloadHash(getConfigFileReloadHash()) />
		<cfset setLastReloadDatetime(Now()) />
	</cffunction>
	
	<cffunction name="shouldReloadConfig" access="public" returntype="boolean" output="false"
		hint="Checks if the bean factory config file or any of its' imports have changed.">
		
		<cfset var result = false />
		
		<cfif CompareNoCase(getLastReloadHash(), getConfigFileReloadHash()) NEQ 0>
			<cfset result = true />
		</cfif>
		
		<cfreturn result />
	</cffunction>
	
	<!---
	PROTECTED FUNCTIONS
	--->
	<cffunction name="buildConfigFilePaths" access="private" returntype="array" output="false"
		hint="Builds an array of config file paths.">
		<cfargument name="baseConfigFilePath" type="string" required="true" />
		
		<cfset var configFiles = ArrayNew(1) />
		<cfset var imports = StructNew() />
		<cfset var i = "" />
		
		<!--- Add any imports by using the bean factory's built-in functionality --->
		<cfset getProperty(getProperty("beanFactoryName")).findImports(imports, arguments.baseConfigFilePath) />
		<!--- FindImports does not return a variable, but the data is available in the imports var via reference --->
		<cfloop collection="#imports#" item="i">
			<cfset ArrayAppend(configFiles, i) />
		</cfloop>
		
		<cfreturn configFiles />
	</cffunction>
	
	<cffunction name="getConfigFileReloadHash" access="private" returntype="string" output="false"
		hint="Get the current reload hash of the bean factory config file and imports files.  The hash is based on dateLastModified and size of the file.">

		<cfset var configFilePaths = getConfigFilePaths() />
		<cfset var directoryResults = "" />
		<cfset var hashableString = "" />
		<cfset var i = "" />

		<cfloop from="1" to="#ArrayLen(configFilePaths)#" index="i">
			<cfdirectory action="LIST" directory="#GetDirectoryFromPath(configFilePaths[i])#" 
				name="directoryResults" filter="#GetFileFromPath(configFilePaths[i])#" />
			<cfset hashableString = hashableString & directoryResults.dateLastModified & directoryResults.size />
		</cfloop>

		<cfreturn Hash(hashableString) />
	</cffunction>
	
	<cffunction name="resolveDependencies" access="private" returntype="void" output="false"
		hint="Resolves Mach-II dependencies.">
		
		<cfset var beanFactory = getProperty(getProperty("beanFactoryName")) />
		<cfset var targets = StructNew() />
		
		<cfset var targetObj = 0 />
		<cfset var i = 0 />
		
		<cfset var md = "" />
		<cfset var functionMd = "" />
		<cfset var j = 0 />
		
		<cfset var setterName = "" />
		<cfset var beanName = "" />
		<cfset var access = "" />
		
		<!--- Get listener/filter/plugin/property targets --->
		<cfset targets.data = ArrayNew(1) />
		<cfset getListeners(targets) />
		<cfset getFilters(targets) />
		<cfset getPlugins(targets) />
		<cfset getConfigurableProperties(targets) />
		
		<cfloop from="1" to="#ArrayLen(targets.data)#" index="i">
			<!--- Get this iteration target object for easy use --->
			<cfset targetObj = targets.data[i] />
			
			<!--- Look for autowirable collaborators for any SETTERS --->
			<cfset md = GetMetaData(targetObj) />
			
			<cfif StructKeyExists(md, "functions")>
				<cfloop from="1" to="#arraylen(md.functions)#" index="j">
					<cfset functionMd = md.functions[j] />
				
					<!--- first get the access type --->
					<cfif StructKeyExists(functionMd, "access")>
						<cfset access = functionMd.access />
					<cfelse>
						<cfset access = "public" />
					</cfif>
					
					<!--- if this is a 'real' setter --->
					<cfif Left(functionMd.name, 3) EQ "set" AND Arraylen(functionMd.parameters) EQ 1 AND access NEQ "private">
						
						<!--- look for a bean in the factory of the params's type --->	  
						<cfset setterName = Mid(functionMd.name, 4, Len(functionMd.name) - 3) />
						
						<!--- Get bean by setter name and if not found then get by type --->
						<cfif beanFactory.containsBean(setterName)>
							<cfset beanName = setterName />
						<cfelse>
							<cfset beanName = beanFactory.findBeanNameByType(functionMd.parameters[1].type) />
						</cfif>
						
						<!--- If we found a bean, put the bean by calling the target object's setter --->
						<cfif Len(beanName)>
							<cfinvoke component="#targetObj#" method="set#setterName#">
								<cfinvokeargument name="#functionMd.parameters[1].name#" value="#beanFactory.getBean(beanName)#"/>
							</cfinvoke>	
						</cfif>			  
					</cfif>
				</cfloop>		
			</cfif>
		</cfloop>
		
	</cffunction>
		
	<cffunction name="getListeners" access="private" returntype="void" output="false"
		hint="Gets the listener targets.">
		<cfargument name="targets" type="struct" required="true" />
		
		<cfset var listenerManager = getAppManager().getListenerManager() />
		<cfset var listenerNames = listenerManager.getListenerNames() />
		<cfset var i = 0 />
		
		<!--- Append each retrieved listener and its' invoker to the targets array (in struct) --->
		<cfloop from="1" to="#ArrayLen(listenerNames)#" index="i">
			<cfset ArrayAppend(targets.data, listenerManager.getListener(listenerNames[i])) />
		</cfloop>
	</cffunction>
		
	<cffunction name="getFilters" access="private" returntype="void" output="false"
		hint="Get the filter targets.">
		<cfargument name="targets" type="struct" required="true" />
		
		<cfset var filterManager = getAppManager().getFilterManager() />
		<cfset var filterNames = filterManager.getFilterNames() />
		<cfset var i = 0 />
		
		<!--- Append each retrieved filter to the targets array (in struct) --->
		<cfloop from="1" to="#ArrayLen(filterNames)#" index="i">
			<cfset ArrayAppend(targets.data, filterManager.getFilter(filterNames[i])) />
		</cfloop>
	</cffunction>
		
	<cffunction name="getPlugins" returntype="void" access="private" output="false"
		hint="Get the plugin targets.">
		<cfargument name="targets" type="struct" required="true" />
		
		<cfset var pluginManager = getAppManager().getPluginManager() />
		<cfset var pluginNames = pluginManager.getPluginNames() />
		<cfset var i = 0 />
		
		<!--- Append each retrieved plugin to the targets array (in struct) --->
		<cfloop from="1" to="#ArrayLen(pluginNames)#" index="i">
			<cfset ArrayAppend(targets.data, pluginManager.getPlugin(pluginNames[i])) />
		</cfloop>
	</cffunction>
	
	<cffunction name="getConfigurableProperties" returntype="void" access="private" output="false"
		hint="Get the configurable property targets.">
		<cfargument name="targets" type="struct" required="true" />
		
		<cfset var propertyManager = getAppManager().getPropertyManager() />
		<cfset var configurablePropertyNames = propertyManager.getConfigurablePropertyNames() />
		<cfset var i = 0 />
		
		<!--- Append each retrieved plugin to the targets array (in struct) --->
		<cfloop from="1" to="#ArrayLen(configurablePropertyNames)#" index="i">
			<cfset ArrayAppend(targets.data, propertyManager.getProperty(configurablePropertyNames[i])) />
		</cfloop>
	</cffunction>
	
	<cffunction name="referenceBeansToMachIIProperties" access="private" returntype="void" output="false"
		hint="Places references to ColdSpring managed beans into the Mach-II properties.">
		<cfargument name="beansToProperties" type="struct" required="true" />
		
		<cfset var beanFactory = getProperty(getProperty("beanFactoryName")) />
		<cfset var i = 0 />
		
		<!--- Inject the beans into the properties --->
		<cfloop collection="#arguments.beansToProperties#" item="i">
			<cfif beanFactory.containsBean(i)>
				<cfset setProperty(arguments.beansToProperties[i], beanFactory.getBean(i)) />
			</cfif>
		</cfloop>
	</cffunction>
	
	<!---
	ACCESSORS
	--->
	<cffunction name="setLastReloadHash" access="private" returntype="void" output="false">
		<cfargument name="lastReloadHash" type="string" required="true" />
		<cfset variables.instance.lastReloadHash = arguments.lastReloadHash />
	</cffunction>
	<cffunction name="getLastReloadHash" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lastReloadHash />
	</cffunction>
	
	<cffunction name="setLastReloadDatetime" access="private" returntype="void" output="false">
		<cfargument name="lastReloadDatetime" type="date" required="true" />
		<cfset variables.instance.lastReloadDatetime = arguments.lastReloadDatetime />
	</cffunction>
	<cffunction name="getLastReloadDatetime" access="public" returntype="date" output="false">
		<cfreturn variables.instance.lastReloadDatetime />
	</cffunction>
	
	<cffunction name="setConfigFilePaths" access="private" returntype="void" output="false">
		<cfargument name="configFilePaths" type="array" required="true" />
		<cfset variables.instance.configFilePaths = arguments.configFilePaths />
	</cffunction>
	<cffunction name="getConfigFilePaths" access="public" returntype="array" output="false">
		<cfreturn variables.instance.configFilePaths />
	</cffunction>

</cfcomponent>