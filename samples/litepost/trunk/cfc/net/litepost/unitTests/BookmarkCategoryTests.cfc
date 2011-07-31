<cfcomponent displayname="BookmarkCategoryTests" 
			hint="test bookmark and category service methods" 
			extends="org.cfcunit.framework.TestCase">
	
	<cffunction name="setUp" access="private" returntype="void" output="false">
		<cfset var path = GetDirectoryFromPath(getMetaData(this).path) />
		<cfset var bf = 0 />
		<cfset var bean = 0 />
		
		<cfset variables.sys = CreateObject('java','java.lang.System') />
	
		<cfset variables.sys.out.println("Loading bean factory...") />
		<!--- create a new bean factory --->
		<cfset bf = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
		<!--- load the bean defs --->
		<cfset bf.loadBeansFromXmlFile(path&'/litepost-services.xml')/>
		
		<cfset variables.sys.out.println("Loading services") />

		<cfset variables.sys.out.println("categoryService...") />
		<cfset variables.categoryService = bf.getBean("categoryService") />
		<cfset variables.sys.out.println("bookmarkService...") />
		<cfset variables.bookmarkService = bf.getBean("bookmarkService") />
		
	</cffunction>
	
	<cffunction name="testBookmarkServiceMethods" access="public" returntype="void" output="false">
		
		<cfset var bookmark = 0 />
		<cfset var bookmarks = variables.bookmarkService.getBookmarks() />
		<cfset var bookmarkID = 0 />
		<cfset var bookmarkName = "" />
		<cfset var bookmarkURL = "" />
		
		<cfset bookmark = CreateObject("component", "net.litepost.component.bookmark.Bookmark").init() />
		<cfset bookmark.setName("test bookmark")/>
		<cfset bookmark.setUrl("www.test.com")/>
		<cfset bookmarkName = bookmark.getName() />
		<cfset bookmarkURL = bookmark.getUrl() />
		
		<!--- make sure service retuned a query --->
		<cfset assertTrue(IsArray(bookmarks), "getBookmarks() did not return an array!")/>
		<cfset variables.sys.out.println("getBookmarks() returned #ArrayLen(bookmarks)# Bookmark") />
		
		<!--- save bookmark, fetch new one, compare values --->
		<cfset bookmarkID = variables.bookmarkService.saveBookmark(bookmark) />
		<!--- make sure that returned an id --->
		<cfset assertTrue(bookmarkID, "saveBookmark() did not return a new ID!")/>
		<cfset variables.sys.out.println("saveBookmark() created new bookmark with ID: #bookmarkID#") />
		
		<cfset bookmark = variables.bookmarkService.getBookmarkById(bookmarkID) />
		<cfset variables.sys.out.println("getBookmarkById(#bookmarkID#) returned: #bookmark.getName()# : #bookmark.getUrl()#") />
		<!--- make sure the bookmark we just retrieved was the one we saved --->
		<cfset assertEqualsString(bookmark.getName(), bookmarkName, "Bookmark names do not match!")/>
		<cfset assertEqualsString(bookmark.getUrl(), bookmarkURL, "Bookmark URLs do not match!")/>
		
		<!--- test an update ---> 
		<cfset bookmark.setName("xxx")/>
		<cfset bookmarkID = variables.bookmarkService.saveBookmark(bookmark) />
		<cfset assertEqualsNumber(bookmark.getBookmarkID(), bookmarkID, "Bookmark IDs do not match!")/>
		
		<!--- now we need to delete it! --->
		<cfset variables.bookmarkService.removeBookmark(bookmarkID) />
	</cffunction>
	
	<cffunction name="testCategoryServiceMethods" access="public" returntype="void" output="false">
		
		<cfset var categories = variables.categoryService.getCategories() />
		<cfset var category = CreateObject("component", "net.litepost.component.category.Category").init() />
		<cfset var categoryID = 0 />
		<cfset var name = "" />
		<cfset var numPosts = "" />
		
		<cfset category.setCategory("test category")/>
		<cfset name = category.getCategory() />
		
		<!--- make sure service retuned a query --->
		<cfset assertTrue(IsArray(categories), "getCategories() did not return an array!")/>
		<cfset variables.sys.out.println("getCategories() returned #ArrayLen(categories)# Categories") />
		
		<!--- save category, fetch new one, compare values --->
		<cfset categoryID = variables.categoryService.saveCategory(category) />
		<!--- make sure that returned an id --->
		<cfset assertTrue(categoryID, "saveCategory() did not return a new ID!")/>
		<cfset variables.sys.out.println("saveCategory() created new category with ID: #categoryID#") />
		
		<cfset category = variables.categoryService.getCategoryByID(categoryID) />
		<!--- make sure the category we just retrieved was the one we saved --->
		<cfset assertEqualsString(category.getCategory(), name, "Category names do not match!")/>
		
		<!--- now let's make sure the counts works --->
		<cfset categories = variables.categoryService.getCategoriesWithCounts() />
		<cfset assertTrue(IsArray(categories), "getCategoriesWithCounts() did not return an array!")/>
		<cfset variables.sys.out.println("getCategoriesWithCounts() returned #ArrayLen(categories)# Categories") />
		
		<cfif ArrayLen(categories)>
			<cfset variables.sys.out.println("#categories[1].getCategory()# has #categories[1].getNumPosts()# posts" ) />
		</cfif>
		
		<!--- test an update --->
		<cfset category.setCategory("xxx")/>
		<cfset categoryID = variables.categoryService.saveCategory(category) />
		<cfset assertEqualsNumber(category.getCategoryID(), categoryID, "Bookmark IDs do not match!")/>
		
		<!--- now we need to delete it! --->
		<cfset variables.categoryService.removeCategory(categoryID) />
	</cffunction>
	
</cfcomponent>