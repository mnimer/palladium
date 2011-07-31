<cfsilent>
<!---

    Mach-II - A framework for object oriented MVC web applications in CFML
    Copyright (C) 2003-2009 GreatBizTools, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Author: Peter J. Farrell (peter@mach-ii.com)
$Id: defaultOutputTemplate.cfm 1892 2009-11-05 05:01:27Z peterfarrell $

Created version: 1.6.0
Updated version: 1.8.0

Notes:
You must use the 'local' prefix for all variables created in this template 
since this display template is rendered inside a *non-thread safe* CFC
unlike using views in ViewContext.

*** WARNING ***
Not using the 'local' prefix will cause concurency errors due 
to multiple threading.
*** WARNING ***

If you are creating a custom output template and using custom CSS, create a
reference to your CSS in the local.headElement variable and the MachIILogger will
automatically put your CSS in the head section via <cfhtmlhead />
--->
	<cfimport prefix="view" taglib="/MachII/customtags/view" />
	<cfset local.headElement = "" />
	<cfset local.cfdumpData = "" />
	<cfset local.hasAppendedHeadElementFromCfdump = false />
	<cfset local.i = 1 />
	<cfset local.cookieRow = 1 />
</cfsilent>
<cfoutput>
<cfsavecontent variable="local.headElement">
<view:style outputType="inline">
	##MachIIRequestLogDisplay {
		color: ##000;
		background-color: ##FFF;
		text-align: left;
		padding: 1em;
	}
	##MachIIRequestLogDisplay h3 {
		color: ##000;
	}
	##MachIIRequestLogDisplay table {
		margin: 1em 0 1em 0;
		width:100%;
	}
	##MachIIRequestLogDisplay table td {
		vertical-align: top;
	}
	##MachIIRequestLogDisplay table th {
		padding: 0.5em;
		color: ##FFF;
		background-color: ##999;
		border-top: 1px solid ##666;
		border-bottom: 1px solid ##666; 
	}
	##MachIIRequestLogDisplay table th h3 {
		margin: 0;
		color: ##FFF; 
	}
	##MachIIRequestLogDisplay table td {
		padding: 0.5em;
		border-top: 1px dotted ##D0D0D0;
		border-bottom: 1px dotted ##D0D0D0;
	}
	##MachIIRequestLogDisplay table td h4{
		padding: 0.5em;
	}
	##MachIIRequestLogDisplay table td.lineBottom {
		border-bottom: 1px dotted ##666;
	}
	##MachIIRequestLogDisplay table td.lineTop {
		border-top: 1px dotted ##666;
	}
	##MachIIRequestLogDisplay .shade {
		background-color: ##F5F5F5;
	}
	##MachIIRequestLogDisplay ul li {
		margin-left:15px;
	}
	##MachIIRequestLogDisplay .small {
		font-size: 0.9em;
	}
	##MachIIRequestLogDisplay .right {
		text-align: right;
	}
	##MachIIRequestLogDisplay .fatal {
		color: ##FFF;
		background-color: ##FF9999;
		font-weight: bold;
	}
	##MachIIRequestLogDisplay .error {
		background-color: ##FFCC66;
		font-weight: bold;
	}
	##MachIIRequestLogDisplay .warn {
		background-color: ##FFFF99;
		font-weight: bold;
	}
	##MachIIRequestLogDisplay .info {
		background-color: ##CCFF99;
		font-weight: bold;
	}
	##MachIIRequestLogDisplay .strong {
		font-weight: bold;
	}
