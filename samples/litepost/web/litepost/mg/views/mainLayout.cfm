
<!--- the main layout page --->

<cfsilent>
	<cfset content = ViewCollection.GetView("content") />
	<cfset contentRight = ViewCollection.GetView("contentRight") />
	<cfset isAdmin = viewState.getValue("isAdmin") />
	<cfset myself = viewState.getValue("myself") />
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

</head>

<body>

<!-- display divider-->
<div id="bar">&nbsp;</div>

<cfoutput>
<!-- main container -->
<div id="container">

	<!-- login/out button -->
	<cfif isAdmin>
		<a href="#myself#logout" id="loginbutton" class="adminbutton">Log Out</a>
	<cfelse>
		<a href="#myself#loginForm" id="loginbutton" class="adminbutton">Log In</a>
	</cfif>
	
	<!-- header block -->
	<div id="header"><a href="#myself#home"><img src="../assets/images/litePost_logo.gif" alt="litePost" border="0" /></a></div>
	
	<!-- wrapper block to constrain widths -->
	<div id="wrapper">
		<!-- begin body content -->
		<div id="content">
			
			<!-- anchor to top of content, also used for skip to content links-->
			<a name="content"></a>
			
			<!-- content -->
			<cfif len("content")>
				#content#
			</cfif>
		
	  	</div>
		
	</div>
	<!-- navigation -->
	<div id="navigation">
				
		<cfif len("contentRight")>
			#contentRight#
		</cfif>
		
	</div>
	
	<!-- site footer-->
	<div id="footer"><p>LitePost is made under the Creative Commons license! (or something like that)</p></div>
	
</div>
</cfoutput>

</body>
</html>