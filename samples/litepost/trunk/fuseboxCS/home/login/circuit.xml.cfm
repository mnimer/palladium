<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<circuit name="login" access="public" xmlns:cf="cf/" xmlns:cs="coldspring/">

	<fuseaction name="form">
		<xfa name="submit" value="login" />
		<include template="dsp_loginForm.cfm" contentvariable="REQUEST.content.body" />
	</fuseaction>
	
	<fuseaction name="login">
		<!-- required parameters -->
		<set name="ATTRIBUTES.username" value="" overwrite="false" />
		<set name="ATTRIBUTES.password" value="" overwrite="false" />
		<!-- get user service -->
		<cs:get bean="userService" returnvariable="REQUEST.userService" />
		<!-- authenticate credentials -->
		<set name="REQUEST.user" value="#REQUEST.userService.authenticate(ATTRIBUTES.username, ATTRIBUTES.password)#" />
		<if condition="REQUEST.user.isNull()">
			<true>
				<cf:throw type="security.login" message="Invalid Login" detail="The specified username and/or password is incorrect." />
			</true>
		</if>
		<!-- display message -->
		<do action="home.message">
			<parameter name="title" value="Login Success" />
			<parameter name="message" value="You have been logged in successfully." />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
	<fuseaction name="logout">
		<!-- get user service -->
		<cs:get bean="securityService" returnvariable="REQUEST.securityService" />
		<!-- authenticate credentials -->
		<invoke object="REQUEST.securityService" method="removeUserSession()" />
		<!-- display message -->
		<do action="home.message">
			<parameter name="title" value="Logout Success" />
			<parameter name="message" value="You have been logged out successfully." />
			<parameter name="forward" value="entry.recent" />
		</do>
	</fuseaction>
	
</circuit>