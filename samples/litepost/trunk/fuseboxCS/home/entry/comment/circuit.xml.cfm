<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit access="public" xmlns:cf="cf/" xmlns:cs="coldspring/">

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
			<parameter name="forward" value="entry.display&amp;entryID=#REQUEST.comment.getEntryID()#" />
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
			<parameter name="forward" value="entry.display&amp;entryID=#REQUEST.comment.getEntryID()#" />
		</do>
	</fuseaction>
	
	<!--
	
	PRIVATE
	
	-->

	<fuseaction name="get" access="internal">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.id" value="0" overwrite="false" />
		<!-- get comments by entry -->
		<cs:get bean="commentService" returnvariable="REQUEST.commentService" />
		<invoke object="REQUEST.commentService" method="getCommentsByEntryID" returnvariable="REQUEST.comments">
			<argument name="entryID" value="#ATTRIBUTES.id#" />
		</invoke>
	</fuseaction>
	
	<fuseaction name="create" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.entryID" value="0" overwrite="false" />
		<set name="ATTRIBUTES.comment" value="" overwrite="false" />
		<set name="ATTRIBUTES.name" value="" overwrite="false" />
		<set name="ATTRIBUTES.email" value="" overwrite="false" />
		<set name="ATTRIBUTES.url" value="" overwrite="false" />
		<!-- create comment -->
		<cs:get bean="commentService" returnvariable="REQUEST.commentService" />
		<set name="REQUEST.comment" value="#REQUEST.commentService.getNewComment()#" />
		<!-- set properties -->
		<invoke object="REQUEST.comment" method="setEntryID">
			<argument value="#ATTRIBUTES.entryID#" />
		</invoke>
		<invoke object="REQUEST.comment" method="setComment">
			<argument value="#ATTRIBUTES.comment#" />
		</invoke>
		<invoke object="REQUEST.comment" method="setName">
			<argument value="#ATTRIBUTES.name#" />
		</invoke>
		<invoke object="REQUEST.comment" method="setEmail">
			<argument value="#ATTRIBUTES.email#" />
		</invoke>
		<invoke object="REQUEST.comment" method="setUrl">
			<argument value="#ATTRIBUTES.url#" />
		</invoke>
		<!-- save comment -->
		<set name="REQUEST.commentID" value="#REQUEST.commentService.saveComment(REQUEST.comment)#" />
		<!-- update comment object -->
		<set name="REQUEST.comment" value="#REQUEST.commentService.getCommentByID(REQUEST.commentID)#" />
	</fuseaction>
	
	<fuseaction name="delete" access="internal" roles="admin">
		<!-- passed arguments -->
		<set name="ATTRIBUTES.commentID" value="0" overwrite="false" />
		<!-- delete comment -->
		<cs:get bean="commentService" returnvariable="REQUEST.commentService" />
		<invoke object="REQUEST.commentService" method="getCommentByID" returnvariable="REQUEST.comment">
			<argument name="commentID" value="#ATTRIBUTES.commentID#" />
		</invoke>
		<invoke object="REQUEST.commentService" method="removeComment">
			<argument name="commentID" value="#REQUEST.comment.getCommentID()#" />
		</invoke>
	</fuseaction>
	
</circuit>
