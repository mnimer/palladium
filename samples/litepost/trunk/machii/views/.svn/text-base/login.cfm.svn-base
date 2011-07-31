	<cfoutput>
		<h1>Please Log In</h1>
		
		<cfif event.isArgDefined("message")>
			<p style="color:red;font-weight:bold;" align="center">#event.getArg("message")#</p>
		</cfif>
		
		<form action="index.cfm?#getProperty('eventParameter')#=processLogin" method="post">
		  	<label>Username<br />
		  	<input name="userName" type="text" maxlength="30" />
			</label>
			<label>Password<br />
			<input name="password" type="password" maxlength="30" />
			</label>
			<input type="submit" name="submit" value="Log In" class="adminbutton" />
			<!--- <a href="admin.html">
			<button name="submit">Login</button>
			</a> --->
		</form>
	</cfoutput>
