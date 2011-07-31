<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="bookmark" access="public" xmlns:cf="cf/" xmlns:cs="coldspring/">

	<!--
	
	PUBLIC
	
	-->
	
	<fuseaction name="addForm">
		<do action="outputForm">
			<parameter name="XFA.submit" value="bookmark.add" />
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
			<parameter name="title" value="Bookmark Added" />
			<parameter name="message" value="Your bookmark has been added" />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<fuseaction name="editForm" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'bookmarkID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Bookmark" detail="You must specify a valid bookmark." />
			</true>
		</if>
		<do action="get">
			<parameter name="ATTRIBUTES.id" value="#ATTRIBUTES.bookmarkID#" />
		</do>
		<if condition="REQUEST.bookmark.isNull()">
			<true>
				<cf:throw type="validation.NO_RECORDS_FOUND" message="Bookmark Not Found" detail="The specified bookmark could not be found." />
			</true>
		</if>
		<do action="outputForm">
			<parameter name="XFA.submit" value="bookmark.edit" />
			<parameter name="ATTRIBUTES.name" value="#REQUEST.bookmark.getName()#" />
			<parameter name="ATTRIBUTES.url" value="#REQUEST.bookmark.getUrl()#" />
			<parameter name="ATTRIBUTES.bookmarkID" value="#REQUEST.bookmark.getBookmarkID()#" />
		</do>
	</fuseaction>
	
	<fuseaction name="edit" roles="admin">
		<if condition="NOT structKeyExists(FORM, 'fieldnames')">
			<true>
				<relocate url="#REQUEST.myself##XFA.home#" />
			</true>
		</if>
		<do action="update" />
		<do action="home.message">
			<parameter name="title" value="Bookmark Updated" />
			<parameter name="message" value="The bookmark has been successfully updated." />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<fuseaction name="remove" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'bookmarkID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid bookmark" detail="You must specify a valid bookmark to remove." />
			</true>
		</if>
		<do action="delete">
			<parameter name="ATTRIBUTES.bookmarkID" value="#ATTRIBUTES.bookmarkID#" />
		</do>
		<do action="home.message">
			<parameter name="title" value="Bookmark Removed" />
			<parameter name="message" value="The bookmark has been removed" />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<!--
	
	PUBLIC
	
	-->

	<fuseaction name="outputForm" access="internal">
		<include template="dsp_bookmarkForm" contentvariable="REQUEST.content.body" />
	</fuseaction>	
	
	<fuseaction name="get" access="internal">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<!-- get bookmark -->
		<cs:get bean="bookmarkService" returnvariable="REQUEST.bookmarkService" />
		<set name="REQUEST.bookmark" value="#REQUEST.bookmarkService.getBookmarkById(ATTRIBUTES.id)#" />
	</fuseaction>
	
	<fuseaction name="getAll" access="internal">
		<!-- get all bookmarks -->
		<cs:get bean="bookmarkService" returnvariable="REQUEST.bookmarkService" />
		<set name="REQUEST.bookmarks" value="#REQUEST.bookmarkService.getBookmarks()#" />
	</fuseaction>
	
	<fuseaction name="create" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.name" value="" overwrite="false" />
		<set name="ATTRIBUTES.url" value="" overwrite="false" />
		<!-- get new bookmark -->
		<cs:get bean="bookmarkService" returnvariable="REQUEST.bookmarkService" />
		<set name="REQUEST.bookmark" value="#REQUEST.bookmarkService.getNewBookmark()#" />		
		<!-- set properties -->
		<invoke object="REQUEST.bookmark" method="setName">
			<argument name="name" value="#ATTRIBUTES.name#" />
		</invoke>
		<invoke object="REQUEST.bookmark" method="setUrl">
			<argument name="url" value="#ATTRIBUTES.url#" />
		</invoke>
		<!-- save bookmark -->
		<set name="REQUEST.bookmarkID" value="#REQUEST.bookmarkService.saveBookmark(REQUEST.bookmark)#" />
		<!-- update bookmark object -->
		<set name="REQUEST.bookmark" value="#REQUEST.bookmarkService.getBookmarkById(REQUEST.bookmarkID)#" />
	</fuseaction>
	
	<fuseaction name="update" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.bookmarkID" value="0" overwrite="false" />
		<set name="ATTRIBUTES.name" value="" overwrite="false" />
		<set name="ATTRIBUTES.url" value="" overwrite="false" />
		<!-- get bookmark -->
		<cs:get bean="bookmarkService" returnvariable="REQUEST.bookmarkService" />
		<set name="REQUEST.bookmark" value="#REQUEST.bookmarkService.getBookmarkById(ATTRIBUTES.bookmarkID)#" />
		<!-- set properties -->
		<invoke object="REQUEST.bookmark" method="setName">
			<argument name="name" value="#ATTRIBUTES.name#" />
		</invoke>
		<invoke object="REQUEST.bookmark" method="setUrl">
			<argument name="url" value="#ATTRIBUTES.url#" />
		</invoke>
		<!-- save bookmark -->
		<set name="REQUEST.bookmarkID" value="#REQUEST.bookmarkService.saveBookmark(REQUEST.bookmark)#" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.bookmarkID" value="0" overwrite="false" />
		<!-- delete bookmark -->
		<cs:get bean="bookmarkService" returnvariable="REQUEST.bookmarkService" />
		<invoke object="REQUEST.bookmarkService" method="removeBookmark">
			<argument name="bookmarkID" value="#ATTRIBUTES.bookmarkID#" />
		</invoke>
	</fuseaction>
	
	
</circuit>
