<!-----------------------------

System message

------------------------------>
<cfoutput>
	<div id="message">
		<h3>#title#</h3>
		<p>#message#</p>
	</div>
	<button type="button" onclick="location='#REQUEST.myself##forward#';" class="adminbutton">Ok</button>
</cfoutput>