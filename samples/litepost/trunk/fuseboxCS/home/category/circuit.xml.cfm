<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="category" access="public" xmlns:cf="cf/" xmlns:cs="coldspring/">

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
		<if condition="REQUEST.category.isNull()">
			<true>
				<cf:throw type="validation.NO_RECORDS_FOUND" message="Category Not Found" detail="The specified category could not be found." />
			</true>
		</if>
		<do action="outputForm">
			<parameter name="XFA.submit" value="category.edit" />
			<parameter name="ATTRIBUTES.category" value="#REQUEST.category.getCategory()#" />
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
		<!-- passed arguments -->
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<!-- get category -->
		<cs:get bean="categoryService" returnvariable="REQUEST.categoryService" />
		<invoke object="REQUEST.categoryService" method="getCategoryByID" returnvariable="REQUEST.category">
			<argument name="categoryID" value="#ATTRIBUTES.id#" />
		</invoke>
	</fuseaction>
	
	<fuseaction name="getAll" access="internal">
		<cs:get bean="categoryService" returnvariable="REQUEST.categoryService" />
		<set name="REQUEST.categories" value="#REQUEST.categoryService.getCategoriesWithCounts()#" />
	</fuseaction>
	
	<fuseaction name="create" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.category" value="" overwrite="false" />
		<!-- get category -->
		<cs:get bean="categoryService" returnvariable="REQUEST.categoryService" />
		<set name="REQUEST.category" value="#REQUEST.categoryService.getNewCategory()#" />
		<!-- set properties -->
		<invoke object="REQUEST.category" method="setCategory">
			<argument name="category" value="#ATTRIBUTES.category#" />
		</invoke>
		<!-- save category -->
		<set name="REQUEST.categoryID" value="#REQUEST.categoryService.saveCategory(REQUEST.category)#" />
		<!-- update category object -->
		<set name="REQUEST.category" value="#REQUEST.categoryService.getCategoryByID(REQUEST.categoryID)#" />
	</fuseaction>
	
	<fuseaction name="update" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.categoryID" value="0" overwrite="false" />
		<set name="ATTRIBUTES.category" value="" overwrite="false" />
		<!-- get category -->
		<cs:get bean="categoryService" returnvariable="REQUEST.categoryService" />
		<set name="REQUEST.category" value="#REQUEST.categoryService.getCategoryByID(ATTRIBUTES.categoryID)#" />
		<!-- set properties -->
		<invoke object="REQUEST.category" method="setCategory">
			<argument name="category" value="#ATTRIBUTES.category#" />
		</invoke>
		<!-- save category -->
		<set name="REQUEST.categoryID" value="#REQUEST.categoryService.saveCategory(REQUEST.category)#" />		
	</fuseaction>
	
	<fuseaction name="delete" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.categoryID" value="0" overwrite="false" />
		<!-- get category -->
		<cs:get bean="categoryService" returnvariable="REQUEST.categoryService" />
		<invoke object="REQUEST.categoryService" method="removeCategory">
			<argument name="categoryID" value="#ATTRIBUTES.categoryID#" />
		</invoke>
	</fuseaction>
	
	
</circuit>
