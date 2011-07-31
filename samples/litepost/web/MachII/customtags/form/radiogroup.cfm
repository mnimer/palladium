<cfsetting enablecfoutputonly="true" />
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

Author: Matt Woodward (matt@mach-ii.com)
$Id: radiogroup.cfm 2037 2009-12-23 04:43:02Z peterfarrell $

Created version: 1.8.0
Updated version: 1.8.0

Notes:
- REQUIRED ATTRIBUTES
	items		= [list]|[struct]|[query]|[array]
--->

<cfimport prefix="form" taglib="/MachII/customtags/form/" />

<cfif thisTag.ExecutionMode IS "start">

	<!--- Setup the tag --->
	<cfinclude template="/MachII/customtags/form/helper/formTagBuilder.cfm" />
	<cfset setupTag("radiogroup", true) />

	<!--- Ensure certain attributes are defined --->
	<cfset ensurePathOrName() />
	<cfset ensureByName("items") />
	
	<!--- Resolve path if defined--->
	<cfif StructKeyExists(attributes, "path")>
		<cfparam name="attributes.checkValue" type="string" 
			default="#wrapResolvePath(attributes.path)#" />
	<cfelse>
		<cfset attributes.path = "" />
		<cfparam name="attributes.checkValue" type="string" 
			default="" />
	</cfif>
	
	<!--- Set optional attributes --->
	<cfset attributes.name = resolveName() />
	<cfparam name="attributes.delimiter" type="string"
		default="," />
	<cfparam name="attributes.valueCol" type="string"
		default="value" />
	<cfparam name="attributes.labelCol" type="string"
		default="label" />
	<cfparam name="attributes.valueKey" type="string"
		default="value" />
	<cfparam name="attributes.labelKey" type="string"
		default="label" />
	<cfparam name="attributes.displayOrder" type="string"
		default="" />

