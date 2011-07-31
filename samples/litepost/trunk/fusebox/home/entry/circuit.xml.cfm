<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="entry" access="public" xmlns:cf="cf/">

	<!--
	
	PUBLIC
	
	-->

	<fuseaction name="recent">
		<do action="getRecent" />
		<include template="dsp_entries.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="rss">
		<do action="getRecent" />
		<include template="dsp_entries_rss.cfm" contentvariable="REQUEST.content.rss" />
	</fuseaction>
	
	<fuseaction name="rssCategory">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'categoryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
			</true>
		</if>
		<do action="getRecent">
			<parameter name="ATTRIBUTES.categoryID" value="#ATTRIBUTES.categoryID#" />
		</do>
		<include template="dsp_entries_rss.cfm" contentvariable="REQUEST.content.rss" />
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
			<parameter name="forward" value="entry.display&amp;entryID=#REQUEST.qryEntry.newID[1]#" />
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
		<if condition="NOT REQUEST.qryEntry.recordCount">
			<true>
				<cf:throw type="validation.NO_RECORDS_FOUND" message="Entry Not Found" detail="The specified entry could not be found." />
			</true>
		</if>
		<do action="outputForm">
			<parameter name="XFA.submit" value="entry.edit" />
			<parameter name="ATTRIBUTES.title" value="#REQUEST.qryEntry.title[1]#" />
			<parameter name="ATTRIBUTES.body" value="#REQUEST.qryEntry.body[1]#" />
			<parameter name="ATTRIBUTES.categoryID" value="#REQUEST.qryEntry.categoryID[1]#" />
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
			<parameter name="forward" value="entry.display&amp;entryID=#ATTRIBUTES.entryID#" />
		</do>
	</fuseaction>
	
	<fuseaction name="remove" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'entryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Entry" detail="You must specify a valid entry to remove." />
			</true>
		</if>
		<do action="delete">
			<parameter name="ATTRIBUTES.entryID" value="#ATTRIBUTES.entryID#" />
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
		<include template="qry_getEntry" />
	</fuseaction>

	<fuseaction name="getRecent" access="internal">
		<include template="qry_getEntries" />
	</fuseaction>
	
	<fuseaction name="create" access="internal" role="admin">
		<include template="act_createEntry" />
	</fuseaction>
	
	<fuseaction name="update" access="internal" role="admin">
		<include template="act_updateEntry" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" role="admin">
		<include template="act_deleteEntry" />
	</fuseaction>

</circuit>
