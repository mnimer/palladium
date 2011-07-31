<!-----------------------------

Error message

------------------------------>
<cfsavecontent variable="REQUEST.content.body">
<cfoutput>
	<div id="error">
		<h3>#CFCATCH.message#</h3>
		<p>#CFCATCH.detail# (#CFCATCH.type#)</p>
	</div>
	<button tyle="button" onclick="window.history.go(-1);">Back</button>
</cfoutput>
</cfsavecontent>

<cftry>
	<cfinclude template="../layout/lay_main.cfm" />
	<cfcatch type="any">
		<cfoutput>#REQUEST.content.body#</cfoutput>
	</cfcatch>
</cftry>


<cfabort/>