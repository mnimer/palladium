
<cfimport taglib="../.." prefix="ex">
<ex:detail error=#error#>

<cfoutput>

<cfif left(error.tagName,3) is "cf_">
<p>
You are trying to call an unknown ColdFusion custom tag.  <B>NOTE</B> 
If the tag you are calling exists but has compiler errors, it may
be reported incorrectly as "not found".  This is already filed as a bug.

</p>
<cfelseif left(error.tagName,4) is "cfx_">
<p>
You are attempting to call an unknown or unregistered CFX custom tag.
Native CFX custom tags are registered by editing
#ExpandPath("/WEB-INF/web.xml")#
</p>
<cfelseif left(error.tagName,2) is "cf">
<p>
A tag starting with 'CF' has been detected. This tag is not supported by this version of ColdFusion. 
Please verify your typo and try again.
</p>
<cfelse>
<p>
The tag you are trying to use cannot be found within any tag
libraries you have imported.
</P>
</cfif>

</cfoutput>
</ex:detail>