</view:style>
</cfsavecontent>
<div id="MachIIRequestLogDisplay">
	<table>
		<tr>
			<th style="width:30%;"><h3>Channel</h3></th>
			<th style="width:10%;"><h3>Log Level</h3></th>
			<th style="width:50%;"><h3>Message</h3></th>
			<th style="width:10%;"><h3>Timing</h3></th>
		</tr>
	<cfif ArrayLen(data)>
		<cfloop from="1" to="#ArrayLen(data)#" index="local.i">
			<tr class="<view:flip value="#local.i#" items="shade" /> #data[local.i].logLevelName#">
				<td><p>#data[local.i].channel#</p></td>
				<td><p>#data[local.i].logLevelName#</p></td>
				<td><p>#HtmlEditFormat(data[local.i].message)#</p></td>
				<td><p class="right"><cfif local.i NEQ ArrayLen(data)>#data[local.i + 1].currentTick - data[local.i].currentTick#<cfelse>0</cfif></p></td>
			</tr>
			<cfif NOT IsSimpleValue(data[local.i].additionalInformation) OR (IsSimpleValue(data[local.i].additionalInformation) AND Len(data[local.i].additionalInformation))>
			<tr>
				<td colspan="4">
					<cfset local.cfdumpData = processCfdump(data[local.i].additionalInformation) />
					#local.cfdumpData.data#
					<cfif NOT local.hasAppendedHeadElementFromCfdump>
						<cfset local.headElement = local.headElement & local.cfdumpData.headElement />
						<cfset local.hasAppendedHeadElementFromCfdump = true />
					</cfif>
				</td>
			</tr>
			</cfif>
		</cfloop>
		<cfif ArrayLen(data) GT 1>
			<tr>
				<td class="lineTop lineBottom" colspan="3"><h3 class="right">First / Last Message Timing Difference (ms)</h3></td>
				<td class="lineTop lineBottom"><h3 class="right">#data[ArrayLen(data)].currentTick - data[1].currentTick#</h3></td>
			</tr>
		</cfif>
	<cfelse>
		<tr>
			<td colspan="4"><p><em>No messages available</em></p></td>
		</tr>
	</cfif>
	</table>

	<table>
		<tr>
			<th colspan="2"><h3>Request Information</h3></th>
		</tr>
		<tr class="shade">
			<td style="width:20%;"><h4>Request Event Name</h4></td>
			<td style="width:80%;"><p>#arguments.appManager.getRequestHandler().getRequestEventName()#</p></td>
		</tr>
		<tr>
			<td><h4>Request Module Name</h4></td>
			<td>
			<cfif Len(arguments.appManager.getRequestHandler().getRequestModuleName())>
				<p>#arguments.appManager.getRequestHandler().getRequestModuleName()#</p>
			<cfelse>
				<p><em>Base Application</em></p>
			</cfif>
			</td>
		</tr>
		<tr class="shade">
			<td><h4>Mach-II Version</h4></td>
			<td><p>#getMachIIVersion(arguments.appManager.getPropertyManager().getVersion())#</p></td>
		</tr>
		<tr>
			<td><h4>Mach-II Environment Name</h4></td>
			<td><p>#arguments.appManager.getEnvironmentName()#</p></td>
		</tr>
		<tr class="shade">
			<td><h4>Mach-II Environment Group Name</h4></td>
			<td><p>#arguments.appManager.getEnvironmentGroup()#</p></td>
		</tr>
		<tr>
			<td><h4>Timestamp</h4></td>
			<td><p>#DateFormat(Now())# #TimeFormat(Now())#</p></td>
		</tr>
		<tr class="shade">
			<td><h4>Remote IP</h4></td>
			<td><p>#cgi.remote_addr#</p></td>
		</tr>
		<tr>
			<td><h4>Remote User Agent</h4></td>
			<td><p>#cgi.http_user_agent#</p></td>
		</tr>
		<tr class="shade">
			<td><h4>Locale</h4></td>
			<td><p>#getLocale()#</p></td>
		</tr>
	</table>

	<table>
		<tr>
			<th colspan="2"><h3>Cookies</h3></th>
		</tr>
	<cfloop collection="#cookie#" item="local.i">
		<tr class="<view:flip value="#local.cookieRow#" items="shade" />">
			<td style="width:20%;"><h4>#local.i#</h4></td>
			<td style="width:80%;"><p>#HtmlEditFormat(cookie[local.i])#</p></td>
		</tr>
		<cfset local.cookieRow = local.cookieRow + 1 />
	</cfloop>
	</table>
</div>
</cfoutput>