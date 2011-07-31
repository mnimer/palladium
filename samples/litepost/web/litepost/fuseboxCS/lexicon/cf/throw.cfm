<!--------------------------------------------------------------------
	FB50 Lexicon: cf:throw
	
	Copyright:	(c) 2006, by Adam Wayne Lehman (adrocknaphobia.com). You are free to use this FB50 lexicon and to modify it as long as you keep on rocking!
	Usage:		1. Add the follwing lexicon declaration to the circuit.xml.cfm file
					<circuit xmlns:cf="cf/">
				2. Use the verb in a fuseaction
					<cf:throw type="" message="" detail="" errorCode="" extendedInfo="" object="" />
	Overview:	Custom verb that compiles to a <cfthrow> tag.
---------------------------------------------------------------------->

<cfscript>
	if (fb_.verbInfo.executionMode is "start") {
		// All attributes are optional - set defaults
		fb_.type = '';
		fb_.message = '';
		fb_.detail = '';
		fb_.errorcode = '';
		fb_.extendedinfo = '';
		fb_.object = '';
		
		// Type
		if (structKeyExists(fb_.verbInfo.attributes,"type"))
		{
			fb_.type = ' type="#fb_.verbInfo.attributes.type#"';
		}
		// Message
		if (structKeyExists(fb_.verbInfo.attributes,"message"))
		{
			fb_.message = ' message="#fb_.verbInfo.attributes.message#"';
		}
		// Detail
		if (structKeyExists(fb_.verbInfo.attributes,"detail"))
		{
			fb_.detail = ' detail="#fb_.verbInfo.attributes.detail#"';
		}
		// Error Code
		if (structKeyExists(fb_.verbInfo.attributes,"errorcode"))
		{
			fb_.errorcode = ' errorcode="#fb_.verbInfo.attributes.errorcode#"';
		}
		// Extended Info
		if (structKeyExists(fb_.verbInfo.attributes,"extendedinfo"))
		{
			fb_.extendedinfo = ' extendedinfo="#fb_.verbInfo.attributes.extendedinfo#"';
		}
		// Object
		if (structKeyExists(fb_.verbInfo.attributes,"object"))
		{
			fb_.object = ' object="#fb_.verbInfo.attributes.object#"';
		}

		// generate tag
		fb_appendLine('<cfthrow#fb_.type##fb_.message##fb_.detail##fb_.errorcode##fb_.extendedinfo##fb_.object#>');
	} else {
		//
		// end mode - do nothing
	}
</cfscript>