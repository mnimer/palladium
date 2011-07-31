<cfparam name="request.errorMessage" default=""/>
<cfinclude template="_header.cfm"/>
<!-- wrapper block to constrain widths -->
<div id="wrapper">

    <!-- begin body content -->
    <div id="content">

        <cfloop index="i" from="1" to="#arrayLen( request.CFJAVAUTILS.toCFArray(request.entries) )#">
        <cfoutput>
        <cfset entry = request.entries[i]>
            <h1 style="text-align:left;align:left;"><a href="#request.appPath#/post/#entry.getEntryID()#/view.cfm">#entry.getTitle()#</a></h1>
            <p class="author">Posted by #entry.getUser().getFirstName()#, #entry.getDateLastUpdated().toGMTString()#</p>
            <p>#entry.getBody()#</p>

            <!-- footer at the bottom of every post-->
            <div class="postfooter">
                <span>
                    <a href="#request.appPath#/post/#entry.getEntryID()#/view.cfm">
                        <img src="/litepost/assets/images/comment_icon.gif" title="Comments" alt="Comments" border="0" />
                    </a>
                    <a href="#request.appPath#/post/#entry.getEntryID()#/view.cfm">
                        Comments (#entry.getComments().size()#)
                    </a>
                </span>
                <span class="right">
                    <a href="#request.appPath#/category/index.cfm?action=view&categoryID=#entry.getCategory().getCategoryID()#">
                        Filed under #entry.getCategory().getCategory()#
                    </a>
                </span>
            </div>
            <br clear="left"/>
        </cfoutput>
        </cfloop>

    </div>

</div>

<cfinclude template="_footer.cfm">