<cfparam name="ATTRIBUTES.entryID" default="0" />

<cfoutput>
<form action="#REQUEST.myself##XFA.submit#" method="post">
	<div>
		<label>Comment <textarea name="comment"></textarea></label>
	</div>
	<div>
		<label>Your Name <input type="text" name="name" /></label>
	</div>
	<div>
		<label>Email Address <input type="text" name="email" /></label>
	</div>
	<div>
		<label>Web Site <input type="text" name="url" /></label>
	</div>
	<div>
		<button type="submit">Submit</button>
	</div>
	<input type="hidden" name="entryID" value="#ATTRIBUTES.entryID#" />
</form>
</cfoutput>