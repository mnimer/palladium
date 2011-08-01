<cfparam name="request.errorMessage" default=""/>
<cfset fullDateString = "dddd, mmmm dd, yyyy" />
<cfset shortDateString = "mmm dd, yyyy" />
<cfset timeString = "h:mm tt" />

<cfinclude template="_header.cfm"/>
<!-- wrapper block to constrain widths -->
<div id="wrapper">

    <!-- begin body content -->
    <div id="content">
        <cfoutput>
            <cfif request.user.getRole() eq "admin" >
            <a href="#request.appPath#/web/litepost-inf/views/viewPost.cfm#request.entry.getEntryID()#/edit.cfm" class="adminbutton">Edit</a>
            </cfif>
            <h1 style="text-align:left;">#request.entry.getTitle()#</h1>
            <p class="author">Posted #dateFormat(request.entry.getDateCreated(), shortDateString)# @ #timeFormat(request.entry.getDateCreated(), timeString)#</p>
            <p>#request.CFJavaUtils.ifNull(request.entry.getBody(), "")#</p>

            <!-- footer at the bottom of every post-->
            <div class="postfooter">
                <span>
                    <img src="/litepost/assets/images/comment_icon.gif" alt="Comment" border="0" />
                    Comments (#request.entry.getComments().size()#)
                </span>
                <span class="right">
                    <cfif request.entry.getCategory().getCategoryID() neq 0>
                    <a href="#request.appPath#/category/index.cfm?action=view&categoryID=#request.entry.getCategory().getCategoryID()#">Filed under #request.entry.getCategory().getCategory()#</a><cfelse>Unfiled</cfif>
                </span>
            </div>

            <a name="comments"></a>
            <h2>Comments</h2>
            <cfset comments = request.CFJavaUtils.toCFArray(request.entry.getComments())>
            <cfif arrayLen(comments) gt 0>
                <cfloop index="i" from="1" to="#arrayLen(comments)#">
                    <cfset comment = comments[i] />
                    <div class="comment">
                        <p>
                            <strong>
                                <cfif comment.getUrl() is not ""><a href="#comment.getUrl()#" target="_blank"></cfif>
                                #comment.getName()#
                                <cfif comment.getUrl() is not ""></a></cfif>
                            </strong>
                            - <em>#dateFormat(comment.getDateCreated(), "mm/dd/yyyy")#</em></p>
                        <p>#comment.getName()# says ... #comment.getComment()#</p>
                    </div>
                    <p><a href="##content"><img src="/litepost/assets/images/top_icon.gif" alt="top" /></a> <a href="##content">top</a></p>
                </cfloop>
            <cfelse>
                <p>No comments yet. Be the first to add a comment!</p>
            </cfif>

            <h2>Add A Comment </h2>
            <form id="comment" name="comment" method="post" action="#request.appPath#/web/litepost-inf/views/viewPost.cfm#request.entry.getEntryID()#/addComment.cfm">
                <label>Your Name<br/>
                <input type="text" name="name" />
                </label>
                <label>Email (not shared with anyone)
                <input type="text" name="email" />
                </label>
                <label>URL (linked in your post)
                <input type="text" name="url" />
                </label>
                <label>Comment<br/>
                <textarea name="comment" class="comment"></textarea>
                </label>
                <input type="submit" name="addCommentBtn" value="Submit" class="adminbutton" />
                <!--- <button name="submit">Submit</button> --->
                <input type="hidden" name="includeComments" value="true" />
            </form>
          <p>&nbsp;</p>

        </cfoutput>

    </div>

</div>
<cfinclude template="_footer.cfm">