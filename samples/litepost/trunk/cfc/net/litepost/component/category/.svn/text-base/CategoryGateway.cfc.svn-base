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

<cfcomponent displayname="CategoryGateway" output="false">
	
	<cfset variables.dsn = "" />
	<cfset variables.cacheTimeLong = CreateTimeSpan(0, 0, 30, 0)>
	<cfset variables.cacheTimeShort = CreateTimeSpan(0, 0, 20, 0)>
	
	<cffunction name="init" access="public" returntype="net.litepost.component.category.CategoryGateway" output="false">
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setDsn" returntype="void" access="public" output="false" hint="Dependency: datasource name">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	
	<cffunction name="getCategories" returntype="array" access="public" output="false">
		<cfset var qrySelect = 0 />
		<cfset var categories = ArrayNew(1) />
		<cfset var category = 0 />
		
		<cfset qrySelect = getCategoriesAsQuery() />
		
		<cfloop query="qrySelect">
			<cfset category = CreateObject('component','net.litepost.component.category.Category').init(
					qrySelect.categoryID,
					qrySelect.category
						) />
			<cfset ArrayAppend(categories, category) />
		</cfloop>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getCategoriesAsQuery" returntype="query" access="public" output="false">
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" datasource="#variables.dsn#">
		SELECT categoryID, category
		FROM categories ORDER BY category
		</cfquery>
		
		<cfreturn qrySelect />
	</cffunction>
	
	<cffunction name="getCategoriesWithCounts" returntype="array" access="public" output="false">
		<cfset var qrySelect = 0 />
		<cfset var categories = ArrayNew(1) />
		<cfset var category = 0 />
		
		<cfset qrySelect = getCategoriesWithCountsAsQuery() />
		
		<cfloop query="qrySelect">
			<cfset category = CreateObject('component','net.litepost.component.category.Category').init(
					qrySelect.categoryID,
					qrySelect.category,
					qrySelect.posts
						) />
			<cfset ArrayAppend(categories, category) />
		</cfloop>
		
		<cfreturn categories />
	</cffunction>
	
	<cffunction name="getCategoriesWithCountsAsQuery" returntype="query" access="public" output="false">
		<cfset var qrySelect = 0 />

		<cfquery name="qrySelect" datasource="#variables.dsn#">
		SELECT c.categoryID, c.category, COUNT(e.entryID) AS posts 
		FROM categories c LEFT OUTER JOIN entries e ON c.categoryID = e.categoryID 
		GROUP BY c.categoryID, c.category 
		ORDER BY c.category
		</cfquery>
		
		<cfreturn qrySelect />
	</cffunction>
</cfcomponent>