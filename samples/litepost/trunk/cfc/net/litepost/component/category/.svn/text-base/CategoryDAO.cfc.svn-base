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

<cfcomponent displayname="CategoryDAO" output="false">
	
	<cfset variables.dsn = "" />
	
	<cffunction name="init" access="public" returntype="net.litepost.component.category.CategoryDAO" output="false">
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setDsn" returntype="void" access="public" output="false" hint="Dependency: datasource name">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn />
	</cffunction>
	<cffunction name="getDsn" returntype="string" access="public" output="false" hint="Dependency: datasource name">
		<cfreturn variables.dsn />
	</cffunction>
	
	<!--- dao methods --->
	<cffunction name="fetch" returntype="net.litepost.component.category.Category" access="public" output="false">
		<cfargument name="categoryID" type="numeric" required="true" />
		<cfset var category = CreateObject('component','net.litepost.component.category.Category').init() />
		<cfset var qrySelect = 0 />
		
		<cfquery name="qrySelect" maxrows="1" datasource="#variables.dsn#">
		SELECT categoryID, category
		FROM categories WHERE categoryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryID#"/>
		</cfquery>
		
		<cfif qrySelect.RecordCount LT 1>
			<!--- return an uninitialized category --->
			<cfreturn CreateObject('component','net.litepost.component.category.Category') />
		</cfif>
		
		<cfset category.setCategoryID(qrySelect.categoryID) />
		<cfset category.setCategory(qrySelect.category) />
		
		<cfreturn category />
		
	</cffunction>
	
	<cffunction name="save" returntype="numeric" access="public" output="false">
		<cfargument name="category" type="net.litepost.component.category.Category" required="true" />
		
		<cfif arguments.category.getCategoryID() GT 0>
			<cfset update(arguments.category)/>
			<cfreturn arguments.category.getCategoryID() />
		<cfelse>
			<cfreturn create(arguments.category)/>
		</cfif>		

	</cffunction>
	
	<cffunction name="remove" returntype="void" access="public" output="false">
		<cfargument name="categoryID" type="numeric" required="true" />
		
		<cfset var qryDelete = 0 />

		<!--- delete the record --->
		<cfquery name="qryDelete" datasource="#variables.dsn#">
		DELETE FROM categories 
		WHERE categoryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.categoryID#" />
		</cfquery>
	</cffunction>
	
	<cffunction name="create" returntype="numeric" access="private" output="false">
		<cfargument name="category" type="net.litepost.component.category.Category" required="true" />

		<cfset var qryInsert = 0 />
		<cfset var qrySelect = 0 />
		
		<!--- insert the record --->
		<cftransaction>
			<cfquery name="qryInsert" datasource="#variables.dsn#">
			INSERT INTO categories (category)
			VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategory()#" maxlength="255"/>)
			</cfquery>
			<cfquery name="qrySelect" datasource="#variables.dsn#">
				SELECT LAST_INSERT_ID() AS NewID
			</cfquery>
		</cftransaction>
		
		<cfreturn qrySelect.NewID />
		
	</cffunction>
	
	<cffunction name="update" returntype="void" access="private" output="false">
		<cfargument name="category" type="net.litepost.component.category.Category" required="true" />
		
		<cfset var qryInsert = 0 />

		<!--- update the record --->
		<cfquery name="qryUpdate" datasource="#variables.dsn#">
		UPDATE categories 
			SET category = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.category.getCategory()#" maxlength="255"/>
		WHERE categoryID = <cfqueryparam cfsqltype="cf_sql_integer" value="#category.getCategoryID()#" />
		</cfquery>
	</cffunction>
	
</cfcomponent>