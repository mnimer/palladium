<cfimport taglib="." prefix="ex">
<!---
  -- Prints a detailed description about a ColdFusion error.
  -- Supported Tag Attributes:
  -- Message (optional): the primary error message to display.  If not specifed, then the exception's message will be used.
  -- Detail (optional): a detailed error message to display.  If not specifed, then the exception's detail message will be used.
  -- Properties (optional): struct that has more useful details about the context of the error (sql, error codes, etc)
  -- Error (required): the exception that we wish to display
--->


<!--- format the error --->
<cfif thistag.executionmode is "start">

	<!--- attributes validation --->
	<cfif not isDefined("attributes.error")>
 		<cfthrow type="coldfusion.tagext.validation.MissingAttributeException" message="error">
	</cfif>
	<cfset error = attributes.error>

    <cfif not isDefined("attributes.message")>
        <cfif ParameterExists(error.message)>
            <cfset attributes.message = error.message>
        <cfelse>
            <cfset attributes.message = error.type>
        </cfif>
    </cfif>

	<!--- localization --->
	<cfset locale = createObject("java", "java.util.Locale").getDefault().getLanguage()>
	<cfset l10n_caller = "detail">

    <cftry>
        <cfif FileExists(GetDirectoryFromPath(GetCurrentTemplatePath()) & "/exception_#locale#.xml")>
            <cfinclude template="exception_#locale#.xml">
        <cfelse>
            <cfinclude template="exception_en.xml">
        </cfif>
        <cfcatch>
            <cfinclude template="exception_en.xml">
        </cfcatch>
    </cftry>

    <cfparam name="attributes.detail" default="#error.detail#">
	<cfoutput><!-- " ---></TD></TD></TD></TH></TH></TH></TR></TR></TR></TABLE></TABLE></TABLE></A></ABBREV></ACRONYM></ADDRESS></APPLET></AU></B></BANNER></BIG></BLINK></BLOCKQUOTE></BQ></CAPTION></CENTER></CITE></CODE></COMMENT></DEL></DFN></DIR></DIV></DL></EM></FIG></FN></FONT></FORM></FRAME></FRAMESET></H1></H2></H3></H4></H5></H6></HEAD></I></INS></KBD></LISTING></MAP></MARQUEE></MENU></MULTICOL></NOBR></NOFRAMES></NOSCRIPT></NOTE></OL></P></PARAM></PERSON></PLAINTEXT></PRE></Q></S></SAMP></SCRIPT></SELECT></SMALL></STRIKE></STRONG></SUB></SUP></TABLE></TD></TEXTAREA></TH></TITLE></TR></TT></U></UL></VAR></WBR></XMP>

    <font face="arial"></font>

    <cfset bIE = (cgi.user_agent contains "MSIE")>

    	<html>
    		<head>
    			<title>#s_error_title#</title>


    <script language="JavaScript">
    function showHide(targetName) {
        if( document.getElementById ) { // NS6+
            target = document.getElementById(targetName);
        } else if( document.all ) { // IE4+
            target = document.all[targetName];
        }

        if( target ) {
            if( target.style.display == "none" ) {
                target.style.display = "inline";
            } else {
                target.style.display = "none";
            }
        }
    }
    </script>


    	    </head>
    	<body>

    <font style="COLOR: black; FONT: 16pt/18pt verdana">
    	#s_user_message#
    </font>
	<br><br>
    <table border="1" cellpadding="3" bordercolor="##000808" bgcolor="##e7e7e7">
    <tr>
        <td bgcolor="##000066">
            <font style="COLOR: white; FONT: 11pt/13pt verdana" color="white">
            #s_debugging_message#
            </font>
        </td>
    <tr>
    <tr>
        <td bgcolor="##4646EE">
            <font style="COLOR: white; FONT: 11pt/13pt verdana" color="white">
            #s_error_title#
            </font>
        </td>
    </tr>
    <tr>
        <td>
            <font style="COLOR: black; FONT: 8pt/11pt verdana">
    </cfoutput>

