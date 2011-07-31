<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="internal">

	<fuseaction name="main">
		<do action="entry.recent" />
	</fuseaction>
	
	<fuseaction name="output">
		<if condition="structKeyExists(REQUEST.content, 'rss')">
			<true>
				<include template="../layout/lay_rss.cfm" />
			</true>
			<false>
				<include template="../layout/lay_main.cfm" />
			</false>
		</if>
	</fuseaction>
	
	<fuseaction name="message">
		<set name="title" value="System Message" overwrite="false" />
		<set name="message" value="" overwrite="false" />
		<set name="forward" value="entry.recent" overwrite="false" />
		<include template="dsp_message.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="globalXFA">
		<xfa name="home" value="entry.recent" />
		<xfa name="view" value="entry.display" />
		<xfa name="addPost" value="entry.addForm" />
		<xfa name="addCategory" value="category.addForm" />
		<xfa name="editCategory" value="category.editForm" />
		<xfa name="removeCategory" value="category.remove" />
		<xfa name="addBookmark" value="bookmark.addForm" />
		<xfa name="editBookmark" value="bookmark.editForm" />
		<xfa name="removeBookmark" value="bookmark.remove" />
		<xfa name="login" value="login.form" />
		<xfa name="logout" value="login.logout" />
		<xfa name="category" value="entry.category" />
		<xfa name="rss" value="entry.rss" />
		<xfa name="rssCategory" value="entry.rssCategory" />
	</fuseaction>
	
</circuit>
