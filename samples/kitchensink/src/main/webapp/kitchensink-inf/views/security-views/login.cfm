<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert title here</title>
    </head>
<body>

<h1>
    Login</h1>

<cfoutput>
<cfif isDefined("request.error")>
    <div id="login-error">[Error] #request.error#</div>
</cfif>
</cfoutput>

<form action="/kitchensink/security/j_spring_security_check" method="post" >
<p>

    <label for="j_username">Username</label>
    <input id="j_username" name="j_username" type="text" value="admin" />
</p>

<p>
    <label for="j_password">Password</label>
    <input id="j_password" name="j_password" type="password" value="admin" />
</p>

<input  type="submit" value="Login"/>
</form>

</body>
</html>