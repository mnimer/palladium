
<cfset bf = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
<!--- load the bean defs --->
<cfset bf.loadBeansFromXmlFile(expandPath('./config/litepost-services.xml'))/>

<cfset entryService = bf.getBean("entryService") />
<cfset commentService = bf.getBean("commentService") />

<cfset entry = CreateObject("component", "net.litepost.component.entry.Entry").init() />
<cfset entry.setTitle("A test entry!") />
<cfset entry.setBody("Well look at this, I bet we will have a problem here...") />

<cfset entryID = entryService.saveEntry(entry) />

<cfset entries = entryService.getEntries() />

<cfoutput>
	New Entry: #entryID# - #entry.getTitle()#<br/>
	<cfloop from="1" to="#ArrayLen(entries)#" index="i">
		#entries[i].getTitle()# : #entries[i].getBody()#<br/>
	</cfloop>
</cfoutput>


<cfset comment = CreateObject("component", "net.litepost.component.comment.Comment").init() />
<cfset comment.setEntryId(entryID)/>
<cfset comment.setComment("Cool entry")/>
<cfset comment.setName("Chris")/>
<cfset comment.setEmail("chris@home")/>
<cfset comment.setUrl("www.home.com")/>

<cfset commentID = commentService.saveComment(comment) />

<cfset comments = commentService.getCommentsByEntryID(entryID) />

<cfoutput>
	New Comment: #commentID# - #comment.getComment()#<br/>
	<cfloop from="1" to="#ArrayLen(comments)#" index="i">
		#comments[i].getComment()# : #comments[i].getName()#<br/>
	</cfloop>
</cfoutput>

<cfset commentService.removeComment(commentID) />
<cfset entryService.removeEntry(entryID) />
