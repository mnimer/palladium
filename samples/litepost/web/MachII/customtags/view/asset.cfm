<cfsetting enablecfoutputonly="true" /><cfsilent>
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
$Id: asset.cfm 1892 2009-11-05 05:01:27Z peterfarrell $

Created version: 1.8.0
Updated version: 1.8.0

Notes:
- OPTIONAL ATTRIBUTES
	package		= A list or array of the asset packages names to add.
	outputType	= Indicates tthe output type for the generated HTML code (head, inline). Defaults to "head".
--->
<cfif thisTag.ExecutionMode IS "start">
	<!--- Setup the tag --->
	<cfinclude template="/MachII/customtags/view/helper/viewTagBuilder.cfm" />
	<cfset setupTag("asset", true) />	

	<!--- Setup required --->
	<cfset ensureByName("package") />
	
	<!--- Setup optional --->
	<cfparam name="attributes.outputType" type="string" 
		default="head" />
<cfelse>
	<cfset thisTag.GeneratedContent = locateHtmlHelper().addAssetPackage(attributes.package, attributes.outputType) />
</cfif>
</cfsilent><cfsetting enablecfoutputonly="false" />