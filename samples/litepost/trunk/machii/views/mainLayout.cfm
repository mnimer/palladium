<cfsilent>
	<cfset content = event.getArg("content", "") />
	<cfset contentRight = event.getArg("contentRight", "") />
	<cfset isAdmin = event.getArg("isAdmin") />
</cfsilent>

<cfcontent reset="true" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>litePost blog</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">

<style type="text/css" media="all">
<!--
@import url("../assets/css/lp_layout.css");
@import url("../assets/css/lp_text.css");
@import url("../assets/css/lp_forms.css");
-->
</style>
<cfoutput>
<link rel="alternate" type="application/rss+xml" title="RSS" href="#getProperty('blogURL')#/index.cfm?#getProperty('eventParameter')#=showBlogRSS" />
</cfoutput>
</head>
<body>
<cfoutput>
<!-- display divider-->
<div id="bar">&nbsp;</div>

<!-- main container -->
<div id="container">
<!-- login/out button -->
<cfif Not isAdmin>
<a href="index.cfm?#getProperty('eventParameter')#=showLogin" id="loginbutton" class="adminbutton">Log In</a>
<cfelse>
<a href="index.cfm?#getProperty('eventParameter')#=logout" id="loginbutton" class="adminbutton">Log Out</a>
</cfif>
	<!-- header block -->
	<div id="header"><a href="index.cfm?#getProperty('eventParameter')#=showHome"><img src="../assets/images/litePost_logo.gif" alt="litePost" border="0" /></a></div>
	<!-- wrapper block to constrain widths -->
	<div id="wrapper">
		<!-- begin body content -->
		<div id="content">
		<!-- anchor to top of content, also used for skip to content links-->
		<a name="content"></a>
		#content#
		
	  </div>
		
	</div>
	<!-- navigation -->
	<div id="navigation">
		#contentRight#
	</div>
	<!-- site footer-->
	<div id="footer"><p>LitePost is made under the Creative Commons license! (or something like that)</p></div>
</div>
</cfoutput>
</body>
</html>
