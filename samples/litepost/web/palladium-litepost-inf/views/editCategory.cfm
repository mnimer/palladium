<cfparam name="request.errorMessage" default=""/>

<cfscript>
    label = "Add";
    if( isDefined("request.category") && request.category.getCategoryID() neq 0)
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

            <form id="editEntry" name="editEntry" method="post" action="#request.appPath#/category/index.cfm?action=save">
                <label>Category<br />
                <input id="categoryName" name="categoryName" type="text" value="#request.category.getCategory()#" />
                </label>
                <input type="submit" name="saveCatBtn" value="#label# Category" class="adminbutton" />
                <!--- <button name="submit">Submit</button> --->
                <input type="hidden" name="categoryID" value="#request.category.getCategoryID()#" />
            </form>
        </cfoutput>
    </div>

</div>
<cfinclude template="_footer.cfm">