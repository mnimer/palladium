<cfparam name="request.errorMessage" default=""/>

<cfscript>
    label = "Add";
    if( isDefined("request.entry") && request.entry.getEntryID() neq "")
    {
        label = "edit";
    }

</cfscript>


<cfinclude template="_header.cfm"/>
<!-- wrapper block to constrain widths -->
<div id="wrapper">

    <!-- begin body content -->
    <div id="content">
        <cfoutput>
            <h1>#label# Entry </h1>

            <cfif request.errorMessage is not "">
                <p><strong>#request.errorMessage#</strong></p>
            </cfif>

            <form id="editEntry" name="editEntry" method="post" action="#request.appPath#/post/save.cfm">
                <label>Title<br />
                <input name="title" type="text" value="#request.entry.getTitle()#" />
                </label>
                <label>Entry<br />
                <textarea name="body" class="entry" style="height:100px;">#request.entry.getBody()#</textarea>
                </label>
                <label>Category<br />
                <select name="categoryID">
                    <cfloop index="i" from="1" to="#arrayLen(request.categories)#">
                        <cfset category = request.categories[i] />

                        <cfif !isNull(request.entry.getCategory())>
                            <option value="#category.getCategoryID()#"<cfif category.getCategoryID() eq request.entry.getCategory().getCategoryID()> selected</cfif>>#category.getCategory()#</option>
                        <cfelse>
                            <option value="#category.getCategory().getCategoryID()#">#category.getCategory()#</option>
                        </cfif>
                    </cfloop>
                </select>

                </label>
                <input type="submit" name="savePostBtn" value="#label# Entry" class="adminbutton" />
                <!--- <button name="submit">Submit</button> --->
                <input type="hidden" name="entryID" value="#request.entry.getEntryID()#" />
            </form>
        </cfoutput>
    </div>

</div>
<cfinclude template="_footer.cfm">