<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public" xmlns:cf="cf/">

	<!--
	
	PUBLIC
	
	-->

	<fuseaction name="form">
		<xfa name="submit" value="add" />
		<include template="dsp_commentForm.cfm" />
	</fuseaction>
	
	<fuseaction name="add">
		<if condition="NOT structKeyExists(FORM, 'fieldnames')">
			<true>
				<relocate url="#REQUEST.myself##XFA.home#" />
			</true>
		</if>
		<do action="create" />
		<do action="home.message">
			<parameter name="title" value="Comment Added" />
			<parameter name="message" value="Your comment has been added" />
			<parameter name="forward" value="entry.display&amp;entryID=#ATTRIBUTES.entryID#" />
		</do>
	</fuseaction>
	
	<fuseaction name="remove" roles="admin">
		<if condition="NOT structKeyExists(ATTRIBUTES, 'commentID')">
			<true>
				<cf:throw type="validation.INVALID_ID" message="Invalid Comment" detail="You must specify a valid comment to remove." />
			</true>
		</if>
		<do action="delete">
			<parameter name="commentID" value="#ATTRIBUTES.commentID#" />
		</do>
		<do action="home.message">
			<parameter name="title" value="Comment Removed" />
			<parameter name="message" value="The comment has been removed" />
			<parameter name="forward" value="entry.display&amp;entryID=#REQUEST.qryComment.entryID[1]#" />
		</do>
	</fuseaction>
	
	<!--
	
	PRIVATE
	
	-->

	<fuseaction name="get" access="internal">
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<include template="qry_getComments" />
	</fuseaction>
	
	<fuseaction name="create" access="internal" roles="admin">
		<include template="act_createComment" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" roles="admin">
		<set name="commentID" value="0" overwrite="false" />
		<include template="act_deleteComment" />
	</fuseaction>
	
</circuit>
