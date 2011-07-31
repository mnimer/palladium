<cfcomponent displayname="EntryCommentsTests" 
			hint="test entry and comment service methods" 
			extends="org.cfcunit.framework.TestCase">
	
	<cffunction name="setUp" access="private" returntype="void" output="false">
		<cfset var path = GetDirectoryFromPath(getMetaData(this).path) />
		<cfset var bf = 0 />
		<cfset var bean = 0 />
		
		<cfset variables.sys = CreateObject('java','java.lang.System') />
	
		<cfset variables.sys.out.println("Loading bean factory...") />
		<!--- create a new bean factory --->
		<cfset bf = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
		<!--- load the bean defs --->
		<cfset bf.loadBeansFromXmlFile(path&'/litepost-services.xml')/>
		
		<cfset variables.sys.out.println("Loading services") />

		<cfset variables.sys.out.println("entryService...") />
		<cfset variables.entryService = bf.getBean("entryService") />
		<cfset variables.sys.out.println("commentService...") />
		<cfset variables.commentService = bf.getBean("commentService") />
		
	</cffunction>
	
	<cffunction name="testEntryServiceMethods" access="public" returntype="void" output="false">
		
		<cfset var entry = 0 />
		<cfset var entries = 0 />
		<cfset var entryID = 0 />
		<cfset var title = "" />
		<cfset var body = "" />
		
		<cfset entries = variables.entryService.getEntries() />
		
		<!--- make sure service retuned an array --->
		<cfset assertTrue(IsArray(entries), "getEntries() did not return an array!")/>
		<cfset variables.sys.out.println("getEntries() returned #ArrayLen(entries)# Entries") />
		
		<cfset entries = variables.entryService.getEntriesAsQuery() />
		
		<!--- make sure service retuned an query --->
		<cfset assertTrue(IsQuery(entries), "getEntriesAsQuery() did not return a query!")/>
		<cfset variables.sys.out.println("getEntries() returned #entries.RecordCount# Entries") />
		
		<cfset entries = variables.entryService.getEntriesByCategoryID(1) />
		
		<!--- make sure service retuned an array --->
		<cfset assertTrue(IsArray(entries), "getEntriesByCategoryID(1) did not return an array!")/>
		<cfset variables.sys.out.println("getEntriesByCategoryID(1) returned #ArrayLen(entries)# Entries") />
		
		<cfset entry = CreateObject("component", "net.litepost.component.entry.Entry").init() />
		<cfset entry.setTitle("A test entry!") />
		<cfset entry.setBody("Well look at this, I bet we will have a problem here...") />
		<cfset title = entry.getTitle() />
		<cfset body = entry.getBody() />
		
		<cfset entryID = variables.entryService.saveEntry(entry) />
		<!--- make sure service saved something --->
		<cfset assertTrue(entryID, "saveEntry() did not return an entry id!")/>
		<cfset variables.sys.out.println("saveEntry() created new entry ID: #entryID#") />
		
		<cfset entry = variables.entryService.getEntryById(entryID) />
		<cfset variables.sys.out.println("getEntryById(#entryID#) returned: #entry.getTitle()#") />
		<!--- make sure the bookmark we just retrieved was the one we saved --->
		<cfset assertEqualsString(entry.getTitle(), title, "Entry titles do not match!")/>
		<cfset assertEqualsString(entry.getBody(), body, "Entry bodies do not match!")/>
		
		<!--- test an update ---> 
		<cfset entry.setTitle("xxx")/>
		<cfset entryID = variables.entryService.saveEntry(entry) />
		<cfset assertEqualsNumber(entry.getEntryID(), entryID, "Entry IDs do not match!")/>
		
		<!--- remove new entry --->
		<cfset variables.entryService.removeEntry(entryID) />
	</cffunction>
	
	<cffunction name="testCommentsServiceMethods" access="public" returntype="void" output="false">
		
		<cfset var comment = 0 />
		<cfset var comments = 0 />
		<cfset var entry = 0/>
		<cfset var entryID = 0/>
		<cfset var commentID = 0 />
		<cfset var commentbody = "" />
		<cfset var name = "" />
		<cfset var email = "" />
		<cfset var url = "" />
		
		<cfset entry = CreateObject("component", "net.litepost.component.entry.Entry").init() />
		<cfset entry.setTitle("A test entry for comments!") />
		<cfset entry.setBody("This better stop being a pain in the ass!...") />
		<cfset entryID = variables.entryService.saveEntry(entry) />
		
		<cfset comments = variables.commentService.getCommentsByEntryID(entryID) />
		<!--- make sure service retuned an array --->
		<cfset assertTrue(IsArray(comments), "getCommentsByEntryID(#entryID#) did not return an array!")/>
		<cfset variables.sys.out.println("getCommentsByEntryID(#entryID#) returned #ArrayLen(comments)# Comments")/>
		
		<!--- make a new comment, save fetch, update, check it, delete it --->
		<cfset comment = CreateObject("component", "net.litepost.component.comment.Comment").init() />
		<cfset comment.setEntryId(entryID)/>
		<cfset comment.setComment("Cool entry")/>
		<cfset comment.setName("Chris")/>
		<cfset comment.setEmail("chris@home")/>
		<cfset comment.setUrl("www.home.com")/>
		<cfset commentbody = comment.getComment()/>
		<cfset name = comment.getName()/>
		<cfset email = comment.getEmail()/>
		<cfset url = comment.getUrl()/>
		
		<cfset commentID = variables.commentService.saveComment(comment) />
		<!--- make sure service saved something --->
		<cfset assertTrue(entryID, "saveComment() did not return a comment id!")/>
		<cfset variables.sys.out.println("saveComment() created new comment ID: #commentID#") />
		
		<cfset comment = variables.commentService.getCommentById(commentID) />
		<cfset variables.sys.out.println("getCommentById(#commentID#) returned: #comment.getComment()#") />
		<!--- make sure the bookmark we just retrieved was the one we saved --->
		<cfset assertEqualsString(comment.getComment(), commentbody, "Comment comments do not match!")/>
		<cfset assertEqualsString(comment.getName(), name, "Comment names do not match!")/>
		<cfset assertEqualsString(comment.getEmail(), email, "Comment emails do not match!")/>
		<cfset assertEqualsString(comment.getUrl(), url, "Comment urls do not match!")/>
		
		<!--- test an update ---> 
		<cfset comment.setComment("xxx")/>
		<cfset commentID = variables.commentService.saveComment(comment) />
		<cfset assertEqualsNumber(comment.getCommentID(), commentID, "Comment IDs do not match!")/>
		
		<!--- remove comment --->
		<cfset variables.commentService.removeComment(commentID) />	
		<!--- remove entry --->
		<cfset variables.entryService.removeEntry(entryID) />
	</cffunction>
	
</cfcomponent>