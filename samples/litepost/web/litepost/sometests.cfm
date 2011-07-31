
<cfset bf = createObject("component","coldspring.beans.DefaultXmlBeanFactory").init()/>
<!--- load the bean defs --->
<cfset bf.loadBeansFromXmlFile(expandPath('./config/litepost-services.xml'))/>

<cfset bookmarkService = bf.getBean("bookmarkService") />

<cfset bookmarks = bookmarkService.getBookmarks() />

<cfset bookmark = CreateObject("component", "net.litepost.component.bookmark.Bookmark").init() />
<cfset bookmark.setName("test bookmark 2")/>
<cfset bookmark.setUrl("www.testTwo.com")/>
<cfset bookmarkID = bookmarkService.saveBookmark(bookmark) />
<cfset bookmark = bookmarkService.getBookmarkById(bookmarkID) />
<cfset bookmark.setName("xxx")/>
<cfset bookmarkID = bookmarkService.saveBookmark(bookmark) />

<cfoutput>
	New Bookmark: #bookmarkID# - #bookmark.getName()#<br/>
	<cfloop from="1" to="#ArrayLen(bookmarks)#" index="i">
		#bookmarks[i].getName()# : #bookmarks[i].getUrl()#<br/>
	</cfloop>
</cfoutput>

<cfset bookmarkService.removeBookmark(bookmarkID) />

<cfset categoryService = bf.getBean("categoryService") />

<cfset category = CreateObject("component", "net.litepost.component.category.Category").init() />
<cfset category.setCategory("test category")/>
<cfset categoryID = variables.categoryService.saveCategory(category) />
<cfset category = variables.categoryService.getCategoryByID(categoryID) />

<cfset categories = categoryService.getCategoriesWithCounts() />

<cfoutput>
	New Category: #categoryID# - #category.getCategory()#<br/>
	<cfloop from="1" to="#ArrayLen(categories)#" index="i">
		#categories[i].getCategory()# : #categories[i].getNumPosts()#<br/>
	</cfloop>
</cfoutput>

<cfset variables.categoryService.removeCategory(categoryID) />
