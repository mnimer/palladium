<cfif IsDebugMode()>
<cfsilent>
<cfset startTime = getTickCount()>
<cfsetting enablecfoutputonly="Yes">
<cfscript>
formEncoding = getEncoding("FORM");
urlEncoding = getEncoding("URL");

setEncoding("FORM", formEncoding);
setEncoding("URL", urlEncoding);
</cfscript>
<!---
**
* CF5 Dockable Debugging Output 
*
* Author: Andre Lei
*
* 11.08.2001 - need to change all functions and div to cfdebug_
* 2002.Jul.16 - scope keys are now sorted
*
* Copyright (c) 2001 Macromedia.  All Rights Reserved.
* DO NOT REDISTRIBUTE THIS SOFTWARE IN ANY WAY WITHOUT THE EXPRESSED
* WRITTEN PERMISSION OF MACROMEDIA. 
--->

<!--- Localized strings --->
<cfset undefined = "[undefined]">

	<!--- Use the debugging service to check options --->
	<cftry>
		<cfobject action="CREATE" type="JAVA" class="coldfusion.server.ServiceFactory" name="factory">
		<cfset cfdebugger = factory.getDebuggingService()>
		<cfcatch type="Any"></cfcatch>
	</cftry>

	<!--- Load the debugging service's event table --->
	<cfset qEvents = cfdebugger.getDebugger().getData()>

	<!--- EVENT: SQL Queries --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_queries" debug="false">
	SELECT *, (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'SqlQuery'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<!--- EVENT: Object Queries --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_cfoql" debug="false">
	SELECT *, (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'ObjectQuery'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<!--- EVENT: Stored Procedures --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_storedproc" debug="false">
	SELECT *, (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'StoredProcedure'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<!--- EVENT: Trace Points --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_trace" debug="false">
	SELECT *, (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'Trace'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<!--- EVENT: CFTimer --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_timer" debug="false">
	SELECT *, (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'CFTimer'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>	
	
	<!--- EVENT: Exceptions --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_ex" debug="false">
	SELECT *
	FROM qEvents
	WHERE type = 'Exception'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<!--- EVENT: Total Execution Time --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_execution" debug="false">
	SELECT (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'ExecutionTime'
	</cfquery>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<cfset totalExecution = 0>
</cfsilent>

<cfscript>
//UDF - Handle Kojak output of complex data types.
function CFDebugSerializable(variable)
{
	var ret = "";
	
	if(IsSimpleValue(variable))
	{ 
		ret = variable;
	}
	else
	{
		if (IsStruct(variable))
		{
			ret = ("Struct (" & StructCount(variable) & ")");
		}
		else if(IsArray(variable))
		{
			ret = ("Array (" & ArrayLen(variable) & ")");
		}
		else if(IsQuery(variable))
		{
			ret = ("Query (" & variable.RecordCount & ")");
		}
		else
		{
			ret = ("Complex type");
		}
	}
	
	return ret;
}
// UDF - tree writing
function drawNode(nTree, indent, id, highlightThreshold) {
   var templateOuput = "";
   if( nTree[id].duration GT highlightThreshold ) {
       templateOutput = "<font color='red'><span class='template_overage'>(#nTree[id].duration#ms) " & nTree[id].template & " @ line " & #nTree[id].line# & "</span></font><br>";
   } else {
       templateOutput = "<span class='template'>(#nTree[id].duration#ms) " & nTree[id].template & " @ line " & #nTree[id].line# & "</span><br>";
   }
   writeOutput(repeatString("&nbsp;&nbsp;&middot;", indent + 1) & " <img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/arrow.gif' alt='arrow' border='0'><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/endDoc.gif' alt='top level' border='0'> " & templateOutput);
   return "";
}

function drawTree(tree, indent, id, highlightThreshold) {
   var alength = 1; 
   var i = 1;
   var templateOuput = "";

   // top level nodes (application.cfm,cgi.script_name,etc) have a -1 parent line number
   if(tree[id].line EQ -1) {
       writeoutput( "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " & "<span class='template'><b>(#Tree[id].duration#ms) " & Tree[id].template & "</b></span><br>" );
   } else {
       if( Tree[id].duration GT highlightThreshold ) {
           templateOutput = "<font color='red'><span class='template_overage'>(#Tree[id].duration#ms) " & Tree[id].template & " @ line " & #Tree[id].line# & "</span></font><br>";
       } else {
           templateOutput = "<span class='template'>(#Tree[id].duration#ms) " & Tree[id].template & " @ line " & #Tree[id].line# & "</span><br>";
       }
       writeoutput( repeatString("&nbsp;&nbsp;&middot;", indent + 1) & " <img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/arrow.gif' alt='arrow' border='0'><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/parentDoc.gif' alt='top level' border='0'> " & templateOutput );
   }

   if( isArray( tree[id].children ) and arrayLen( tree[id].children ) ) {
       alength = arrayLen( tree[id].children );
       for( i = 1; i lte alength; i = i + 1 ) {
           if( isArray(tree[id].children[i].children) and arrayLen( tree[id].children[i].children ) gt 0 ) {
               drawTree(tree, indent + 1, tree[id].children[i].templateid, highlightThreshold);
           } else {
               drawNode(tree, indent + 1, tree[id].children[i].templateid, highlightThreshold);
           }
       }
   } else {
       // single template, no includes?
       //drawNode(tree, indent + 1, tree[id].template, highlightThreshold);
   }
   return "";
}
</cfscript>

<cffunction name="sortedScope" output="false">
    <cfargument name="scope">
    <cfset retVal="">
    <cfset keys = structKeyArray(scope)>
    <cfset arraySort(keys,"text")>
    <cfloop index="x" from=1 to="#arrayLen(keys)#">
    	<cfset keyName = keys[x]>
        <cfset retVal = retVal & '<tr><td class="label">#keyName#</td><td class="label">'>
           <cftry>
    		    <cfset keyValue = CFDebugSerializable(scope[keyname])>
    		<cfcatch>
    			<cfset keyValue = "undefined">
           	</cfcatch>
      	    </cftry>
        <cfset retVal = retVal & keyValue & '</td></tr><tr><td colspan=2 height="1" class="itemdivider"></td></tr>'>
    </cfloop>
    <cfreturn retVal>
</cffunction>

<cfset imageDir = "#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/">
<cfoutput>
<!-------------------- BEGIN : DEBUG FOOTER STUFF -------------------->
<script language="javascript">
    if( "cf_debug_cf" != self.name ) {
        document.write("<br><br><br><span style='background-color:9EB5D0;font-weight:bold;font-family:sans-serif;font-size:.8em;'><a href='javascript:setDebugSource();'>&nbsp; debug this page &nbsp;</a></span>");
        // write "docked debug panel" or "floating debug panel"
        if( top == self ) { // currently floating, issues if user is in frameset
            document.write(" <a href='##' onClick='dockedMode(\"#getpageContext().getRequest().getContextPath()#/CFIDE/debug/cf_debugFr.cfm?userPage=#cgi.script_name#<cfif cgi.query_string NEQ "">?#cgi.query_string#</cfif>\");return false;' target='_top' style='background-color:DDDDD5;font-weight:bold;font-family:sans-serif;font-size:.8em;'>&nbsp; docked debug pane &nbsp;</a>");
        } else {
            document.write(" <a href='#cgi.script_name#' target='_top' style='background-color:DDDDD5;font-weight:bold;font-family:sans-serif;font-size:.8em;'>&nbsp; floating debug pane &nbsp;</a>");
        }
    }
</script>
<script language="javascript">
/*
-IE: default frame name = "main"
-NS6: default frame name = ""
-id="cf_debug" needs to be a <span> instead of <div>??? it chokes up on nav.html nav frame...but NS6 doesn't like <span>
-also when the frame loads, it tries to call debugFr.html??? and operation aborted?
-CAUTION: the above fails miserably because of <li> tags not being wrapped in <ul></ul> or <ol></ol>...only happens in IE, NS6 is ok

*/
var cf_debug_cf_win;
</script>

<!--- <script src="/CFIDE/debug/includes/cf_debug_main.js" language="javascript"></script> --->
<script language="javascript">
function cf_debug_init() {
    if( "cf_main_cf" == self.name || top == self ) {
        setDebugSource();
    }
}

function setDebugSource() {
    if( top.frames["cf_debug_cf"] ) {
        writeToWindow( top.frames["cf_debug_cf"] );
    } else if( cf_debug_cf_win != null && cf_debug_cf_win.document != null ) {
        writeToWindow( cf_debug_cf_win );
    } else {
        var winFeatures = '"width=300,height=300"';
        cf_debug_cf_win = window.open("","cf_debug_cf_win","width=400,height=400,resizable=yes,scrollbars=yes");
        writeToWindow( cf_debug_cf_win );
    }
}

function writeToWindow( win ) {
    if( document.getElementById ) { // NS6
        // failing on <table ... 100%> for unescape() ?, and failing on writeCSS without unescape(), no the issue is with ns6 writing out the <link> tag for css
        // NS6 needs unescape() or else it writes 'showHide%28%27cf_debug_parameters%27,%27img_cf_debug_parameters%27%29;' for methods
        //win.document.write(unescape(document.getElementById("cf_debug").innerHTML));
        //NS6.2 wants it escaped
        win.document.write(document.getElementById("cf_debug").innerHTML);
    } else {
       win.document.write(document.all['cf_debug'].innerHTML);
    }
    win.document.close();
    win.focus();
}

function dockedMode( dockedUserPage ) {
    top.location = dockedUserPage;
    if( cf_debug_cf_win ) {
        cf_debug_cf_win.close();
    }
}
</script>


<!-------------------- BEGIN : DEBUG INFO WRITTEN TO WINDOW -------------------->
<div id="cf_debug" style="display:none;">
<script language="javascript">
var debugMode = false;
var urlClicked = false;
if( "cf_debug_cf" == self.name || "cf_debug_cf_win" == self.name) {
    debugMode = true;
}

/* 
 * Changed imgObj to imgObjName to allow a link to control the tree as well
 */
function showHide( targetName, imgObjName ) {
    var target;
    var imgObj;
    if( imgObjName ) { 
        imgObj = eval("document." + imgObjName); 
    }
    
    if( document.getElementById ) { // NS6+
        target = document.getElementById(targetName);
    } else if( document.all ) { // IE4+
        target = document.all[targetName];
    }
    
    // only attempt the show hide if a target is found, could be looking at user's other cookie name that doesn't fit as a node name
    if( target ) {
        // IE & NS6 like 'none'/'block', a value is needed for the cookie
        if( target.style.display == "none" ) {
            target.style.display = "block";
            setCookie( targetName, "block" );
        } else {
            target.style.display = "none";
            setCookie( targetName, "none" );
        }
    }

    if( imgObj ) {
        var imgPath = imgObj.src;
        if( imgPath ) {
            imgPath = imgPath.substring(0,imgPath.lastIndexOf("/")) + "/";
            if( imgObj.src == imgPath + "close.gif" ) {
                imgObj.src = imgPath + "open.gif";
            } else {
                imgObj.src = imgPath + "close.gif";
            }
        }
    }
} // showHide

function nullifyWindow() {
    // for IE, set the cf_debug_cf_win to null so that it doesn't get into this wierd state with
        // IE - Error: The callee(server [not server application]) is not available or disappeared; all connections are invalid. The call did not execute.
        // IE complains that you opened up a new window 'cf_debug_cf_win' but now it can't find it, use 'cf_debug_cf_win.location' to see if the window is still open
        // cf_debug_cf_win.location at first: undefined
        // cf_debug_cf_win.location opened: some location
        // cf_debug_cf_win.location closed: [object] only
        // TRIED checking for cf_debug_cf_win.location.toString().length != 0, but couldn't get a reference even with short circuiting
    if( document.all && opener && debugMode ) {
        if( opener.cf_debug_cf_win ) {
            opener.cf_debug_cf_win = null;
        }
    }
}

function goToUrl() {
    //NS form tags cannot be between rows or else the elements won't register
    getCallerPage().location = document.forms[0].cf_debug_user_url.value;
    return false;
}

function clearUrlField( field ) {
    if( !urlClicked ) {
        field.value='http://';
        urlClicked = true;
    }
}

function reloadUserPage() {
    // force server reload of user page, NS6 not coming from server?
    getCallerPage().location.reload(true);
}

function getCallerPage() {
    // from floating mode
    if( opener ) {
        return opener;
    } else { // docked mode
        return top.cf_main_cf;
    }
}
//============================== WRITES ==============================
function writeFileInfo() {
    var fileName = self.location.toString();
    fileName = fileName.substring(fileName.lastIndexOf("/")+1,fileName.length);
    if( debugMode ) {
        document.write( self.name + ' frame for ' + '<span style="color:red;">#cgi.script_name#</span>');
    }
}

function writeCSS() {
    // THERE IS DEFINITELY AN NS6 ISSUE WITH WRITING OUT THE <LINK> TAG...
    // I SPENT A FEW GOOD HOURS DEBUGGING THIS AGAIN... LEAVE IN THE CSS AND DO NOT LINK TO IT
    //var css = "<link rel='STYLESHEET' type='text/css' href='#imageDir#/cfadmin.css'>"; //NS6 issues? 
    var css = "<style>" + 
        "a 				{text-decoration:none;}" +
        "a:hover 		{text-decoration:underline; color:##339900;}" +
        ".link		 	{font-family:tahoma,arial,geneva,sans-serif; font-size: .7em; line-height:1.25em;}" +
        "a.link:hover	{text-decoration:underline; color:##66ff66;}" +
        ".buttn 			{font-size:.7em;font-family: tahoma,arial,Geneva,Helvetica,sans-serif;background-color:##e0e0d5;}"+
        
        ".color-title	{background-color:##888885;color:white;ackground-color:##7A8FA4;}" +
        ".color-header	{background-color:##ddddd5;}" +
        ".color-buttons	{background-color:##ccccc5;}" +
        ".color-border	{background-color:##666666;}" +
        ".color-row		{background-color:##fffff5;}" +
        ".color-rowalert	{background-color:##ffddaa;}" +
        ".combined-crimson {background-color: ##dc143c; color: white; font-size: 8pt;}" +
        ".combined-steelblue { font-weight:bold; color: 666666; font-size: 8pt;}" +
	//  ".combined-steelblue {background-color: ##eecc99; color: 660000; font-size: 8pt;}" +

        ".label,.text 	{font-size:.7em;font-family: tahoma,arial,Geneva,Helvetica,sans-serif;}" +
        ".nospace		{line-height:2px;}" +
        ".sentance,ul {font-size:.75em;	line-height:1.5em;	font-family: arial,Geneva,Helvetica,sans-serif;}" +
        "td,p			{font-family: tahoma,arial,Geneva,Helvetica,sans-serif;}" +	
        "th				{text-align:left;font-weight:normal;}" +	
        "b,.b {font-weight:bold;}" +
        ".text_bold {font-weight:bold;}" +
        ".h3,h3 			{font-size:.9em;line-height:1.2em;font-family:arial,geneva,helvetica,sans-serif;}" +	
        ".pagedivider	{font-size:.9em;line-height:1.2em;font-family:arial,geneva,helvetica,sans-serif;}" +	
        ".itemdivider {background-color: silver;}" +
        "pre {color: maroon; font-size: 8pt;}"+
        
        ".template  {color: black; font-size:.7em;font-family: tahoma,arial,Geneva,Helvetica,sans-serif; font-weight: normal;} " +
        ".template_overage   {color: red; font-size:.7em;font-family: tahoma,arial,Geneva,Helvetica,sans-serif; font-weight: bold;}"+
        
        "img {cursor: hand; } " +
        "</style>";
    if( debugMode ) {
        document.write(css);
    }
}

function writeOpenBody() {
    if( debugMode ) {
        document.write('<head><title>ColdFusion Debugging Window: #cgi.script_name#</title></head><body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="5D7594" background="#imageDir#bgleft.gif" onLoad="restoreTreeState();" onUnload="nullifyWindow();">');
    }
}

function writeCloseBody() {
    if( debugMode ) {
        document.write('</body>');
    }
}

//============================== TREE STATE ==============================
function setCookie( targetName, value ) {
    var cookieValue = targetName + "=" + escape(value);
    var exp = new Date();
    var nowPlus30Days = exp.getTime() + (30 * 24 * 60 * 60 * 1000);
    exp.setTime( nowPlus30Days );
    document.cookie = cookieValue + "; expires=" + exp.toGMTString() + ";";
}

function getCookieValue( name ) {
    var thisCookie = document.cookie.split("; ")
    for( i=0; i<thisCookie.length; i++ ) {
        if( name == thisCookie[i].split("=")[0] ) {
            return unescape(thisCookie[i].split("=")[1]);
       }
    }
    return null;
}

function restoreTreeState() {
    var thisCookie = document.cookie.split("; ")
    var name = "";
    var value = "";
    // by default all nodes except exceptions are closed, only call showHide() for opened ones
    // loop through all the cookies and if the value is "block", then try to showHide() it
    // a user's cookie will rarely have the value of "block", but should that be the case, showHide()
    // has the proper check
    for( i=0; i<thisCookie.length; i++ ) {
        name = thisCookie[i].split("=")[0];
        value = unescape(thisCookie[i].split("=")[1]);
        if( value == "block" ) {
            showHide( name, 'img_'+name )
        }
    }
}
function clearTreeState() {
    var thisCookie = document.cookie.split("; ")
    var name = "";
    for( i=0; i<thisCookie.length; i++ ) {
        name = thisCookie[i].split("=")[0];
        if( name.indexOf("cf_debug") == 0 ) { // only clear tree cookies
            document.cookie = name + "=; expires=Thu, 01-Jan-1970 00:00:00 GMT;";
        }
    }
}
</script>


<script language="javascript">writeCSS();</script>

<script language="javascript">writeOpenBody();</script>
<table border="0" cellpadding="0" cellspacing="0" bgcolor="white" width="100%">
<tr bgcolor="003350">
	<td height="25">&nbsp;</td>
	<td colspan="2" width="300" nowrap><font class="label" style="color:C4D3E4;"><b>ColdFusion MX Debugging</b></font></td>
</tr>
<tr><td colspan="3" height="7" background="#imageDir#homedivider.gif" width="100%"></td></tr>
<!--- <tr><td colspan="3" height="1" bgcolor="999999"></td></tr>
 --->
<tr><td colspan="3" height="1" bgcolor="336699"></td></tr>
<tr>
	<td width="15" nowrap height="75">&nbsp;</td>
	<td>
	<br>
    <form name="cf_debug_goToUrl_form" onSubmit="return goToUrl();">	
    <table border="0" cellpadding="0" cellspacing="0" class="color-border" bgcolor="999999" width="100%"><tr><td>
        <table border="0" cellpadding="2" cellspacing="1" width="100%">
        <tr class="color-title">
        	<td height="20" colspan="2"><font class="label">&nbsp; <b class="form-title">Page Overview</b></font></td>
        </tr>
        <tr class="color-header">
        	<td nowrap><font class="label">&nbsp; Page &nbsp;</font></td>
        	<td nowrap class="color-row" width="100%"><font class="label">&nbsp; <a href="##" onClick="reloadUserPage();" 
        		onMouseOver="window.status='reload your page'; return true;" 
        		onMouseOut="window.status=''; return true;">#cgi.script_name#<cfif cgi.query_string NEQ "">?#cgi.query_string#</cfif></a> &nbsp;</font></td>
        </tr>
        <tr class="color-header">
        	<td nowrap><font class="label">&nbsp; Date &nbsp;</font></td>
        	<td nowrap class="color-row"><font class="label">&nbsp; #DateFormat(Now())# #TimeFormat(Now(), "HH:mm:ss")# &nbsp;</font></td>
        </tr>
        <tr class="color-buttons">
        	<td colspan="2" height="30">
        		<table border="0" cellpadding="0" cellspacing="0"><tr>
        		<td nowrap><font class="label">&nbsp;&nbsp;</font></td>
        		<td><input type="text" class="label" size="15" style="width:15em;" name="cf_debug_user_url" value="#cgi.script_name#<cfif cgi.query_string NEQ "">?#cgi.query_string#</cfif>"></td>
        		<td nowrap><font class="label">&nbsp;&nbsp;</font></td>
        		<td><input type="button" name="btn_goToUrl" value="&nbsp; Go &nbsp;" onClick="goToUrl();" class="buttn"></td>
        		</tr></table>
        	</td>
        </tr>
        </table>
    </td></tr></table>
    </form>	
	</td>
	<td width="15" nowrap>&nbsp;</td>
</tr>
<tr>
	<td>&nbsp;</td>
	<td><script>if(debugMode && document.getElementById){document.write('<br>');}</script><!--- NS form compensation--->	
<!-- DEBUG DATA --->

<table border="0" cellpadding="0" cellspacing="0" class="color-border" bgcolor="999999" width="100%"><tr><td>
<table border="0" cellpadding="2" cellspacing="1" width="100%">
<tr class="color-title">
	<td height="20"><font class="label">&nbsp; <b class="form-title">Debugging Details</b></font></td>
</tr></table>
<table border="0" cellpadding="4" cellspacing="1" width="100%">
<tr class="color-header">
	<td>
<table border="1" cellpadding="0" cellspacing="0" width="100%"><tr class="color-row"><td>
<!--- <table border=00 cellspacing=0 cellpadding=0>
<tr><td><img name="img_cf_debug_debug_data" src="#imageDir#close.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_debug_data', this.name);" ></td>
    <td><a href="javascript:showHide('cf_debug_debug_data','img_cf_debug_debug_data');" class="label">Debug Data</a></td>
</tr>
</table> --->

<div id="cf_debug_debug_data" style="display:block;">
<!--- <table border=0 cellspacing=0 cellpadding=0>
<tr>
    <td width="16" nowrap>&nbsp;</td>
        <td> --->
        
        <!-- EXCEPTIONS -->
		
		<table border=0 cellspacing=0 cellpadding=0 width="100%">
		<cfif IsDefined("cfdebug_ex") AND cfdebug_ex.RecordCount GT 0>
        <tr bgcolor="ffffdd"><td><img name="img_cf_debug_exceptions" src="#imageDir#close.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_exceptions', this.name);"></td>
            <td width="100%"><a href="javascript:showHide('cf_debug_exceptions','img_cf_debug_exceptions');" class="label">Exceptions</a></td>
        </tr>
		<cfelse>
        <tr bgcolor="eeeed5"><td><img name="img_cf_debug_exceptions" src="#imageDir#none.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0"></td>
            <td width="100%"><font class="label" color="666666">Exceptions (none present)</font></td>
        </tr>		
		</cfif>
        </table>
		
        
		<table border="0" cellpadding="0" cellspacing="0" bgcolor="cccccc" width="100%"><tr><td height="1"></td></tr></table> 
        <div id="cf_debug_exceptions" style="display:block;">
        <table border=0 cellspacing=0 cellpadding=0>
        <cfloop query="cfdebug_ex">
        <tr>
            <td width="16" nowrap>&nbsp;</td>
            <td>
                <table border=0 cellspacing=0 cellpadding=2>
                <tr><td colspan="2" class="combined-crimson">#cfdebug_ex.template#(#cfdebug_ex.line#) @ #TimeFormat(cfdebug_ex.timestamp, "HH:mm:ss.lll")#</td></tr>
                <tr><td class="label">type</td><td class="label">#cfdebug_ex.name#</td></tr>
                <tr><td class="label">message</td><td class="label">#cfdebug_ex.message#</td></tr>
<!---                 <tr><td class="label">detail</td><td class="label">error detail</td></tr>
                <tr><td class="label">error_code</td><td class="label">error code corresponding to error thrown</td></tr>
                <tr><td class="label">extended_info</td><td class="label">extended info such java stack trace</td></tr>
                <tr><td class="label">stack_trace</td><td class="label">error detail</td></tr> --->
                 </table>
            </td>
        </tr>
        <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
        </cfloop>
        </table>

        </div><!-- cf_debug_exceptions -->
        
        <!-- GENERAL -->        
        <table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr bgcolor="ffffdd"><td><img name="img_cf_debug_general" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_general', this.name);" ></td>
            <td width="100%"><a href="javascript:showHide('cf_debug_general','img_cf_debug_general');" class="label">General</a></td>
        </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" bgcolor="cccccc" width="100%"><tr><td height="1"></td></tr></table> 
        <div id="cf_debug_general" style="display:none;">

        <table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr><td height="5"></td></tr>
		<tr>
            <td width="16" nowrap>&nbsp;</td>
            <td>
                <table border=0 cellspacing=0 cellpadding=0 width="100%">
                <tr><td class="label">#server.coldfusion.productname# #server.coldfusion.productlevel# &nbsp; &nbsp;</td><td class="label" width="100%">#server.coldfusion.productversion#</td></tr>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                <!--- <tr><td class="label">#CGI.Script_Name#</td><td class="label">#DateFormat(Now())# #TimeFormat(Now())#</td></tr> --->
                <tr><td class="label" nowrap height="18">current_locale &nbsp; &nbsp;</td><td class="label" nowrap>#GetLocale()#</td></tr>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                <tr><td class="label" nowrap height="18">user_agent &nbsp; &nbsp;</td><td class="label" nowrap>#cgi.HTTP_USER_AGENT#</td></tr>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                <tr><td class="label" nowrap height="18">remote_ip &nbsp; &nbsp;</td><td class="label" nowrap>#cgi.REMOTE_ADDR#</td></tr>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                <tr><td class="label" nowrap height="18">host_name &nbsp; &nbsp;</td><td class="label" nowrap>#cgi.REMOTE_HOST#</td></tr>
                </table>
            </td>
        </tr>
		<tr><td height="10"></td></tr>
		<tr><td height="1" bgcolor="999999" colspan="2"></td></tr>
		</table>
        </div><!-- cf_debug_general -->
        
        <cfif cfdebugger.check("Template")>
      	<!--- Total Execution Time of all top level pages --->
      	<cfquery dbType="query" name="cfdebug_execution" debug="false">
          	SELECT (endTime - startTime) AS executionTime
          	FROM qEvents
          	WHERE type = 'ExecutionTime'
      	</cfquery>
      	<cfquery dbType="query" name="cfdebug_top_level_execution_sum" debug="false">
      	SELECT sum(endTime - startTime) AS executionTime
      	FROM qEvents
      	WHERE type = 'Template' AND parent = ''
      	</cfquery>
        <!--- File not found will not produce any records when looking for top level pages --->
        <cfif cfdebug_top_level_execution_sum.recordCount GT 0>
            <!-- TEMPLATE STACK -->
            <table border=0 cellspacing=0 cellpadding=0 bgcolor="ffffdd" width="100%">
            <tr><td><img name="img_cf_debug_template_stack" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_template_stack', this.name);" ></td>
                <td width="100%"><a href="javascript:showHide('cf_debug_template_stack','img_cf_debug_template_stack');" class="label">Execution Times</a></td>
            </tr>
            </table>
    		<table border="0" cellpadding="0" cellspacing="0" bgcolor="cccccc" width="100%"><tr><td height="1"></td></tr></table> 
            <div id="cf_debug_template_stack" style="display:none;">
            
            <table border=0 cellspacing=0 cellpadding=0 width="100%">
            <tr>
                <td width="16" nowrap>&nbsp;</td>
                <td nowrap>
                <cfsetting enablecfoutputonly="Yes">
                <cfset time_other = Max(cfdebug_execution.executionTime - cfdebug_top_level_execution_sum.executionTime, 0)>
                <cfif cfdebugger.settings.template_mode EQ "tree">
                    <cfset a = arrayNew(1)>
                    <cfloop query="qEvents">
                       <cfscript>
                            // SELECT stacktrace will result in Query Of Queries runtime error.
                            // Failed to get meta_data for columnqEvents.stacktrace .
                            // Was told I need to define meta data for debugging event table similar to <cfldap>
                            if( qEvents.type eq "template" ) {
                                st = structNew();
                                st.StackTrace = qEvents.stackTrace;
                                st.template = qEvents.template;
                                st.startTime = qEvents.starttime;
                                st.endTime = qEvents.endtime;
                                st.parent =  qEvents.parent;
                                st.line =  qEvents.line;
                                
                                arrayAppend(a, st);
                            }
                       </cfscript>
                    </cfloop>
                    <cfset qTree = queryNew("template,templateId,parentId,duration,line")>
                    <cfloop index="i" from="1" to="#arrayLen(a)#">
                        <cfset childidList = "">
                        <cfset parentidList = "">
                        <cfloop index="x" from="#arrayLen(a[i].stacktrace.tagcontext)#" to="1" step="-1">
                            <cfscript>
                                if( a[i].stacktrace.tagcontext[x].id NEQ "CF_INDEX" ) {
                                    // keep appending the line number from the template stack to form a unique id
                                    childIdList = listAppend(childIdList, a[i].stacktrace.tagcontext[x].line);
                                    if( x eq 1 ) {
                                        parentIdList = listAppend(parentIdList, a[i].stacktrace.tagcontext[x].template);
                                    } else {
                                        parentIdList = listAppend(parentIdList, a[i].stacktrace.tagcontext[x].line);
                                    }
                                }
                            </cfscript>
                        </cfloop>
                    
                        <cfscript>
                            // template is the last part of the unique id...12,5,17,c:\wwwroot\foo.cfm
                            // if we don't remove the "CFC[" prefix, then the parentId and childId relationship
                            // will be all wrong
                            startToken = "CFC[ ";
                            endToken = " | ";
                            thisTemplate = a[i].template;
                            startTokenIndex = FindNoCase(startToken, thisTemplate, 1);
                            if( startTokenIndex NEQ 0 ) {
                                endTokenIndex = FindNoCase(endToken, thisTemplate, startTokenIndex);
                                thisTemplate = Trim(Mid(thisTemplate,Len(startToken),endTokenIndex-Len(startToken)));
                            }
                            childIdList = listAppend(childIdList, thisTemplate);
                            queryAddRow(qTree);
                            querySetCell(qTree, "template", a[i].template);    
                            querySetCell(qTree, "templateId", childIdList);    
                            querySetCell(qTree, "parentId", parentIdList);    
                            querySetCell(qTree, "duration", a[i].endtime - a[i].starttime);    
                            querySetCell(qTree, "line", a[i].line);    
                        </cfscript>
                    </cfloop>
                    
                    <cfset stTree = structNew()>
                    <cfloop query="qTree">
                        <cfscript>
                        // empty parent assumed to be top level with the exception of application.cfm
                        if( len(trim(parentId)) eq 0 ){
                            parentId = 0;
                        }
                            stTree[parentId] = structNew();
                            stTree[parentId].templateId = qTree.templateId;
                            stTree[parentId].template = qTree.template;
                            stTree[parentId].duration = qTree.duration;
                            stTree[parentId].line = qTree.line;
                            stTree[parentId].children = arrayNew(1);
                        </cfscript>
                    </cfloop>
                    <cfloop query="qTree">
                        <cfscript>
                            stTree[templateId] = structNew();
                            stTree[templateId].templateId = qTree.templateId;
                            stTree[templateId].template = qTree.template;
                            stTree[templateId].duration = qTree.duration;
                            stTree[templateId].line = qTree.line;
                            stTree[templateId].children = arrayNew(1);
                        </cfscript>
                    </cfloop>
                    <cfloop query="qTree">
                        <cfscript>
                            arrayAppend(stTree[parentId].children, stTree[templateId]);
                        </cfscript>
                    </cfloop>
                    
                    <cfquery dbType="query" name="topNodes" debug="false">
                        SELECT parentId, template
                        FROM qTree
                        WHERE parentId = ''
                    </cfquery>
                    
                    <cfloop query="topNodes">
                        #drawTree(stTree,-1,topNodes.template,cfdebugger.settings.template_highlight_minimum)#
                    </cfloop>
                    <cfoutput><p class="template">
                    (#time_other# ms) STARTUP, PARSING, COMPILING, LOADING, &amp; SHUTDOWN<br />
                    (#cfdebug_execution.executionTime# ms) TOTAL EXECUTION TIME <br />
                    <span style="color:red;font-weight:bold;">red = over #cfdebugger.settings.template_highlight_minimum# ms execution time</span>
                    </p></cfoutput>
                <cfelse>
    
                <cfquery dbType="query" name="cfdebug_templates_summary" debug="false">
                SELECT  template, Sum(endTime - startTime) AS totalExecutionTime, count(template) AS instances
                FROM qEvents
                WHERE type = 'Template'
                group by template
                order by totalExecutionTime DESC
                </cfquery>
    
                <table border="0" cellpadding="2" cellspacing="0">
                <tr><td class="label" align="center"><b>Total Time</b></td><td class="label"align="center"><b>Avg. Time</b></td><td class="label"align="center"><b>Count</b></td><td class="label"><b>Template</b></td></tr>
                <tr><td colspan=4 height="1" class="itemdivider"></td></tr>
                    <cfloop query="cfdebug_templates_summary">
                        <cfset templateOutput = template>
                        <cfset templateAverageTime = Round(totalExecutionTime / instances)>
                        
                        <cfif template EQ ExpandPath(cgi.script_name)>
                            <cfset templateOutput = "<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/topdoc.gif' alt='top level' border='0'> " &
                                "<b>" & template & "</b>">
                        <cfelse>
                            <cfif templateAverageTime GT cfdebugger.settings.template_highlight_minimum>
                                <cfset templateOutput = "<font color='red'><span style='color: red;'>" & template & "</span></font>">
                                <cfset templateAverageTime = "<font color='red'><span style='color: red;'>" & templateAverageTime & "</span></font>">
                            </cfif>
                        </cfif>
    
                        <tr>
                            <td align="right" class="label" nowrap>#totalExecutionTime# ms</td>
                            <td align="right" class="label" nowrap>#templateAverageTime# ms</td>
                            <td align="center" class="label" nowrap>#instances#</td>
                            <td align="left" class="label" nowrap>#templateOutput#</td>
                        </tr>
                        <tr><td colspan=4 height="1" class="itemdivider"></td></tr>
                        </cfloop>
                <tr><td align="right" class="label" nowrap>#time_other# ms</td><td colspan=2>&nbsp;</td>
                    <td align="left" class="label">STARTUP, PARSING, COMPILING, LOADING, &amp; SHUTDOWN</td></tr>
                <tr><td colspan=4 height="1" class="itemdivider"></td></tr>
                <tr><td align="right" class="label" nowrap>#cfdebug_execution.executionTime# ms</td><td colspan=2>&nbsp;</td>
                    <td align="left" class="label">TOTAL EXECUTION TIME</td></tr>
                </table>
                <span class="template_overage">red = over #cfdebugger.settings.template_highlight_minimum# ms average execution time</span>
                </a>
                </cfif>
                </td>
    	    </tr>
    		<tr><td height="10"></td></tr>
    		<tr><td height="1" bgcolor="999999" colspan="2"></td></tr>
            </table>
            </div><!-- cf_debug_template_stack -->
        <cfelse>
    		<table border=0 cellspacing=0 cellpadding=0 width="100%">
            <tr bgcolor="eeeed5"><td><img name="img_cf_debug_template_stack" src="#imageDir#none.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0"></td>
                <td width="100%"><font class="label" color="666666">Execution Times (none present)</font></td>
            </tr>
    		<tr bgcolor="cccccc"><td height="1" colspan="2"></td></tr>	
    		</table>	
        </cfif> <!--- if top level templates are available --->
        </cfif>

        <cfif IsDefined("cfdebug_queries") AND cfdebug_queries.RecordCount GT 0>
        <!-- SQL QUERIES -->
        <table border=0 cellspacing=0 cellpadding=0 bgcolor="ffffdd" width="100%">
        <tr><td><img name="img_cf_debug_sql_queries" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_sql_queries', this.name);" ></td>
            <td width="100%"><a href="javascript:showHide('cf_debug_sql_queries','img_cf_debug_sql_queries');" class="label">SQL Queries</a></td>
        </tr>
        </table>
        <table border="0" cellpadding="0" cellspacing="0" bgcolor="cccccc" width="100%"><tr><td height="1"></td></tr></table> 
        <div id="cf_debug_sql_queries" style="display:none;">
        <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="FFFFF5">
        <cftry>
        <cfset qCount = 0>
        <cfloop query="cfdebug_queries">
        <tr>
            <td width="16" nowrap>&nbsp;</td>
            <td>
                <table border=0 cellspacing=0 cellpadding=2 width="100%">
                <tr><td colspan="2" class="combined-steelblue">#cfdebug_queries.template# @ #TimeFormat(cfdebug_queries.timestamp, "HH:mm:ss.lll")#</td></tr>
                 <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
				<tr><td class="label" nowrap height="18">name &nbsp; &nbsp;</td><td class="label" width="100%">#cfdebug_queries.name# <cfif cfdebug_queries.cachedquery>(Cached Query)</cfif></td></tr>
                <!--- <tr><td class="label">dsn</td><td class="label">???</td></tr> --->
                <tr valign="top"><td class="label" nowrap height="18">statement &nbsp; &nbsp;</td><td class="label"><pre>#htmleditformat(cfdebug_queries.body)#</pre></td></tr>
                <tr><td class="label" nowrap height="18">datasource &nbsp; &nbsp;</td><td class="label">#cfdebug_queries.datasource#</td></tr>
                <tr><td class="label" nowrap height="18">record count &nbsp; &nbsp;</td><td class="label">#cfdebug_queries.rowCount#</td></tr>
                <tr><td class="label" nowrap height="18">execution time &nbsp; &nbsp;</td><td class="label">#Max(cfdebug_queries.executionTime, 0)#ms</td></tr>
                <cfif arrayLen(cfdebug_queries.attributes) GT 0>
                    <tr><td colspan="2">
                            <!-- PARAMETER LIST -->
                            <table border=0 cellspacing=0 cellpadding=0>
                            <tr><td><img name="img_cf_debug_cfdebug_queries_parameters#qCount#" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_cfdebug_queries_parameters#qCount#', this.name);" ></td>
                                <td><a href="javascript:showHide('cf_debug_cfdebug_queries_parameters#qCount#','img_cf_debug_cfdebug_queries_parameters#qCount#');" class="label">Query Parameters</a></td>
                            </tr>
                            </table>
                            <div id="cf_debug_cfdebug_queries_parameters#qCount#" style="display:none;">
                            <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                                <td width="16" nowrap>&nbsp;</td>
                                <td>
                                    <table border=0 cellspacing=0 cellpadding=2>
                                    <tr><td class="label">##</td><td class="label">CFSQLType</td><td class="label">value</td></tr>
                                    <cfloop index="x" from=1 to="#arrayLen(cfdebug_queries.attributes)#">
                                    <cfset thisParam = #cfdebug_queries.attributes[cfdebug_queries.currentRow][x]#>
                                    <tr>
                                        <td class="label">#x#</td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "sqlType")>#thisParam.sqlType#</cfif></td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "value")>#htmleditformat(thisParam.value)#</cfif></td>
                                    </tr>
                                    </cfloop>
                                    </table>
                                </td>
                            </tr>
                            </table>
                            </div><!-- cf_debug_stored_procedures_parameters -->
                        </td>
                    </tr>
                </cfif>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                </table>
            </td>
        </tr>
       
                <cfset qCount = (qCount + 1)>
            </cfloop>
        	<cfcatch type="Any">
        		<!--- Error reporting query event --->
        	</cfcatch>
        </cftry>
		<tr><td height="10"></td></tr>
		<tr><td height="1" bgcolor="999999" colspan="2"></td></tr>
        </table>
        </div><!-- cf_debug_sql_queries -->
		<cfelse>
		<table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr bgcolor="eeeed5"><td><img name="img_cf_debug_sql_queries" src="#imageDir#none.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0"></td>
            <td width="100%"><font class="label" color="666666">SQL Queries (none present)</font></td>
        </tr>
		<tr bgcolor="cccccc"><td height="1" colspan="2"></td></tr>	
		</table>	
		</cfif>

        <cfif IsDefined("cfdebug_storedproc") AND cfdebug_storedproc.RecordCount GT 0>
            <!-- STORED PROCEDURES -->
            <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="ffffdd">
            <tr><td><img name="img_cf_debug_stored_procedures" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_stored_procedures', this.name);" ></td>
                <td width="100%"><a href="javascript:showHide('cf_debug_stored_procedures','img_cf_debug_stored_procedures');" class="label">Stored Procedures</a></td>
            </tr>
			<tr><td colspan=2 height="1" class="itemdivider"></td></tr>
            </table>
            <div id="cf_debug_stored_procedures" style="display:none;">
            
            <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="fffff5">
            <cftry>
            <cfset spCount = 0>
            <cfloop query="cfdebug_storedproc">
            <tr>
                <td width="16" nowrap>&nbsp;</td>
                <td>
                    <table border=0 cellspacing=0 cellpadding=2 width="100%">
                    <tr><td colspan="2" class="combined-steelblue">#cfdebug_storedproc.template# @ #TimeFormat(cfdebug_storedproc.timestamp, "HH:mm:ss.lll")#</td></tr>
                    <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
					<tr><td class="label">procedure</td><td class="label">#cfdebug_storedproc.name#</td></tr>
                    <tr><td class="label">datasource</td><td class="label">#cfdebug_storedproc.datasource#</td></tr>
                    <tr><td class="label">execution time</td><td class="label">#Max(cfdebug_storedproc.executionTime, 0)#ms</td></tr>
                    <tr><td colspan="2">
                            <!-- PARAMETER LIST -->
                            <table border=0 cellspacing=0 cellpadding=0 width="100%">
                            <tr><td><img name="img_cf_debug_stored_procedures_parameters#spCount#" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_stored_procedures_parameters#spCount#', this.name);" ></td>
                                <td width="100%"><a href="javascript:showHide('cf_debug_stored_procedures_parameters#spCount#','img_cf_debug_stored_procedures_parameters#spCount#');" class="label">Parameters</a></td>
                            </tr>
                            </table>
                            <div id="cf_debug_stored_procedures_parameters#spCount#" style="display:none;">
                            <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                                <td width="16" nowrap>&nbsp;</td>
                                <td>
                                    <table border=0 cellspacing=0 cellpadding=2 width="100%">
                                    <tr><td class="label">type</td><td class="label">CFSQLType</td><td class="label">value</td><td class="label">variable</td><td class="label">dbVarName</td></tr>
                                    <cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.attributes)#">
                                    <cfset thisParam = #cfdebug_storedproc.attributes[cfdebug_storedproc.currentRow][x]#>
                                    <tr>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "type")>#thisParam.type#</cfif></td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "sqlType")>#thisParam.sqlType#</cfif></td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "value")>#thisParam.value#</cfif></td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "variable")>#thisParam.variable# = #CFDebugSerializable(Evaluate(thisParam.variable))#</cfif></td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisParam, "dbVarName")>#thisParam.dbVarName#</cfif></td>
                                    </tr>
                                    </cfloop>
                                    </table>
                                </td>
                            </tr>
                            </table>
                            </div><!-- cf_debug_stored_procedures_parameters -->
                            
                            <!-- RESULTS LIST -->
                            <table border=0 cellspacing=0 cellpadding=0 width="100%">
                            <tr><td><img name="img_cf_debug_stored_procedures_results#spCount#" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_stored_procedures_results#spCount#', this.name);" ></td>
                                <td width="100%"><a href="javascript:showHide('cf_debug_stored_procedures_results#spCount#','img_cf_debug_stored_procedures_results#spCount#');" class="label">Results</a></td>
                            </tr>
                            </table>
                            <div id="cf_debug_stored_procedures_results#spCount#" style="display:none;">
                            <table border=0 cellspacing=0 cellpadding=0>
                            <tr>
                                <td width="16" nowrap>&nbsp;</td>
                                <td>
                                    <table border=0 cellspacing=0 cellpadding=2>
                                    <tr><td class="label">name</td><td class="label">resultset</td></tr>
                                    <cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.result)#">
                                    <cfset thisResult = #cfdebug_storedproc.result[cfdebug_storedproc.currentRow][x]#>
                                    <tr>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisResult, "name")>#thisResult.name#</cfif></td>
                                        <td class="label">&nbsp;<cfif StructKeyExists(thisResult, "resultSet")>#thisResult.resultSet#</cfif></td>
                                    </tr>
                                    </cfloop>
                                    </table>
                                </td>
                            </tr>
                            </table>
                            </div><!-- cf_debug_stored_procedures_results -->
                        </td>
                    </tr>
					<tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                    </table>
                </td>
            </tr>
            
            <cfset spCount = (spCount + 1)>
            </cfloop>
            	<cfcatch type="Any">
            		<!--- Error reporting query event --->
            	</cfcatch>
            </cftry>
		<tr><td height="10"></td></tr>
		<tr><td height="1" bgcolor="999999" colspan="2"></td></tr>
        </table>
        </div><!-- cf_debug_stored_procedures -->
        <cfelse>
		<table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr bgcolor="eeeed5"><td><img name="img_cf_debug_stored_procedures" src="#imageDir#none.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0"></td>
            <td width="100%"><font class="label" color="666666">Stored Procedures (none present)</font></td>
        </tr>
		<tr bgcolor="cccccc"><td height="1" colspan="2"></td></tr>	
		</table>	
		</cfif>
        
        <!-- VARIABLES -->
        <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="ffffdd">
        <tr><td><img name="img_cf_debug_variables" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_variables', this.name);" ></td>
            <td width="100%"><a href="javascript:showHide('cf_debug_variables','img_cf_debug_variables');" class="label">Scope Variables</a></td>
        </tr>
		<tr><td height="1" bgcolor="cccccc" colspan="2"></td></tr>
        </table>
        <div id="cf_debug_variables" style="display:none;">
        
        <table border=0 cellspacing=0 cellpadding=0 width="100%">
        <tr>
            <td width="16" nowrap>&nbsp;</td>
            <td width="100%">
            <cftry>
                <!-- APPLICATION -->
                <cfif IsDefined("APPLICATION") AND IsStruct(APPLICATION) AND StructCount(APPLICATION) GT 0 AND cfdebugger.check("ApplicationVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_application" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_application', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_application','img_cf_debug_application');" class="label">Application Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_application" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(application)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_application -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>

            <cftry>
                <!-- CGI -->
                <cfif IsDefined("CGI") AND IsStruct(CGI) AND StructCount(CGI) GT 0 AND cfdebugger.check("CGIVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_cgi" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_cgi', this.name);" ></td>
                        <td width="100%"><a href="javascript:showHide('cf_debug_cgi','img_cf_debug_cgi');" class="label">CGI Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_cgi" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(cgi)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_cgi -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>

            <cftry>
                <!-- CLIENT -->
                <cfif IsDefined("CLIENT") AND IsStruct(CLIENT) AND StructCount(CLIENT) GT 0 AND cfdebugger.check("ClientVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_client" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_client', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_client','img_cf_debug_client');" class="label">Client Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_client" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(client)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_client -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>

            <cftry>
                <!-- COOKIE -->
                <cfif IsDefined("COOKIE") AND IsStruct(COOKIE) AND StructCount(COOKIE) GT 0 AND cfdebugger.check("CookieVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_cookie" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_cookie', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_cookie','img_cf_debug_cookie');" class="label">Cookies</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_cookie" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(cookie)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_cookie -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>
            
            <cftry>    
                <!-- FORM -->
                <cfif IsDefined("FORM") AND IsStruct(FORM) AND StructCount(FORM) GT 0 AND cfdebugger.check("FormVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_form" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_form', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_form','img_cf_debug_form');" class="label">Form Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_form" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(form)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_form -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>
            
            <cftry>
                <!-- REQUEST -->
                <cfif IsDefined("REQUEST") AND IsStruct(REQUEST) AND StructCount(REQUEST) GT 0 AND cfdebugger.check("RequestVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_request" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_request', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_request','img_cf_debug_request');" class="label">Request Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_request" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(request)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_request -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>

            <cftry>
                <!-- SERVER -->
                <cfif IsDefined("SERVER") AND IsStruct(SERVER) AND StructCount(SERVER) GT 0 AND cfdebugger.check("ServerVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_server" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_server', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_server','img_cf_debug_server');" class="label">Server Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_server" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(server)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_server -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>

            <cftry>
                <!-- SESSION -->
                <cfif IsDefined("SESSION") AND IsStruct(SESSION) AND StructCount(SESSION) GT 0 AND cfdebugger.check("SessionVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_session" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_session', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_session','img_cf_debug_session');" class="label">Session Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_session" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(session)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_session -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>

            <cftry>
                <!-- URL -->
                <cfif IsDefined("URL") AND IsStruct(URL) AND StructCount(URL) GT 0 AND cfdebugger.check("URLVar")>
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr><td><img name="img_cf_debug_url" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_url', this.name);" ></td>
                        <td><a href="javascript:showHide('cf_debug_url','img_cf_debug_url');" class="label">URL Variables</a></td>
                    </tr>
                    </table>
                    <div id="cf_debug_url" style="display:none;">
                    <table border=0 cellspacing=0 cellpadding=0>
                    <tr>
                        <td width="16" nowrap>&nbsp;</td>
                        <td>
                            <table border=0 cellspacing=0 cellpadding=2>#sortedScope(url)#</table>
                        </td>
                    </tr>
                    </table>
                    </div><!-- cf_debug_url -->
                </cfif>
            <cfcatch type="Any"></cfcatch>
        	</cftry>
            </td>
        </tr>
        <tr><td height="10"></td></tr>
		<tr><td height="1" bgcolor="999999" colspan="2"></td></tr>
		</table>
        </div><!-- cf_debug_parameters -->

		

        <cfif IsDefined("cfdebug_timer") AND cfdebug_timer.recordCount GT 0>
            <!-- TIMER PATH -->
            <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="ffffdd">
            <tr><td><img name="img_cf_debug_timer_path" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_timer_path', this.name);" ></td>
                <td width="100%"><a href="javascript:showHide('cf_debug_timer_path','img_cf_debug_timer_path');" class="label">CFTimer Times</a></td>
            </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" bgcolor="cccccc" width="100%"><tr><td height="1"></td></tr></table> 
            <div id="cf_debug_timer_path" style="display:none;">
			<table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="fffff5">
           	<cfloop query="cfdebug_timer">
            <tr>
                <td width="16" nowrap>&nbsp;</td>
                <td class="label">
			    <cftry>
			    	<img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/#Replace(cfdebug_timer.priority, " ", "%20")#_16x16.gif' alt="#cfdebug_timer.priority# type">
					 [#val(cfdebug_timer.endTime) - val(cfdebug_timer.startTime)#ms] <i>#cfdebug_timer.message#</i><br />
			    	<cfcatch type="Any"></cfcatch>
			    </cftry>
				</td>
			</td>
			</cfloop>
            </div><!-- cf_debug_trace_path -->
        </cfif>




		
        <cfif IsDefined("cfdebug_trace") AND cfdebug_trace.recordCount GT 0>
            <!-- TRACE PATH -->
            <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="ffffdd">
            <tr><td><img name="img_cf_debug_trace_path" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_trace_path', this.name);" ></td>
                <td width="100%"><a href="javascript:showHide('cf_debug_trace_path','img_cf_debug_trace_path');" class="label">Trace Path</a></td>
            </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0" bgcolor="cccccc" width="100%"><tr><td height="1"></td></tr></table> 
            <div id="cf_debug_trace_path" style="display:none;">
            <table border=0 cellspacing=0 cellpadding=0 width="100%" bgcolor="fffff5">
            <cfset firstTrace=true>
            <cfset prevDelta=0>
            <cfloop query="cfdebug_trace">
            <cfset deltaFromRequest = Val(cfdebug_trace.endTime)>
            <cfset deltaFromLast = Val(deltaFromRequest-prevDelta)>
                <cftry>
            <tr>
                <td width="16" nowrap>&nbsp;</td>
                <td>
                    <table border=0 cellspacing=0 cellpadding=2 width="100%">
                    <tr><td colspan="2" class="combined-steelblue" nowrap><img src='#getpageContext().getRequest().getContextPath()#/CFIDE/debug/images/#Replace(cfdebug_trace.priority, " ", "%20")#_16x16.gif' alt="#cfdebug_trace.priority# type" align="left"> #cfdebug_trace.template#(#cfdebug_trace.line#) @ #TimeFormat(cfdebug_trace.timestamp, "HH:mm:ss.lll")#</td></tr>
                    <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
					<tr><td class="label">request delta</td><td class="label">#deltaFromRequest# ms (<cfif firstTrace>1st trace<cfelse>#deltaFromLast# ms</cfif>)</td></tr>
                    <cfif #cfdebug_trace.category# NEQ ""><tr><td class="label">category</td><td class="label">#cfdebug_trace.category#</td></tr></cfif>
                    <cfif #cfdebug_trace.result# NEQ ""><tr><td class="label">variable</td><td class="label">#cfdebug_trace.result#</td></tr></cfif>
                    <cfif #cfdebug_trace.message# NEQ ""><tr><td class="label">text</td><td class="label">#cfdebug_trace.message#</td></tr></cfif>
                    <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
					</table>
                </td>
            </tr>
            	<cfcatch type="Any"></cfcatch>
                </cftry>
                <cfset prevDelta = deltaFromRequest>
                <cfset firstTrace=false>
            </cfloop>
			<tr><td height="10"></td></tr>
			<tr><td height="1" bgcolor="999999" colspan="2"></td></tr>
			</table>
            </div><!-- cf_debug_trace_path -->
        </cfif>

        <!-- HELP -->
        <table border=0 cellspacing=0 cellpadding=0 bgcolor="ffffdd" width="100%">
        <tr><td><img name="img_cf_debug_help" src="#imageDir#open.gif" width="9" height="9" hspace="4" vspace="4" alt="" border="0" onClick="showHide('cf_debug_help', this.name);" ></td>
            <td width="100%"><a href="javascript:showHide('cf_debug_help','img_cf_debug_help');" class="label">Help</a></td>
        </tr>
		<tr bgcolor="cccccc"><td height="1" colspan="2"></td></tr>
        </table>
        <div id="cf_debug_help" style="display:none;">
        <table border=0 cellspacing=0 cellpadding=0>
        <tr>
            <td width="16" nowrap>&nbsp;</td>
            <td>
                <table border=0 cellspacing=0 cellpadding=2>
                <tr><td class="label"><a href="http://www.macromedia.com/go/livedocs_cfmx7docs" target="_blank">CFML Reference Manual</a></td><td class="label">Look up tag and function syntax.</td></tr>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                <tr><td class="label"><a href="http://www.macromedia.com/support/coldfusion/" target="_blank">Macromedia ColdFusion Support Center</a></td><td class="label">Search TechNotes for help or browse the Designer &amp; Developer Center for ideas.</td></tr>
                <tr><td colspan=2 height="1" class="itemdivider"></td></tr>
                <tr><td class="label"><a href="javascript:clearTreeState();">Clear tree state</a></td><td class="label">Clears all cookies associated with the dockable tree.</td></tr>
                </table>
            </td>
        </tr>
        </table>
        </div><!-- cf_debug_help -->
    
<!---     </td>
</tr>
</table> --->
</td></tr></table>

</td></tr></table>
</td></tr></table>
<br>
<cfset duration = getTickCount() - startTime>
<span class="label">Debugging Time: #duration# ms</span>
<br>


</div><!-- cf_debug_debug_data -->
</td></tr>
<tr><td colspan="3" height="7" background="#imageDir#homedivider.gif" width="100%"></td></tr>
<tr><td colspan="3" height="1" bgcolor="336699"></td></tr></table>
<script language="javascript">writeCloseBody();</script>

</div><!-- cf_debug -->

<!-------------------- END : DEBUG INFO WRITTEN TO WINDOW -------------------->

<script language="javascript">cf_debug_init();</script>
<!-------------------- END : DEBUG FOOTER STUFF -------------------->
</cfoutput>

<cfsetting enablecfoutputonly="No">
</cfif>
