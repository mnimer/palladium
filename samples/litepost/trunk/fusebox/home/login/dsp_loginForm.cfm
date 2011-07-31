<cfoutput>
	<h1>Please Log In  </h1>
    <form id="login" name="login" method="post" action="#REQUEST.myself##XFA.submit#">
  	<label>Username<br /><input name="username" type="text" /></label>
	<label>Password<br /><input name="password" type="password" /></label>
	<button name="submit">Submit</button>
    </form>
</cfoutput>