<cfoutput>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>#REQUEST.content.title#</title>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
	<style type="text/css" media="all">
	<!--
	@import url("/assets/css/lp_layout.css?adam");
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
<cfif NOT REQUEST.security.isAuthenticated()><a href="#REQUEST.myself##XFA.login#" id="loginbutton" class="adminbutton">Log In</a></cfif>
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
			<li>
				<a href="#REQUEST.myself##XFA.home#">Home</a>
				<a href="#REQUEST.myself##XFA.rss#"><img src="/assets/images/rss_icon.gif" border="0" /></a>
			</li>
			
			<cfif REQUEST.security.isAuthenticated()>
				<li><a href="#REQUEST.myself##XFA.logout#">Logout</a></li>
			</cfif>
			<cfif REQUEST.security.isRole('admin')>
				<li><a href="#REQUEST.myself##XFA.addPost#">Add Post</a></li>
			</cfif>
		</ul>
		<h2>
			Categories
			<cfif REQUEST.security.isRole('admin')><a href="#REQUEST.myself##XFA.addCategory#"><img src="/assets/images/add_icon.gif" border="0" /></a></cfif>
		</h2>
		<ul>
			<cfloop from="1" to="#arrayLen(REQUEST.categories)#" index="c">
				<cfset category = REQUEST.categories[c] />
				<li>
					<a href="#REQUEST.myself##XFA.category#&categoryID=#category.getCategoryID()#">#category.getCategory()#</a> (#category.getNumPosts()#)
					<a href="#REQUEST.myself##XFA.rssCategory#&categoryID=#category.getCategoryID()#"><img src="/assets/images/rss_icon.gif" border="0" /></a>
					<cfif REQUEST.security.isRole('admin')>
						<a href="#REQUEST.myself##XFA.editCategory#&categoryID=#category.getCategoryID()#"><img src="/assets/images/edit_icon.gif" border="0" /></a>
						<a href="#REQUEST.myself##XFA.removeCategory#&categoryID=#category.getCategoryID()#"><img src="/assets/images/delete_icon.gif" border="0" /></a>
					</cfif>
				</li>
			</cfloop>
	  </ul>
		<h2>
			Bookmarks
			<cfif REQUEST.security.isRole('admin')><a href="#REQUEST.myself##XFA.addBookmark#"><img src="/assets/images/add_icon.gif" border="0" /></a></cfif>
		</h2>
		<ul>
			<cfloop from="1" to="#arrayLen(REQUEST.bookmarks)#" index="b">
				<cfset bookmark = REQUEST.bookmarks[b] />
				<li>
					<a href="#bookmark.getUrl()#" target="_blank">#bookmark.getName()#</a>
					<cfif REQUEST.security.isRole('admin')>
						<a href="#REQUEST.myself##XFA.editBookmark#&bookmarkID=#bookmark.getBookmarkID()#"><img src="/assets/images/edit_icon.gif" border="0" /></a>
						<a href="#REQUEST.myself##XFA.removeBookmark#&bookmarkID=#bookmark.getBookmarkID()#"><img src="/assets/images/delete_icon.gif" border="0" /></a>
					</cfif>
				</li>
			</cfloop>
		</ul>
	</div>
	<!-- site footer-->
	<div id="footer">
		<p>
			#REQUEST.content.footer#
			Copyright (c) 2006, Chris Scott, Matt Woodward, Adam Wayne Lehman, Dave Ross. All rights reserved.
			<a href="mailto:#APPLICATION.settings.blog.email.webmaster#"><img src="/assets/images/email_icon.gif" border="0" /></a>
		</p>
	</div>
</div>

</cfoutput>

</body>
</html>


