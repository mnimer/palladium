<cfsilent>
	<cfset message = viewState.getValue("message") />
	<cfset myself = viewState.getValue("myself") />
	<cfset submitEvent = viewState.getValue("submitEvent") />
</cfsilent>

<cfoutput>
	<h1>Please Log In</h1>
		
	<cfif len(message)>
		<p style="color:red;font-weight:bold;" align="center">#message#</p>
	</cfif>
	
	<form action="#myself##submitEvent#" method="post">
	  	<label>Username<br />
	  	<input name="userName" type="text" maxlength="30" />
		</label>
		<label>Password<br />
		<input name="password" type="password" maxlength="30" />
		</label>
		<input type="submit" name="submit" value="Log In" class="adminbutton" />
	</form>
</cfoutput>