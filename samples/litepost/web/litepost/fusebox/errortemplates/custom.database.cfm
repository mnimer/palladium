<cfsavecontent variable="REQUEST.content.body">
	<cfoutput>
		<h1>A error has occured!</h1>
		<p>
			<cfif myFuseBox.getApplication().debug>
				#CFCATCH.detail# <br />
				#CFCATCH.ExtendedInfo# <br />
				<cfset tagCtxArr = CFCATCH.TagContext />
				<cfloop index="i" from="1" to="#ArrayLen(tagCtxArr)#">
					<cfset tagCtx = tagCtxArr[i] />
					#tagCtx['template']# (#tagCtx['line']#)<br>
				</cfloop>
			<cfelse>
				#CFCATCH.message#
			</cfif>
		</p>
	</cfoutput>
</cfsavecontent>

<cfinclude template="../layout/lay_main.cfm" />

<cfabort />