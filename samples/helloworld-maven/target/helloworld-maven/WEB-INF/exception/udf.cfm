<!--- Import L10N Taglib (System Generated) 
<cfimport prefix="admin" taglib="../../CFIDE/administrator/cftags/">
--->
<!--- /**
 * Encode the given string
 * @param - 
 * @return Returns Encoded value of given string
 * @author Shilpi Khariwal (shilpik@adobe.com)
 * @version 1,  6/12/2010
 */ --->
<cffunction name="encodeForError" output="false">
	<cfargument name="str" required="true">
	<cftry>
			<cfset var str2="#replace(str,"\","/","ALL")#">
			<cfset var encodedStr=EncodeForHTML(str2)>
		<cfcatch type="Any">
			<cfoutput>
				<admin:l10n id="error_verify" var="verify_err">
					#EncodeForHTML(CFCATCH.Message)#
					#EncodeForHTML(CFCATCH.Detail)#
				</admin:l10n>
			</cfoutput>
			<cfthrow message="#verify_err#">
		</cfcatch>
	</cftry>
	<cfreturn encodedStr>
</cffunction>
<!--- /**
 * Encode the given string excluding following html 
 * <li>, <p>, <ul>, <ol>, <pre>, <br>, <br/>, <b>, <i>, </i>, </b>, </pre>, </ol>, </ul>, </li>, </p>
 * Bug 86551 -> read the bug before making any change to this function or its usage.
 * @param - 
 * @return Returns Encoded value of given string
 * @author Shilpi Khariwal (shilpik@adobe.com)
 * @version 1,  3/3/2011
 */ --->
<cffunction name="encodeForErrorSmart" output="false">
	<cfargument name="str" required="true">
	<cfset var str2 = "">
	<cfset var encodedStr = "">
	<cftry>
			<cfset str2="#replace(str,"\","/","ALL")#">

			<cfset str2="#ReplaceNoCase(str2,"<br>","HTMLBREAK","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<br/>","HTML1BREAK","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<b>","HTMLBOLD","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<i>","HTMLITAL","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<p>","HTMLPARA","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<pre>","HTMLPRE","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<ul>","HTMLUNORDERLIST","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<li>","HTMLLIST","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"<ol>","HTMLORDERLIST","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</b>","HTMLCLOSEBOLD","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</i>","HTMLCLOSEITAL","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</p>","HTMLCLOSEPARA","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</pre>","HTMLCLOSEPRE","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</ul>","HTMLCLOSEUNORDERLIST","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</li>","HTMLCLOSELIST","ALL")#">
			<cfset str2="#ReplaceNoCase(str2,"</ol>","HTMLCLOSEORDERLIST","ALL")#">

			<cfset encodedStr=EncodeForHTML(str2)>

			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLBREAK","<br>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTML1BREAK","<br/>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLBOLD","<b>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLITAL","<i>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLPARA","<p>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLPRE","<pre>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLUNORDERLIST","<ul>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLLIST","<li>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLORDERLIST","<ol>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSEBOLD","</b>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSEITAL","</i>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSEPARA","</p>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSEPRE","<pre>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSEUNORDERLIST","</ul>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSELIST","</li>","ALL")#">
			<cfset encodedStr="#ReplaceNoCase(encodedStr,"HTMLCLOSEORDERLIST","</ol>","ALL")#">
			
		<cfcatch type="Any">
			<cfoutput>
				<admin:l10n id="error_verify" var="verify_err">
					#EncodeForHTML(CFCATCH.Message)#
					#EncodeForHTML(CFCATCH.Detail)#
				</admin:l10n>
			</cfoutput>
			<cfthrow message="#verify_err#">
		</cfcatch>
	</cftry>
	<cfreturn encodedStr>
</cffunction>