<cfelse>
	<cfset originalGeneratedContent = thisTag.GeneratedContent />
	<cfset thisTag.GeneratedContent = "" />

	<!--- Create a crazy outbuffer struct so we can pass by reference --->
	<cfset variables.outputBuffer = StructNew() />
	<cfset variables.outputBuffer.content = "" />
	
	<cfif not StructKeyExists(attributes, "labels") 
			and (IsSimpleValue(attributes.items) 
				or (IsArray(attributes.items) 
					and IsSimpleValue(attributes.items[1])))>
		<cfset attributes.labels = attributes.items />
	</cfif>
	
	<!--- doing this here so we can add checked to the attributes 
			being passed to the radio custom tag as needed instead 
			of having to repeat the entire tag in conditionals --->
	<cfset radioAttributes = StructCopy(attributes) />
	
	<cfif IsSimpleValue(attributes.items)>
		<cfloop index="i" from="1" to="#ListLen(attributes.items, attributes.delimiter)#">
			<cfif StructKeyExists(attributes, "checkValue") and 
					attributes.checkValue eq ListGetAt(attributes.items, i, attributes.delimiter)>
				<cfset radioAttributes.checked = true />
			<cfelse>
				<cfset StructDelete(radioAttributes, "checked", false) />
			</cfif>
			
			<cfset radioAttributes.value = ListGetAt(attributes.items, i, attributes.delimiter) />
			
			<form:radio attributeCollection="#radioAttributes#" 
				output="true" 
				outputBuffer="#variables.outputBuffer#" />
			
			<cfset finalOutput = ReplaceNoCase(originalGeneratedContent, "${output.radio}", variables.outputBuffer.content) />
			<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.label}", ListGetAt(attributes.labels, i, attributes.delimiter))/>
			<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.id}", attributes.name & "_" & createCleanId(ListGetAt(attributes.items, i, attributes.delimiter))) />
			
			<cfset variables.outputBuffer.content = "" />
			
			<cfoutput>#finalOutput#</cfoutput>
		</cfloop>
	<cfelseif IsArray(attributes.items)>
		<cfif attributes.items.getDimension() eq 1>
			<cfif IsSimpleValue(attributes.items[1])>
				<cfloop from="1" to="#ArrayLen(attributes.items)#" index="i">
					<cfif StructKeyExists(attributes, "checkValue") and 
							attributes.checkValue eq attributes.items[i]>
						<cfset radioAttributes.checked = true />
					<cfelse>
						<cfset StructDelete(radioAttributes, "checked", false) />
					</cfif>
					
					<cfset radioAttributes.value = attributes.items[i] />
					
					<form:radio attributeCollection="#radioAttributes#" 
						output="true" 
						outputBuffer="#variables.outputBuffer#" />
					
					<cfset finalOutput = ReplaceNoCase(originalGeneratedContent, "${output.radio}", variables.outputBuffer.content) />
					<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.label}", attributes.labels[i]) />
					<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.id}", attributes.name & "_" & createCleanId(attributes.items[i])) />
					
					<cfset variables.outputBuffer.content = "" />
					
					<cfoutput>#finalOutput#</cfoutput>
				</cfloop>
			<cfelseif IsStruct(attributes.items[1])>
				<cfloop from="1" to="#ArrayLen(attributes.items)#" index="i">
					<cfif StructKeyExists(attributes, "checkValue") and 
							attributes.checkValue eq attributes.items[i][attributes.valueKey]>
						<cfset radioAttributes.checked = true />
					<cfelse>
						<cfset StructDelete(radioAttributes, "checked", false) />
					</cfif>
					
					<cfset radioAttributes.value = attributes.items[i][attributes.valueKey] />
					
					<form:radio attributeCollection="#radioAttributes#" 
						output="true" 
						outputBuffer="#variables.outputBuffer#" />

					<cfset finalOutput = ReplaceNoCase(originalGeneratedContent, "${output.radio}", variables.outputBuffer.content) />
					<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.label}", attributes.items[i][attributes.labelKey]) />
					<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.id}", attributes.name & "_" & createCleanId(attributes.items[i][attributes.valueKey])) />
					
					<cfset variables.outputBuffer.content = "" />
					
					<cfoutput>#finalOutput#</cfoutput>
				</cfloop>
			<cfelse>
				<cfthrow type="MachII.customtags.form.radiogroup.unsupportedItemsDatatype" 
						message="Unsupported Data Type in Array" 
						detail="The radio group form tag only supports simple values or structs as array elements." />
			</cfif>
		<cfelse>
			<cfthrow type="MachII.customtags.form.radiogroup.unsupportedItemsDatatype" 
					message="Unsupported Number of Array Dimensions in Radio Group Tag" 
					detail="The radio group form tag only supports arrays of 1 dimension. Array values may be either simple values or structs. The array you passed to the tag is #attributes.items.getDimension()# dimensions." />
		</cfif>
	<cfelseif IsStruct(attributes.items)>
		<cfset sortedKeys = sortStructByDisplayOrder(attributes.items, attributes.displayOrder) />
		
		<!--- struct key is value, struct value is label --->
		<cfloop index="i" from="1" to="#ArrayLen(sortedKeys)#">
			<cfif StructKeyExists(attributes, "checkValue") 
					and attributes.checkValue eq sortedKeys[i]>
				<cfset radioAttributes.checked = true />
			<cfelse>
				<cfset StructDelete(radioAttributes, "checked", false) />
			</cfif>
			
			<cfset radioAttributes.value = sortedKeys[i] />
			
			<form:radio attributeCollection="#radioAttributes#" 
				output="true" 
				outputBuffer="#variables.outputBuffer#" />
			
			<cfset finalOutput = ReplaceNoCase(originalGeneratedContent, "${output.radio}", variables.outputBuffer.content) />
			<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.label}", attributes.items[sortedKeys[i]]) />
			<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.id}", attributes.name & "_" & createCleanId(sortedKeys[i])) />
			
			<cfset variables.outputBuffer.content = "" />
			
			<cfoutput>#finalOutput#</cfoutput>
		</cfloop>
	<cfelseif IsQuery(attributes.items)>
		<cfloop query="attributes.items">
			<cfif StructKeyExists(attributes, "checkValue") 
					and attributes.checkValue eq attributes.items[attributes.valueCol][attributes.items.CurrentRow]>
				<cfset radioAttributes.checked = true />
			<cfelse>
				<cfset StructDelete(radioAttributes, "checked", false) />
			</cfif>
			
			<cfset radioAttributes.value = attributes.items[attributes.valueCol][attributes.items.CurrentRow] />
			
			<form:radio attributeCollection="#radioAttributes#" 
				output="true" 
				outputBuffer="#variables.outputBuffer#" />
			
			<cfset finalOutput = ReplaceNoCase(originalGeneratedContent, "${output.radio}", variables.outputBuffer.content) />
			<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.label}", attributes.items[attributes.labelCol][attributes.items.CurrentRow]) />
			<cfset finalOutput = ReplaceNoCase(finalOutput, "${output.id}", attributes.name & "_" & createCleanId(attributes.items[attributes.valueCol][attributes.items.CurrentRow])) />
			
			<cfset variables.outputBuffer.content = "" />
			
			<cfoutput>#finalOutput#</cfoutput>
		</cfloop>
	<cfelse>
		<cfthrow type="MachII.customtags.form.radiogroup.unsupportedItemsDatatype" 
					message="Unsupported datatype for the 'items' attribute." 
					detail="The radio group form tag only supports lists, arrays, structs, and queries." />
	</cfif>

	<cfif attributes.output>
		<cfset thisTag.GeneratedContent = "" />
		<cfset appendGeneratedContentToBuffer(variables.outputBuffer.content, attributes.outputBuffer) />
	<cfelse>
		<cfset thisTag.GeneratedContent = variables.outputBuffer.content />
	</cfif>
</cfif>
<cfsetting enablecfoutputonly="false" />