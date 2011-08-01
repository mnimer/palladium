<cfparam name="session.user.isAdmin" default="false"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>litePost blog</title>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">

	<style type="text/css" media="all">
	<!--
	@import url("/litepost/assets/css/lp_layout.css");
	@import url("/litepost/assets/css/lp_text.css");
	@import url("/litepost/assets/css/lp_forms.css");
	-->
	</style>

</head>

<body>

<!-- display divider-->
<div id="bar">&nbsp;</div>

<cfoutput>
<!-- main container -->
<div id="container">

	<!-- login/out button -->
	<cfif isDefined("request.user")>
		<a href="#request.appPath#/index.cfm?action=logout" id="loginbutton" class="adminbutton">Log Out</a>
	</cfif>

	<!-- header block -->
	<div id="header"><a href="#request.appPath#/index.cfm"><img src="/litepost/assets/images/litePost_logo.gif" alt="litePost" border="0" /></a></div>
</cfoutput>
