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

  $Id: CommentListener.cfc 75 2006-10-20 17:10:24Z mpwoodward $

--->

<cfcomponent 
	displayname="CommentListener" 
	output="false" 
	extends="MachII.framework.Listener" 
	hint="The Comment listener for Litepost">

	<cffunction name="configure" returntype="void" access="public" output="false" hint="Configures this listener; called automatically by Mach-II">
		<!--- don't need to do anything here --->
	</cffunction>
	
	<!--- setters for dependencies --->
	<cffunction name="setCommentService" returntype="void" access="public" output="false" hint="Dependency: CommentService">
		<cfargument name="commentService" type="net.litepost.component.comment.CommentService" required="true" />
		<cfset variables.commentService = arguments.commentService />
	</cffunction>
	
	<!--- listener methods --->
	<cffunction name="getComment" returntype="net.litepost.component.comment.Comment" access="public" output="false" 
			hint="Returns a comment bean using the ID in the event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var commentID = 0 />
		
		<cfif arguments.event.isArgDefined("commentID")>
			<cfset commentID = arguments.event.getArg("commentID") />
		</cfif>
		
		<cfreturn variables.commentService.getCommentByID(arguments.event.getArg("commentID")) />
	</cffunction>
	
	<cffunction name="getCommentsByEntryID" returntype="array" access="public" output="false" 
			hint="Gets the comments for a particular entry">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfreturn variables.commentService.getCommentsByEntryID(arguments.event.getArg("entryID")) />
	</cffunction>
	
	<cffunction name="processCommentForm" returntype="void" access="public" output="false" 
			hint="Processes the comment form and announces the next event">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset var exitEvent = "showEntry" />
		
		<cfif arguments.event.isArgDefined("exitEvent")>
			<cfset exitEvent = arguments.event.getArg("exitEvent") />
		</cfif>
		
		<cfset variables.commentService.saveComment(arguments.event.getArg("comment")) />
		
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
	
	<cffunction name="deleteComment" returntype="void" access="public" output="false" 
			hint="Deletes a comment">
		<cfargument name="event" type="MachII.framework.Event" require="true" />
		
		<cfset var exitEvent = "showCommentForm" />
		
		<cfif arguments.event.isArgDefined("exitEvent")>
			<cfset exitEvent = arguments.event.getArg("exitEvent") />
		</cfif>
		
		<cfset variables.commentService.removeComment(arguments.event.getArg("commentID")) />
		
		<cfset announceEvent(exitEvent, arguments.event.getArgs()) />
	</cffunction>
</cfcomponent>