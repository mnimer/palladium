<cfparam name="request.errorMessage" default=""/>
     
<cfscript>
    label = "Add";
    if( isDefined("request.bookmark") && request.bookmark.getBookmarkID() neq 0)
    {
        label = "edit";
    }

</cfscript>


<cfinclude template="_header.cfm"/>
<div id="wrapper">

    <!-- begin body content -->
    <div id="content">
        <cfoutput>
            <h1>#label# Category </h1>

            <cfif request.errorMessage is not "">
                <p><strong>#request.errorMessage#</strong></p>
            </cfif>

            <form id="editEntry" name="editEntry" method="post" action="#request.appPath#/bookmark/save.cfm">
                <label>Name<br />
                <input id="bookmarkName" name="bookmarkName" type="text" value="#request.bookmark.getName()#" />
                </label>
                <label>URL<br />
                <input id="bookmarkUrl" name="bookmarkUrl" type="text" value="#request.bookmark.getUrl()#" />
                </label>
                <input type="submit" name="saveBookmarkBtn" value="#label# Bookmark" class="adminbutton" />
                <!--- <button name="submit">Submit</button> --->
                <input type="hidden" name="bookmarkID" value="#request.bookmark.getBookmarkID()#" />
            </form>
        </cfoutput>
    </div>

</div>
<cfinclude template="_footer.cfm">