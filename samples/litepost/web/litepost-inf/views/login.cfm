<cfparam name="request.errorMessage" default=""/>


<cfinclude template="_header.cfm"/>
<!-- wrapper block to constrain widths -->
<div id="wrapper">

    <!-- begin body content -->
    <div id="content">
        <cfoutput>
            <h1>Please Log In</h1>

            <cfif len(request.errorMessage)>
                <p style="color:red;font-weight:bold;" align="center">#request.errorMessage#</p>
            </cfif>

            <form action="/litepost/cfspringmvc/index.cfm" method="post">
                <label>Username<br />
                <input name="userName" type="text" maxlength="30" />
                </label>
                <label>Password<br />
                <input name="password" type="password" maxlength="30" />
                </label>
                <input type="submit" name="loginBtn" value="Log In" class="adminbutton" />
            </form>
        </cfoutput>
    </div>

</div>

<cfinclude template="_footer.cfm">