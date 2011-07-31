<!--- 
	  
  Copyright (c) 2006, Chris Scott, Matt Woodward, Adam Wayne Lehman, Dave Ross
  All rights reserved.
	
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
       http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  $Id$

--->
 
<cfcomponent displayname="CategoryService" 
			extends="net.litepost.service.CategoryService" 
			hint="Service for Categories">

	<cffunction name="init" returntype="net.litepost.component.category.CategoryService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setCategoryDAO" returntype="void" access="public" output="false" hint="Dependency: CategoryDAO">
		<cfargument name="categoryDAO" type="net.litepost.component.category.CategoryDAO" required="true"/>
		<cfset variables.categoryDAO = arguments.categoryDAO />
	</cffunction>
	
	<cffunction name="setCategoryGateway" returntype="void" access="public" output="false" hint="Dependency: CategoryGateway">
		<cfargument name="categoryGateway" type="net.litepost.component.category.CategoryGateway" required="true"/>
		<cfset variables.categoryGateway = arguments.categoryGateway />
	</cffunction>
	
	<cffunction name="setEntryService" returntype="void" access="public" output="false" hint="Dependency: EntryService">
		<cfargument name="entryService" type="net.litepost.component.entry.EntryService" required="true" />
		<cfset variables.entryService = arguments.entryService />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getCategories" returntype="array" access="public" output="false">
		<cfreturn variables.categoryGateway.getCategories() />
	</cffunction>
	
	<cffunction name="getCategoriesAsQuery" returntype="query" access="public" output="false">
		<cfreturn variables.categoryGateway.getCategoriesAsQuery() />
	</cffunction>
	
	<cffunction name="getCategoriesWithCounts" returntype="array" access="public" output="false">
		<cfreturn variables.categoryGateway.getCategoriesWithCounts() />
	</cffunction>
	
	<cffunction name="getCategoriesWithCountsAsQuery" returntype="query" access="public" output="false">
		<cfreturn variables.categoryGateway.getCategoriesWithCountsAsQuery() />
	</cffunction>
	
	<cffunction name="getCategoryByID" returntype="net.litepost.component.category.Category" access="public" output="false">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfreturn variables.categoryDAO.fetch(arguments.categoryID) />
	</cffunction>
	
	<cffunction name="getNewCategory" returntype="net.litepost.component.category.Category" output="false" access="public" hint="Returns an empty category.">
		<cfset var category = createObject('component', 'net.litepost.component.category.Category').init() />
		<cfreturn category />
	</cffunction>
	
	<cffunction name="saveCategory" returntype="numeric" access="public" output="false">
		<cfargument name="category" type="net.litepost.component.category.Category" required="true" />
		<cfreturn variables.categoryDAO.save(arguments.category) />
	</cffunction>
	
	<cffunction name="removeCategory" returntype="void" access="public" output="false">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfset variables.entryService.resetEntryCategories(arguments.categoryID) />
		<cfset variables.categoryDAO.remove(arguments.categoryID) />
	</cffunction>

</cfcomponent>