<cfelse> <!--- body falls here --->
    <!--- robust exception information set in the admin --->
    <cfparam name="bRobustEnabled" type="boolean" default="false">
    <!--- Use the debugging service to check options --->
	<cftry>
		<cfobject action="CREATE" type="JAVA" class="coldfusion.server.ServiceFactory" name="factory">
		<cfset cfdebugger = factory.getDebuggingService()>
        <cfset bRobustEnabled = cfdebugger.isRobustEnabled()>
		<cfcatch type="Any"></cfcatch>
	</cftry>

    <cfoutput>

    <table width="500" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td id="tableProps2" align="left" valign="middle" width="500">
            <h1 id="textSection1" style="COLOR: black; FONT: 13pt/15pt verdana">
            #attributes.message#
            </h1>
        </td>
    </tr>
    <tr>
        <td id="tablePropsWidth" width="400" colspan="2">
            <font style="COLOR: black; FONT: 8pt/11pt verdana">
            #attributes.detail#
            </font>
        </td>
    </tr>
    <tr>
        <td height>&nbsp;</td>
    </tr>

    <cfinclude template="gettemplate.cfm">
    <cfif bRobustEnabled>
    	<cfif arraylen(vcfml) gt 0>

    		<cfset bShowSnippet = 1>
    		<cfif not vcfml[1]contains "-1">
        		<tr>
        			<td width="400" colspan="2">
        			<font style="COLOR: black; FONT: 8pt/11pt verdana">

        			#s_error_in# <b>#vcfml[1]#</b><br>

        			<cfif arraylen(vcfml) gt 2>
        				<cfloop index="i" from="2" to="#arraylen(vcfml)#">
        					<b>#s_called_from#</b> #vcfml[i]#<br>
        				</cfloop>
        			</cfif>
        			</td>
        		</tr>
    		<cfelse>
        		<cfset bShowSnippet = 0>
        		<tr>
        			<td width="400" colspan="2">
        			<font style="COLOR: black; FONT: 8pt/11pt verdana">

        			<b><i>#s_cannot_determine#</i>

        			</font>
        			</td>
        		</tr>
    		</cfif>

    		<cfif attributes.showcontext gt 0 and isDefined("errorLocation.Template")>
    			<tr>
    			    <td colspan="2">

    				<ex:errorcontext errorLocation=#errorLocation# showcontext=#attributes.showcontext# resultVariable=errorDisplay>
    				<cfif isDefined("errorDisplay") and arrayLen(errorDisplay) gt 0 and bShowSnippet>
    					<cfset eLen = ArrayLen(errorDisplay)>

    					<cfset CodeSnippet = "">
    					<cfloop index="i" from=1 to=#eLen#>
    					    <!---
    						      NOTE: It is important to show the error either as preformatted text,
    						      or as text with whitespace cherished.  There's line/column information in this display that
    							  helps developers identify their problem's location: this text must conform to that layout.
    						--->

    							<cfif errorDisplay[i].line is "">
    								<cfset CodeSnippet = CodeSnippet & errorDisplay[i].lineNumber & " : " &  chr(13) & chr(10)>
    							<cfelse>

    								<cfif errorDisplay[i].lineNumber is errorLocation.line>
    										<cfset CodeSnippet = CodeSnippet & "<b>" & htmlEditFormat(errorDisplay[i].lineNumber & " : " & errorDisplay[i].line) &  "</b>" & chr(13) & chr(10)>
    								<cfelse>
    									<cfset CodeSnippet = CodeSnippet & htmlEditFormat(errorDisplay[i].lineNumber & " : " & errorDisplay[i].line) &  chr(13) & chr(10)>
    								</cfif>

    							</cfif>

    					</cfloop>
    					<cfif NOT find("Header Size: New Version",codeSnippet)>
    						<pre>#codeSnippet#</pre>
    					</cfif>
    				<cfelse>

    				</cfif>

    			    </td>
    			</tr>
    			<tr>
    				<td colspan="2">
    					<hr color="##C0C0C0" noshade>
    				</td>
    			</tr>
    		</cfif>
        </cfif>
    </cfif> <!--- bRobustEnabled --->

    <cfif isDefined("attributes.properties")>
	<tr><td>
        <!--- Format and display miscellaneous exception properties. --->
        <table border="0" cellpadding="0" cellspacing="0">
        <cfset exclude="localizedmessage,locale,detail,message,tagcontext,rootcause">

        <cfloop collection=#attributes.properties# item="m">
            <cfif not listcontainsnocase(exclude,m)>
            	<cftry>
            		<cfset val = attributes.properties[m]>
            		<!--- empty strings mess up the table borders --->
            		<cfif val is ""><cfset val="&nbsp;"></cfif>
            	<cfcatch>
            		<cfset val = "<small><i>not set</i></small>"/>
            	</cfcatch>
                </cftry>
    	<tr>
    		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">#xmlFormat(m)#</font></td>
    		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">&nbsp;&nbsp;#htmlEditFormat(val)#</font></td>
    	</tr>
            </cfif>
        </cfloop>
        </table>
	</td></tr>
    </cfif>

        <!--- may not always have a code snippet --->
    <cfparam name="codesnippet" default="">
    <tr>
        <td colspan="2">
            <font style="COLOR: black; FONT: 8pt/11pt verdana">
            #s_try_the_following#
            <ul>
	    <cfif NOT bRobustEnabled>
                 <li>#s_enable_robust#</li>
            </cfif>
            #s_other_try#
            </ul>
            <p>
        </td>
    </tr>
    <!---  Add a few CGI diagnostic entries. --->
    <tr>
        <td colspan="2">
            <table border="0" cellpadding="0" cellspacing="0">
        	<tr>
        	    <td><font style="COLOR: black; FONT: 8pt/11pt verdana">#s_browser#&nbsp;&nbsp;</td>
        		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">#XMLFormat(cgi.user_agent)#</td>
        	</tr>
        	<tr>
        		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">#s_remote_address#&nbsp;&nbsp;</td>
        		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">#cgi.remote_addr#</td>
        	</tr>
        	<tr>
        	    <td><font style="COLOR: black; FONT: 8pt/11pt verdana">#s_referrer#&nbsp;&nbsp;</td>
        		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">#XMLFormat(cgi.http_referer)#</td>
        	</tr>
        	<tr>
        	    <td><font style="COLOR: black; FONT: 8pt/11pt verdana">#s_date_time#&nbsp;&nbsp;</td>
        		<td><font style="COLOR: black; FONT: 8pt/11pt verdana">#dateFormat(now())# #timeFormat(now())#</td>
        	</tr>
            </table>
        </td>
    </tr>
    </table>
    <!--- start a new table tp reduce screen flicker when opening
    the stack trace --->
    <cfif bRobustEnabled>
        <table width="500" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="top">
                <font style="FONT: 8pt/11pt verdana;">
                <cfif bIE>
                    <a href="javascript:;" onMouseOver="window.status='#s_expand#';return true;" onMouseOut="window.status='';return true;" onClick="showHide('cf_stacktrace');return true;">#s_stack_trace# #s_expand2#</a>
                <cfelse>
                    #s_stack_trace#
                </cfif>
            </td>
        </tr>
        <tr>
            <td id="cf_stacktrace" <cfif bIE>style="display:none"</cfif>>
                <font style="COLOR: black; FONT: 8pt/11pt verdana">
                <cfloop index="i" from="1" to="#arraylen(vjava)#">
                    #vjava[i]#
                </cfloop>
                <br />
                <br />
                <pre>#xmlFormat(error.stacktrace)#</pre></td>
            </tr>
        </table>
    </cfif>
	</cfoutput>
    </font>
        </td>
    </tr>
    </table>
    </body></html>

    <!--- report xml exception to dreamweaver only if the request is coming from dreamweaver --->
    <cfif isDefined("cgi.http_user_agent") AND FindNoCase( "dreamweaver", #cgi.http_user_agent# ) GT 0>
	    <!--- tagContext is not always available, does script_name suffice? --->
	    <cfset uri = cgi.script_name>
	    <cfset lineNumber = "">
	    <cfif arrayLen(error.tagContext) GT 0>
	        <cfset uri = error.tagContext[1].template>
	        <cfset lineNumber = error.tagContext[1].line>
	    </cfif>
	    <cfoutput>
	    <!-- cf_debug_start
	    <?xml version="1.0" encoding="ISO-8859-1" ?>
	    <debug_root>
        	<general>
        		<timestamp><![CDATA[#TimeFormat(Now(),"HH:mm:ss.SSS")#]]></timestamp>
				<cfif bRobustEnabled>
        		<product><![CDATA[#server.coldfusion.productname# #server.coldfusion.productlevel#]]></product>
        		<product_version><![CDATA[#server.coldfusion.productversion#]]></product_version>
        		<locale><![CDATA[#GetLocale()#]]></locale>
				</cfif>
        		<user_agent><![CDATA[#CGI.HTTP_USER_AGENT#]]></user_agent>
        		<remote_ip><![CDATA[#CGI.REMOTE_ADDR#]]></remote_ip>
        		<host_name><![CDATA[#CGI.REMOTE_HOST#]]></host_name>
				<cfif bRobustEnabled>
				<file><![CDATA[#ExpandPath(CGI.Script_Name)#]]></file>
        		<uri><![CDATA[#CGI.Script_Name#]]></uri>
        		<total_execution_time><![CDATA[0 ms]]></total_execution_time>
				</cfif>
        	</general>
	    	<exceptions>
	    		<exception>
				<cfif bRobustEnabled>
	    			<jump_to_line>
	    				<uri><![CDATA[#uri#]]></uri>
	    				<file><![CDATA[#uri#]]></file>
	                    <cfif lineNumber NEQ "">
	                        <line_number><![CDATA[#lineNumber#]]></line_number>
	                    </cfif>
	    			</jump_to_line>
				</cfif>
	    			<timestamp><![CDATA[#TimeFormat(Now(), "HH:mm:ss.SSS")#]]></timestamp>
	    			<type><![CDATA[#error.type#]]></type>
	    			<message><![CDATA[#xmlFormat(attributes.message)#]]></message>
	    			<detail><![CDATA[#attributes.detail#]]></detail>
	    			<cfif StructKeyExists(error,"code") and bRobustEnabled><error_code><![CDATA[#error.code#]]></error_code></cfif>
	    			<cfif StructKeyExists(error,"extendedinfo") and bRobustEnabled><extended_info><![CDATA[#error.extendedinfo#]]></extended_info></cfif>
	    		</exception>
	    	</exceptions>
	    </debug_root>
	    cf_debug_end  -->
	    </cfoutput>
    </cfif><!--- DW check--->
</cfif>


