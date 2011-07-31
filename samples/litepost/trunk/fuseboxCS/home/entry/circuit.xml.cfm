<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="entry" access="public" xmlns:cf="cf/" xmlns:cs="coldspring/">

	<!--
	
	PUBLIC
	
	-->

	<fuseaction name="recent">
		<do action="getRecent" />
		<include template="dsp_entries.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="rss">
		<cs:get bean="rssService" returnvariable="REQUEST.rssService" />
		<invoke object="REQUEST.rssService" method="getBlogRSS" returnvariable="REQUEST.content.rss">
			<argument name="numEntries" value="#APPLICATION.settings.blog.numOfEntries#" />
			<argument name="blogName" value="#APPLICATION.settings.blog.name#" />
			<argument name="blogURL" value="#APPLICATION.settings.blog.url#" />
			<argument name="blogDescription" value="#APPLICATION.settings.blog.description#" />
			<argument name="blogLanguage" value="#APPLICATION.settings.blog.language#" />
			<argument name="generator" value="#APPLICATION.settings.name#" />
			<argument name="authorEmail" value="#APPLICATION.settings.blog.email.author#" />
			<argument name="webmasterEmail" value="#APPLICATION.settings.blog.email.webmaster#" />
			<argument name="eventParameter" value="fuseaction"/>
			<argument name="eventLocation" value="entry.display" />
		</invoke>
	</fuseaction>
	
	<fuseaction name="rssCategory">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'categoryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
			</true>
		</if>
		<cs:get bean="rssService" returnvariable="REQUEST.rssService" />
		<invoke object="REQUEST.rssService" method="getCategoryRSS" returnvariable="REQUEST.content.rss">
			<argument name="categoryID" value="#ATTRIBUTES.categoryID#" />
			<argument name="categoryName" value="" />
			<argument name="blogName" value="#APPLICATION.settings.blog.name#" />
			<argument name="blogURL" value="#APPLICATION.settings.blog.url#" />
			<argument name="blogDescription" value="#APPLICATION.settings.blog.description#" />
			<argument name="blogLanguage" value="#APPLICATION.settings.blog.language#" />
			<argument name="generator" value="#APPLICATION.settings.name#" />
			<argument name="authorEmail" value="#APPLICATION.settings.blog.email.author#" />
			<argument name="webmasterEmail" value="#APPLICATION.settings.blog.email.webmaster#" />
			<argument name="eventParameter" value="fuseaction"/>
			<argument name="eventLocation" value="entry.display" />
		</invoke>
	</fuseaction>
	
	<fuseaction name="category">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'categoryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
			</true>
		</if>
		<do action="getRecent">
			<parameter name="ATTRIBUTES.categoryID" value="#ATTRIBUTES.categoryID#" />
		</do>
		<include template="dsp_entries.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="display">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'entryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Entry" detail="You must specify a valid entry." />
			</true>
		</if>
		<do action="entry.get">
			<parameter name="ATTRIBUTES.id" value="#ATTRIBUTES.entryID#" />
		</do>
		<do action="comment.get">
			<parameter name="ATTRIBUTES.id" value="#ATTRIBUTES.entryID#" />
		</do>
		<xfa name="edit" value="editForm" />
		<xfa name="submit" value="comment.add" />
		<xfa name="remove" value="remove" />
		<xfa name="removeComment" value="comment.remove" />
		<include template="dsp_entry.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="addForm">
		<do action="outputForm">
			<parameter name="XFA.submit" value="entry.add" />
		</do>
	</fuseaction>
	
	<fuseaction name="add">
		<if condition="NOT structKeyExists(FORM, 'fieldnames')">
			<true>
				<relocate url="#REQUEST.myself##XFA.home#" />
			</true>
		</if>
		<do action="create" />
		<do action="home.message">
			<parameter name="title" value="Entry Created" />
			<parameter name="message" value="You entry has been successfully posted." />
			<parameter name="forward" value="entry.display&amp;entryID=#REQUEST.entry.getEntryID()#" />
		</do>
	</fuseaction>

	<fuseaction name="editForm" role="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'entryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Entry" detail="You must specify a valid entry." />
			</true>
		</if>
		<do action="get">
			<parameter name="ATTRIBUTES.id" value="#ATTRIBUTES.entryID#" />
		</do>
		<if condition="REQUEST.entry.isNull()">
			<true>
				<cf:throw type="validation.NO_RECORDS_FOUND" message="Entry Not Found" detail="The specified entry could not be found." />
			</true>
		</if>
		<do action="outputForm">
			<parameter name="XFA.submit" value="entry.edit" />
			<parameter name="ATTRIBUTES.title" value="#REQUEST.entry.getTitle()#" />
			<parameter name="ATTRIBUTES.body" value="#REQUEST.entry.getBody()#" />
			<parameter name="ATTRIBUTES.categoryID" value="#REQUEST.entry.getCategoryID()#" />
		</do>
	</fuseaction>
	
	<fuseaction name="edit">
		<if condition="NOT structKeyExists(FORM, 'fieldnames')">
			<true>
				<relocate url="#REQUEST.myself##XFA.home#" />
			</true>
		</if>
		<do action="update" />
		<do action="home.message">
			<parameter name="title" value="Entry Updated" />
			<parameter name="message" value="You entry has been successfully updated." />
			<parameter name="forward" value="entry.display&amp;entryID=#REQUEST.entry.getEntryID()#" />
		</do>
	</fuseaction>
	
	<fuseaction name="remove" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'entryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Entry" detail="You must specify a valid entry to remove." />
			</true>
		</if>
		<do action="delete">
			<parameter name="ATTRIBUTES.id" value="#ATTRIBUTES.entryID#" />
		</do>
		<do action="home.message">
			<parameter name="title" value="Entry Removed" />
			<parameter name="message" value="The entry has been removed" />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<!--
	
	PRIVATE
	
	-->
	
	<fuseaction name="outputForm" access="internal">
		<do action="category.getAll" />
		<include template="dsp_entryForm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="get" access="internal">
		<!-- passed parameters -->
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<!-- get entry -->
		<cs:get bean="EntryService" returnvariable="REQUEST.entryService" />
		<set name="REQUEST.entry" value="#REQUEST.entryService.getEntryByID(ATTRIBUTES.id)#" />
	</fuseaction>

	<fuseaction name="getRecent" access="internal">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.categoryID" value="0" overwrite="false" />
		<!-- get entries -->
		<cs:get bean="EntryService" returnvariable="REQUEST.entryService" />
		<if condition="ATTRIBUTES.categoryID">
			<true>
				<set name="REQUEST.entries" value="#REQUEST.entryService.getEntriesByCategoryID(ATTRIBUTES.categoryID)#" />
			</true>
			<false>
				<set name="REQUEST.entries" value="#REQUEST.entryService.getEntries()#" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="create" access="internal" role="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.categoryID" value="0" overwrite="false" />
		<set name="ATTRIBUTES.title" value="" overwrite="false" />
		<set name="ATTRIBUTES.body" value="" overwrite="false" />
		<!-- create entry -->
		<cs:get bean="EntryService" returnvariable="REQUEST.entryService" />
		<set name="REQUEST.entry" value="#REQUEST.entryService.getNewEntry()#" />
		<!-- set properties -->
		<invoke object="REQUEST.entry" method="setTitle">
			<argument value="#ATTRIBUTES.title#" />
		</invoke>
		<invoke object="REQUEST.entry" method="setBody">
			<argument value="#ATTRIBUTES.body#" />
		</invoke>
		<invoke object="REQUEST.entry" method="setCategoryID">
			<argument value="#ATTRIBUTES.categoryID#" />
		</invoke>
		<!-- save entry -->
		<set name="REQUEST.entryID" value="#REQUEST.entryService.saveEntry(REQUEST.entry)#" />
		<!-- update entry object -->
		<set name="REQUEST.entry" value="#REQUEST.entryService.getEntryByID(REQUEST.entryID)#" />
	</fuseaction>
	
	<fuseaction name="update" access="internal" role="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.entryID" value="0" overwrite="false" />
		<set name="ATTRIBUTES.categoryID" value="0" overwrite="false" />
		<set name="ATTRIBUTES.title" value="" overwrite="false" />
		<set name="ATTRIBUTES.body" value="" overwrite="false" />
		<!-- get entry -->
		<cs:get bean="entryService" returnvariable="REQUEST.entryService" />
		<set name="REQUEST.entry" value="#REQUEST.entryService.getEntryByID(ATTRIBUTES.entryID)#" />
		<!-- set properties -->
		<invoke object="REQUEST.entry" method="setTitle">
			<argument value="#ATTRIBUTES.title#" />
		</invoke>
		<invoke object="REQUEST.entry" method="setBody">
			<argument value="#ATTRIBUTES.body#" />
		</invoke>
		<invoke object="REQUEST.entry" method="setCategoryID">
			<argument value="#ATTRIBUTES.categoryID#" />
		</invoke>
		<!-- save entry -->
		<invoke object="REQUEST.entryService" method="saveEntry" returnvariable="REQUEST.entryID">
			<argument value="#REQUEST.entry#" />
		</invoke>
		<!-- update entry object -->
		<set name="REQUEST.entry" value="#REQUEST.entryService.getEntryByID(REQUEST.entryID)#" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" role="admin">
		<!-- passed parameters -->
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<!-- delete entry -->
		<cs:get bean="EntryService" returnvariable="REQUEST.entryService" />
		<invoke object="REQUEST.entryService" method="removeEntry">
			<argument value="#ATTRIBUTES.id#" />
		</invoke>
	</fuseaction>

</circuit>
