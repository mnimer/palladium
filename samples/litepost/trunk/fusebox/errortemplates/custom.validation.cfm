<cfsavecontent variable="REQUEST.content.body">
	<cfoutput>
	<div id="error">
		<h3>#CFCATCH.message#</h3>
		<p>#CFCATCH.detail#</p>
	</div>
	<button tyle="button" onclick="window.history.go(-1);">Back</button>
	</cfoutput>
</cfsavecontent>

<cfinclude template="../layout/lay_main.cfm" />

<cfabort />