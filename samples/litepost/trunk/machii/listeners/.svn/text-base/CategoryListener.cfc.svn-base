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

  $Id:  $

--->

<cfcomponent 
	displayname="CategoryListener" 
	output="false" 
	extends="MachII.framework.Listener" 
	hint="The Category listener for Litepost">

	<cffunction name="configure" returntype="void" access="public" output="false" hint="Configures this listener; called automatically by Mach-II">
		<!--- don't need to do anything here --->
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setCategoryService" returntype="void" access="public" output="false" hint="Dependency: CategoryService">
		<cfargument name="categoryService" type="net.litepost.component.category.CategoryService" required="true" />
		<cfset variables.categoryService = arguments.categoryService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getCategory" returntype="net.litepost.component.category.Category" access="public" output="false" 
			hint="Returns a category bean using the category ID in the event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var category = variables.categoryService.getCategoryByID(arguments.event.getArg("categoryID", 0)) />
		
		<cfif category.isNull()>
			<cfset category.init() />
		</cfif>
		
		<cfreturn category />
	</cffunction>
	
	<cffunction name="getCategories" returntype="array" access="public" output="false" 
			hint="Returns an array of categories">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.categoryService.getCategories() />
	</cffunction>
	
	<cffunction name="getCategoriesAsQuery" returntype="query" access="public" output="false" 
			hint="Returns a query object containing categories">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.categoryService.getCategoriesAsQuery() />
	</cffunction>
	
	<cffunction name="getCategoriesWithCounts" returntype="array" access="public" output="false" 
			hint="Returns an array of categories including the count of entries in each category">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.categoryService.getCategoriesWithCounts() />
	</cffunction>
	
	<cffunction name="getCategoriesWithCountsAsQuery" returntype="query" access="public" output="false" 
			hint="Returns a query object of categories with counts">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.categoryService.getCategoriesWithCountsAsQuery() />
	</cffunction>
	
	<cffunction name="processCategoryForm" returntype="void" access="public" output="false" 
			hint="Processes the category form and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "success" />
		<cfset var message = "The category was saved." />
		
		<cfif arguments.event.isArgDefined("exitEvent")>
			<cfset exitEvent = arguments.event.getArg("exitEvent") />
		</cfif>
		
		<cftry>
			<cfset variables.categoryService.saveCategory(arguments.event.getArg("category")) />
			<cfcatch type="any">
				<cfset exitEvent = "failure" />
				<cfset message = "An error occurred: #cfcatch.detail#" />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteCategory" returntype="void" access="public" output="false" 
			hint="Deletes a category">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var message = "The category was deleted." />
		
		<cftry>
			<cfset variables.categoryService.removeCategory(arguments.event.getArg("categoryID")) />
			<cfcatch type="any">
				<cfset message = "An error occurred: #cfcatch.detail#" />
			</cfcatch>
		</cftry>
		
		<cfset arguments.event.setArg("message", message) />
	</cffunction>
</cfcomponent>