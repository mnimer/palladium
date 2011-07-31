<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="bookmark" access="public" xmlns:cf="cf/">

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
		<if condition="NOT REQUEST.qryBookmark.recordCount">
			<true>
				<cf:throw type="validation.NO_RECORDS_FOUND" message="Bookmark Not Found" detail="The specified bookmark could not be found." />
			</true>
		</if>
		<do action="outputForm">
			<parameter name="XFA.submit" value="bookmark.edit" />
			<parameter name="ATTRIBUTES.name" value="#REQUEST.qryBookmark.name[1]#" />
			<parameter name="ATTRIBUTES.url" value="#REQUEST.qryBookmark.url[1]#" />
			<parameter name="ATTRIBUTES.bookmarkID" value="#ATTRIBUTES.bookmarkID#" />
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
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<include template="qry_getBookmark" />
	</fuseaction>
	
	<fuseaction name="getAll" access="internal">
		<include template="qry_getBookmarks" />
	</fuseaction>
	
	<fuseaction name="create" access="internal" roles="admin">
		<include template="act_createBookmark" />
	</fuseaction>
	
	<fuseaction name="update" access="internal" roles="admin">
		<include template="act_updateBookmark" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" roles="admin">
		<set name="bookmarkID" value="0" overwrite="false" />
		<include template="act_deleteBookmark" />
	</fuseaction>
	
	
</circuit>
