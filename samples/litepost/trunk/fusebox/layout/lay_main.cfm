<cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>#REQUEST.content.title#</title>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
	<style type="text/css" media="all">
	<!--
	@import url("/assets/css/lp_layout.css");
	@import url("/assets/css/lp_text.css");
	@import url("/assets/css/lp_forms.css");
	-->
	</style>
	#REQUEST.content.head#
</head>
<body>

<!-- display divider-->
<div id="bar">&nbsp;</div>

<!-- main container -->
<div id="container">
<!-- login/out button -->
<cfif NOT SESSION.user.isLoggedIn><a href="#REQUEST.myself##XFA.login#" id="loginbutton" class="adminbutton">Log In</a></cfif>
	<!-- header block -->
	<div id="header"><a href="#REQUEST.myself##XFA.home#"><img src="/assets/images/litePost_logo.gif" alt="litePost" border="0" /></a></div>
	
	<!-- wrapper block to constrain widths -->
	<div id="wrapper">
		<!-- begin body content -->
		<div id="content">
		<!-- anchor to top of content, also used for skip to content links-->
		<a name="content"></a>
		#REQUEST.content.body#
	  </div>
	</div>
	
	<!-- navigation -->
	<div id="navigation">
		<h2>Navigation</h2>
		<ul>
			<li><a href="#REQUEST.myself##XFA.home#">Home</a></li>
			<cfif SESSION.user.isLoggedIn>
				<li><a href="#REQUEST.myself##XFA.logout#">Logout</a></li>
			</cfif>
			<cfif SESSION.user.role IS 'admin'>
				<li><a href="#REQUEST.myself##XFA.addPost#">Add Post</a></li>
			</cfif>
		</ul>
		<h2>
			Categories
			<cfif SESSION.user.role IS 'admin'><a href="#REQUEST.myself##XFA.addCategory#"><img src="/assets/images/add_icon.gif" border="0" /></a></cfif>
		</h2>
		<ul>
			<cfloop from="1" to="#REQUEST.qryCategories.recordCount#" index="c">
				<cfif REQUEST.qryCategories.entryCount[c]>
				<li>
					<a href="#REQUEST.myself##XFA.category#&categoryID=#REQUEST.qryCategories.categoryID[c]#">#REQUEST.qryCategories.category[c]#</a> (#REQUEST.qryCategories.entryCount[c]#)
					<a href="#REQUEST.myself##XFA.rssCategory#&categoryID=#REQUEST.qryCategories.categoryID[c]#"><img src="/assets/images/rss_icon.gif" border="0" /></a>
					<cfif SESSION.user.role IS 'admin'>
						<a href="#REQUEST.myself##XFA.editCategory#&categoryID=#REQUEST.qryCategories.categoryID[c]#"><img src="/assets/images/edit_icon.gif" border="0" /></a>
						<a href="#REQUEST.myself##XFA.removeCategory#&categoryID=#REQUEST.qryCategories.categoryID[c]#"><img src="/assets/images/delete_icon.gif" border="0" /></a>
					</cfif>
				</li>
				</cfif>
			</cfloop>
	  </ul>
		<h2>
			Bookmarks
			<cfif SESSION.user.role IS 'admin'><a href="#REQUEST.myself##XFA.addBookmark#"><img src="/assets/images/add_icon.gif" border="0" /></a></cfif>
		</h2>
		<ul>
			<cfloop from="1" to="#REQUEST.qryBookmarks.recordCount#" index="b">
				<li>
					<a href="#REQUEST.qryBookmarks.url[b]#" target="_blank">#REQUEST.qryBookmarks.name[b]#</a>
					<cfif SESSION.user.role IS 'admin'>
						<a href="#REQUEST.myself##XFA.editBookmark#&bookmarkID=#REQUEST.qryBookmarks.bookmarkID[b]#"><img src="/assets/images/edit_icon.gif" border="0" /></a>
						<a href="#REQUEST.myself##XFA.removeBookmark#&bookmarkID=#REQUEST.qryBookmarks.bookmarkID[b]#"><img src="/assets/images/delete_icon.gif" border="0" /></a>
					</cfif>
				</li>
			</cfloop>
		</ul>
	</div>
<!-- site footer-->
	<div id="footer"><p>#REQUEST.content.footer#</p></div>
</div>

</cfoutput>

</body>
</html>
