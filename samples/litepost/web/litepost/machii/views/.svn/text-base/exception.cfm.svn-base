<!--- 
	  
  Copyright (c) 2006, Chris Scott, Matt Woodward, Adam Wayne Lehman, Dave Ross
  All rights reserved.
	
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  
       http://www.apache.org/licenses/LICENSE-2.0
  
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

$Id: $
--->

<cfset variables.exception = event.getArg("exception") />

<h3>Mach-II Exception</h3>

<cfoutput>
<table>
	<tr>
		<td valign="top"><strong>Message</strong></td>
		<td valign="top">#variables.exception.getMessage()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Detail</strong></td>
		<td valign="top">#variables.exception.getDetail()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Extended Info</strong></td>
		<td valign="top">#variables.exception.getExtendedInfo()#</td>
	</tr>
	<tr>
		<td valign="top"><strong>Tag Context</strong></td>
		<td valign="top">
			<cfset variables.tagCtxArr = variables.exception.getTagContext() />
			<cfloop index="i" from="1" to="#ArrayLen(variables.tagCtxArr)#">
				<cfset variables.tagCtx = variables.tagCtxArr[i] />
				#variables.tagCtx['template']# (#variables.tagCtx['line']#)<br>
			</cfloop>
		</td>
	</tr>
</table>
</cfoutput>