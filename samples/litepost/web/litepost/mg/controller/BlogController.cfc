<!--
	  
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

	$Id: BlogController.cfc 125 2006-12-15 02:06:30Z Chris.Scott.One $
-->

<cfcomponent displayname="BlogController" 
			 hint="Main controller for all blog related things" 
			 extends="ModelGlue.Core.Controller" 
			 output="false">
			 
	<cffunction name="Init" access="Public" returnType="litepost.mg.controller.BlogController" output="false" 
				hint="I build a new BlogController">
		<cfargument name="ModelGlue" required="true" type="ModelGlue.ModelGlue" />
		<cfargument name="InstanceName" required="true" type="string" />
		<cfset super.Init(arguments.ModelGlue) />
		<cfreturn this />
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setBookmarkService" returntype="void" access="public" output="false" hint="Dependency: BookmarkService">
		<cfargument name="bookmarkService" type="net.litepost.service.BookmarkService" required="true" />
		<cfset variables.bookmarkService = arguments.bookmarkService />
	</cffunction>

	<cffunction name="setCategoryService" returntype="void" access="public" output="false" hint="Dependency: CategoryService">
		<cfargument name="categoryService" type="net.litepost.service.CategoryService" required="true" />
		<cfset variables.categoryService = arguments.categoryService />
	</cffunction>
	
	<cffunction name="setEntryService" returntype="void" access="public" output="false" hint="Dependency: EntryService">
		<cfargument name="entryService" type="net.litepost.service.EntryService" required="true" />
		<cfset variables.entryService = arguments.entryService />
	</cffunction>
	
	<cffunction name="setCommentService" returntype="void" access="public" output="false" hint="Dependency: CommentService">
		<cfargument name="commentService" type="net.litepost.service.CommentService" required="true" />
		<cfset variables.commentService = arguments.commentService />
	</cffunction>
	
	<!--- main controller methods --->
	<cffunction name="getBookmarks" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var bookmarks = variables.bookmarkService.getBookmarks() />
		<cfset arguments.event.SetValue("bookmarks", bookmarks) />
		
	</cffunction>
	
	<cffunction name="getCategories" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var categories = variables.categoryService.getCategoriesWithCounts() />
		<cfset arguments.event.SetValue("categories", categories) />
		
	</cffunction>
	
	<cffunction name="getEntries" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var categoryID = arguments.event.getValue("categoryID",0) />
		<cfset var entries = 0 />
		
		<cfif categoryID GT 0>
			<cfset entries = variables.entryService.getEntriesByCategoryID(categoryID) />
		<cfelse>
			<cfset entries = variables.entryService.getEntries() />
		</cfif>
		
		<cfset arguments.event.SetValue("entries", entries) />
		
	</cffunction>
	
	<cffunction name="getEntryWithComments" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var entryID = arguments.event.getValue("entryID",0) />
		<cfset var entry = variables.entryService.getEntryByID(entryID, true) />
		
		<cfif entry.isNull()>
			<cfset arguments.event.forward("home") />
		<cfelse>
			<cfset arguments.event.SetValue("entry", entry) />
		</cfif>
		
	</cffunction>
	
	<cffunction name="getEntry" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var entryID = arguments.event.getValue("entryID",0) />
		<cfset var entry = variables.entryService.getEntryByID(entryID, false) />
		
		<cfif entry.isNull()>
			<cfset arguments.event.forward("home") />
		<cfelse>
			<cfset arguments.event.SetValue("entryBean", entry) />
		</cfif>
		
	</cffunction>
	
	<cffunction name="getEntryBean" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var entryBean = arguments.event.makeEventBean("net.litepost.component.entry.Entry") />
		<cfset arguments.event.SetValue("entryBean", entryBean) />
		
	</cffunction>
	
	<cffunction name="saveEntry" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var entryBean = arguments.event.makeEventBean("net.litepost.component.entry.Entry") />
		<!--- validate the bean, add result based on validation--->
		<cfif entryBean.validate()>
			<cfset variables.entryService.saveEntry(entryBean) />
			<cfset arguments.event.addResult("goHome") />
		<cfelse>
			<cfset arguments.event.SetValue("message", "Please complete entry form!") />
			<cfset arguments.event.SetValue("entryBean", entryBean) />
			<cfset arguments.event.addResult("goEntryForm") />
		</cfif>
		
	</cffunction>
	
	<cffunction name="getCommentBean" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var commentBean = arguments.event.makeEventBean("net.litepost.component.comment.Comment") />
		<cfset arguments.event.SetValue("commentBean", commentBean) />
		
	</cffunction>
	
	<cffunction name="saveComment" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var commentBean = arguments.event.makeEventBean("net.litepost.component.comment.Comment") />
		<!--- validate the bean, add result based on validation--->
		<cfif commentBean.validate()>
			<cfset variables.commentService.saveComment(commentBean) />
			<cfset arguments.event.addResult("goHome") />
		<cfelse>
			<cfset arguments.event.SetValue("message", "Please complete comments form!") />
			<cfset arguments.event.addResult("goComments") />
		</cfif>
		
	</cffunction>
	
	<cffunction name="getCategoryBean" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var categoryBean = arguments.event.makeEventBean("net.litepost.component.category.Category") />
		<cfset arguments.event.SetValue("categoryBean", categoryBean) />
		
	</cffunction>
	
	<cffunction name="getCategory" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var categoryID = arguments.event.getValue("categoryID",0) />
		<cfset var category = variables.categoryService.getCategoryByID(categoryID) />
		
		<cfif category.isNull()>
			<cfset arguments.event.forward("home") />
		<cfelse>
			<cfset arguments.event.SetValue("categoryBean", category) />
		</cfif>
		
	</cffunction>
	
	<cffunction name="saveCategory" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var categoryBean = arguments.event.makeEventBean("net.litepost.component.category.Category") />
		<!--- validate the bean, add result based on validation--->
		<cfif categoryBean.validate()>
			<cfset variables.categoryService.saveCategory(categoryBean) />
			<cfset arguments.event.addResult("goHome") />
		<cfelse>
			<cfset arguments.event.SetValue("message", "Please complete comments form!") />
			<cfset arguments.event.SetValue("categoryBean", categoryBean) />
			<cfset arguments.event.addResult("goCategoryForm") />
		</cfif>
		
	</cffunction>
	
	
	<!--- methods for editting bookmarks --->
	<cffunction name="getBookmarkBean" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var bookmarkBean = arguments.event.makeEventBean("net.litepost.component.bookmark.Bookmark") />
		<cfset arguments.event.SetValue("bookmarkBean", bookmarkBean) />
		
	</cffunction>
	
	<cffunction name="getBookmark" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var bookmarkID = arguments.event.getValue("bookmarkID",0) />
		<cfset var bookmark = variables.bookmarkService.getBookmarkByID(bookmarkID) />
		
		<cfif bookmark.isNull()>
			<cfset arguments.event.forward("home") />
		<cfelse>
			<cfset arguments.event.SetValue("bookmarkBean", bookmark) />
		</cfif>
		
	</cffunction>
	
	<cffunction name="saveBookmark" access="public" returntype="void" output="false">
		<cfargument name="event" type="ModelGlue.Core.Event" required="true">
		
		<cfset var bookmarkBean = arguments.event.makeEventBean("net.litepost.component.bookmark.Bookmark") />
		<!--- validate the bean, add result based on validation--->
		<cfif bookmarkBean.validate()>
			<cfset variables.bookmarkService.saveBookmark(bookmarkBean) />
			<cfset arguments.event.addResult("goHome") />
		<cfelse>
			<cfset arguments.event.SetValue("message", "Please complete comments form!") />
			<cfset arguments.event.SetValue("bookmarkBean", bookmarkBean) />
			<cfset arguments.event.addResult("goBookmarkForm") />
		</cfif>
		
	</cffunction>
		
</cfcomponent>