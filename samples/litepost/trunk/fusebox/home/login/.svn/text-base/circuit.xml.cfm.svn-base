<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="login" access="public" xmlns:cf="cf/">

	<fuseaction name="form">
		<xfa name="submit" value="login" />
		<include template="dsp_loginForm.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="login">
		<include template="act_login.cfm" />
		<do action="home.message">
			<parameter name="title" value="Login Success" />
			<parameter name="message" value="You have been logged in successfully." />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<fuseaction name="logout">
		<include template="act_logout.cfm" />
		<do action="home.message">
			<parameter name="title" value="Logout Success" />
			<parameter name="message" value="You have been logged out successfully." />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
</circuit>