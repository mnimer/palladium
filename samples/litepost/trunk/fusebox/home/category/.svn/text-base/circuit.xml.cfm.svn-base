<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="category" access="public" xmlns:cf="cf/">

	<!--
	
	PUBLIC
	
	-->
	
	<fuseaction name="addForm">
		<do action="outputForm">
			<parameter name="XFA.submit" value="category.add" />
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
			<parameter name="title" value="Category Added" />
			<parameter name="message" value="Your category has been added" />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<fuseaction name="editForm" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'categoryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category." />
			</true>
		</if>
		<do action="get">
			<parameter name="ATTRIBUTES.id" value="#ATTRIBUTES.categoryID#" />
		</do>
		<if condition="NOT REQUEST.qryCategory.recordCount">
			<true>
				<cf:throw type="validation.NO_RECORDS_FOUND" message="Category Not Found" detail="The specified category could not be found." />
			</true>
		</if>
		<do action="outputForm">
			<parameter name="XFA.submit" value="category.edit" />
			<parameter name="ATTRIBUTES.category" value="#REQUEST.qryCategory.category[1]#" />
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
			<parameter name="title" value="Category Updated" />
			<parameter name="message" value="The category has been successfully updated." />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<fuseaction name="remove" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'categoryID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Category" detail="You must specify a valid category to remove." />
			</true>
		</if>
		<do action="delete">
			<parameter name="ATTRIBUTES.categoryID" value="#ATTRIBUTES.categoryID#" />
		</do>
		<do action="home.message">
			<parameter name="title" value="Category Removed" />
			<parameter name="message" value="The category has been removed" />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<!--
	
	PUBLIC
	
	-->

	<fuseaction name="outputForm" access="internal">
		<include template="dsp_categoryForm" contentvariable="REQUEST.content.body" />
	</fuseaction>	
	
	<fuseaction name="get" access="internal">
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<include template="qry_getCategory" />
	</fuseaction>
	
	<fuseaction name="getAll" access="internal">
		<include template="qry_getCategories" />
	</fuseaction>
	
	<fuseaction name="create" access="internal" roles="admin">
		<include template="act_createCategory" />
	</fuseaction>
	
	<fuseaction name="update" access="internal" roles="admin">
		<include template="act_updateCategory" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" roles="admin">
		<set name="categoryID" value="0" overwrite="false" />
		<include template="act_deleteCategory" />
	</fuseaction>
	
	
</circuit>
