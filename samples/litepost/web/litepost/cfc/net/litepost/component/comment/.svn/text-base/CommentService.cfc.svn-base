<!--- 
	  
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

  $Id$

--->
 
<cfcomponent displayname="CommentService" 
			extends="net.litepost.service.CommentService" 
			hint="Service for Comments">

	<cffunction name="init" returntype="net.litepost.component.comment.CommentService" access="public" output="false">
		<cfreturn this/>
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setCommentDAO" returntype="void" access="public" output="false" hint="Dependency: CommentDAO">
		<cfargument name="commentDAO" type="net.litepost.component.comment.CommentDAO" required="true"/>
		<cfset variables.commentDAO = arguments.commentDAO />
	</cffunction>
	
	<cffunction name="setCommentGateway" returntype="void" access="public" output="false" hint="Dependency: CommentGateway">
		<cfargument name="commentGateway" type="net.litepost.component.comment.CommentGateway" required="true"/>
		<cfset variables.commentGateway = arguments.commentGateway />
	</cffunction>
	
	<!--- service methods --->
	<cffunction name="getCommentsByEntryID" returntype="array" access="public" output="false">
		<cfargument name="entryID" type="numeric" required="true" />
		<cfreturn variables.commentGateway.getCommentsByEntryID(arguments.entryID) />
	</cffunction>
	
	<cffunction name="getCommentByID" returntype="net.litepost.component.comment.Comment" output="false" hint="Returns a comment based on the specified comment id.">
		<cfargument name="commentID" type="numeric" required="true" />
		<cfreturn variables.commentDAO.fetch(arguments.commentID) />
	</cffunction>
	
	<cffunction name="getNewComment" returntype="net.litepost.component.comment.Comment" output="false" hint="Returns an empty Comment.">
		<cfset var comment = createObject('component', 'net.litepost.component.comment.Comment').init() />
		<cfreturn comment />
	</cffunction>
	
	<cffunction name="saveComment" returntype="numeric" access="public" output="false">
		<cfargument name="comment" type="net.litepost.component.comment.Comment" required="true" />
		<cfreturn variables.commentDAO.save(comment) />
	</cffunction>
	
	<cffunction name="removeComment" returntype="void" required="true">
		<cfargument name="commentID" type="numeric" required="true" />
		<cfset variables.commentDAO.remove(arguments.commentID) />
	</cffunction>
	
</cfcomponent>