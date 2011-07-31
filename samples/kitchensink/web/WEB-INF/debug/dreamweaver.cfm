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
* CF5 Debugging Output 
*
* Copyright (c) 2001 Macromedia.  All Rights Reserved.
* DO NOT REDISTRIBUTE THIS SOFTWARE IN ANY WAY WITHOUT THE EXPRESSED
* WRITTEN PERMISSION OF MACROMEDIA. 
--->
<!--- Localized strings --->
<cfset undefined = "">

	<!--- Use the debugging service to check options --->
	<cftry>
		<cfobject action="CREATE" type="JAVA" class="coldfusion.server.ServiceFactory" name="factory">
		<cfset cfkdebugger = factory.getDebuggingService()>
		<cfset bFoundScopeVars = cfkdebugger.check("Variables")>
	
		<cfcatch type="Any"></cfcatch>
	</cftry>

    <cfif NOT isDefined("cfkdebugger") OR NOT cfkdebugger.isEnabled()>
        <cfthrow message="Please enable debugging in the ColdFusion Administrator when using the Server Debug Mode." type="Dreamweaver Debugger">
    </cfif>
    
	<!--- Load the debugging service's event table --->
	<cfset qEvents = cfkdebugger.getDebugger().getData()>
	
	<!--- EVENT: SQL Queries --->
	<cftry>
	<cfquery dbType="query" name="cfdebug_queries" debug="false">
	SELECT *, (endTime - startTime) AS executionTime
	FROM qEvents
	WHERE type = 'SqlQuery'
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

	<cfscript>
	//UDF - Handle Kojak output of complex data types.
	function CFDebugCheckType(variable)
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
    function dwDrawNode(nTree, indent, id) {
        var templateOuput = "";
        var thisTemplate = nTree[id].template;
        var uri = thisTemplate;
        var startToken = "CFC[ ";
        var endToken = " | ";
        var startTokenIndex = FindNoCase(startToken, thisTemplate, 1);
        if( startTokenIndex NEQ 0 ) {
            endTokenIndex = FindNoCase(endToken, thisTemplate, startTokenIndex);
            uri = Trim(Mid(thisTemplate,Len(startToken),endTokenIndex-Len(startToken)));
        }
        
        templateOuput = "<template>#Chr(13)#" &
			"<jump_to_line>#Chr(13)#" &
				"<file><![CDATA[#uri#]]></file>#Chr(13)#" &
				"<uri><![CDATA[#repeatString("- ", indent + 1)##thisTemplate#]]></uri>#Chr(13)#" &
                "<line_number><![CDATA[#nTree[id].line#]]></line_number>#Chr(13)#" &
			"</jump_to_line>#Chr(13)#" &
			"<execution_time><![CDATA[#nTree[id].duration# ms]]></execution_time>#Chr(13)#" &
		"</template>#Chr(13)#";
        writeOutput(templateOuput);
        return "";
    }
    
    function dwDrawTree(tree, indent, id) {
        var alength = 1; 
        var i = 1;
        var templateOuput = "";
    
        var thisTemplate = Tree[id].template;
        var uri = thisTemplate;
        var startToken = "CFC[ ";
        var endToken = " | ";
        var startTokenIndex = FindNoCase(startToken, thisTemplate, 1);
        if( startTokenIndex NEQ 0 ) {
            endTokenIndex = FindNoCase(endToken, thisTemplate, startTokenIndex);
            uri = Trim(Mid(thisTemplate,Len(startToken),endTokenIndex-Len(startToken)));
        }
        
        templateOuput = "<template>#Chr(13)#" &
			"<jump_to_line>#Chr(13)#" &
				"<file><![CDATA[#uri#]]></file>#Chr(13)#" &
				"<uri><![CDATA[#repeatString("- ", indent + 1)##thisTemplate#]]></uri>#Chr(13)#" &
                "<line_number><![CDATA[#Tree[id].line#]]></line_number>#Chr(13)#" &
			"</jump_to_line>#Chr(13)#" &
			"<execution_time><![CDATA[#Tree[id].duration# ms]]></execution_time>#Chr(13)#" &
		"</template>#Chr(13)#";
        writeOutput(templateOuput);

        if( isArray( tree[id].children ) and arrayLen( tree[id].children ) ) {
            alength = arrayLen( tree[id].children );
            for( i = 1; i lte alength; i = i + 1 ) {
                if( isArray(tree[id].children[i].children) and arrayLen( tree[id].children[i].children ) gt 0 ) {
                    dwDrawTree(tree, indent + 1, tree[id].children[i].templateid);
                } else {
                    dwDrawNode(tree, indent + 1, tree[id].children[i].templateid);
                }
            }
        } else {
            // single template, no includes?
            //dwDrawNode(tree, indent + 1, tree[id].template);
        }
        return "";
    }
	</cfscript>
    <cffunction name="dwSortedScope" output="false">
        <cfargument name="scope">
        <cfset retVal="">
        <cfset keys = structKeyArray(scope)>
        <cfset arraySort(keys,"text")>
        <cfloop index="x" from=1 to="#arrayLen(keys)#">
        	<cfset keyName = keys[x]>
            <cfset retVal = retVal & '<variable><name><![CDATA[#keyName#' & ']]></name>' & Chr(13) & Chr(10)>
               <cftry>
        		    <cfset keyValue = CFDebugCheckType(scope[keyname])>
        		<cfcatch>
        			<cfset keyValue = "undefined">
               	</cfcatch>
          	    </cftry>
            <cfset retVal = retVal & '<value><![CDATA[' & keyValue & ']]></value></variable>' & Chr(13) & Chr(10)>
        </cfloop>
        <cfreturn retVal>
    </cffunction>
</cfsilent>

<cfoutput>
<!-- cf_debug_start
<?xml version="1.0" encoding="UTF-8" ?> 
<debug_root>
	<general>
		<timestamp><![CDATA[#TimeFormat(Now(),"HH:mm:ss.SSS")#]]></timestamp>
		<product><![CDATA[#server.coldfusion.productname# #server.coldfusion.productlevel#]]></product>
		<product_version><![CDATA[#server.coldfusion.productversion#]]></product_version>
		<locale><![CDATA[#GetLocale()#]]></locale>
		<user_agent><![CDATA[#CGI.HTTP_USER_AGENT#]]></user_agent>
		<remote_ip><![CDATA[#CGI.REMOTE_ADDR#]]></remote_ip>
		<host_name><![CDATA[#CGI.REMOTE_HOST#]]></host_name>
		<file><![CDATA[#ExpandPath(CGI.Script_Name)#]]></file>
		<uri><![CDATA[#CGI.Script_Name#]]></uri>
	<cfif IsDefined("cfdebug_execution") AND cfdebug_execution.RecordCount GT 0>
		<total_execution_time><![CDATA[#Max(cfdebug_execution.executionTime, 0)# ms]]></total_execution_time>
	<cfelse>		
		<total_execution_time><![CDATA[0 ms]]></total_execution_time>
	</cfif>
	</general>

<cfif IsDefined("cfdebug_ex") AND cfdebug_ex.RecordCount GT 0>
	<exceptions>
		<cfloop query="cfdebug_ex">
		<cftry>
		<exception>
			<jump_to_line>
				<uri><![CDATA[#cfdebug_ex.template#]]></uri>
				<file><![CDATA[#cfdebug_ex.template#]]></file>
				<line_number><![CDATA[#cfdebug_ex.line#]]></line_number>
			</jump_to_line>
			<timestamp><![CDATA[#TimeFormat(Now(),"HH:mm:ss.SSS")#]]></timestamp>
			<type><cfif IsDefined("cfdebug_ex.name")><![CDATA[#cfdebug_ex.name#]]></cfif></type>
			<message><cfif IsDefined("cfdebug_ex.message") AND cfdebug_ex.message NEQ ""><![CDATA[#cfdebug_ex.message#]]><cfelse><cfif IsDefined("cfdebug_ex.name")><![CDATA[#cfdebug_ex.name#]]></cfif></cfif></message>
			<detail><cfif IsDefined("cfdebug_ex.stacktrace")><![CDATA[#cfdebug_ex.stacktrace#]]></cfif></detail>
			<error_code><cfif IsDefined("cfdebug_ex.stacktrace.errnumber")><![CDATA[1#cfdebug_ex.stacktrace.errnumber#]]></cfif></error_code>
			<extended_info><cfif IsDefined("cfdebug_ex.stacktrace.extendedinfo")><![CDATA[2#cfdebug_ex.stacktrace.extendedinfo#]]></cfif></extended_info>
		</exception>
			<cfcatch type="Any"></cfcatch>
		</cftry>
		</cfloop>
	</exceptions>
</cfif>	

<cfif cfkdebugger.check("Template")>
	<template_stack>
      	<cfquery dbType="query" name="cfdebug_top_level_execution_sum" debug="false">
      	SELECT sum(endTime - startTime) AS executionTime
      	FROM qEvents
      	WHERE type = 'Template' AND parent = ''
      	</cfquery>
        <cfset totalTemplatesTime = 0>
        <cfif cfdebug_top_level_execution_sum.recordCount GT 0>
            <cfif cfkdebugger.settings.template_mode EQ "tree">
                <cfset a = arrayNew(1)>
                <cfloop query="qEvents">
                   <cfscript>
                        // only want templates, IMQ of SELECT * ...where type = 'template' will result
                        // in cannot convert the value "" to a boolean for cachedquery column
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
                    #dwDrawTree(stTree,-1,topNodes.template)# 
                </cfloop>
            <cfelse>
                <cfset startToken = "CFC[ ">
                <cfset endToken = " | ">
                <cfquery dbType="query" name="cfdebug_templates_summary" debug="false">
                SELECT  template, Sum(endTime - startTime) AS totalExecutionTime, count(template) AS instances
                FROM qEvents
                WHERE type = 'Template'
                group by template
                order by totalExecutionTime DESC
                </cfquery>
                            
        		<cfloop query="cfdebug_templates_summary">
                <cfset thisTemplate = cfdebug_templates_summary.template>
                
                <cfset startTokenIndex = FindNoCase(startToken, thisTemplate, 1)>
                <cfif startTokenIndex EQ 0>
                    <cfset uri = template>
                <cfelse>
                    <cfset endTokenIndex = FindNoCase(endToken, thisTemplate, startTokenIndex)>
                    <cfset uri = Trim(Mid(thisTemplate,Len(startToken),endTokenIndex-Len(startToken)))>
                </cfif>
        		<template>
        			<jump_to_line>
        				<file><![CDATA[#uri#]]></file>
        				<uri><![CDATA[#cfdebug_templates_summary.instances# x #cfdebug_templates_summary.template#]]></uri>
        			</jump_to_line>
        			<execution_time><![CDATA[#cfdebug_templates_summary.totalExecutionTime# ms]]></execution_time>
        		</template>
        		</cfloop>
            </cfif>
        </cfif>
	</template_stack>
</cfif>

<cfif IsDefined("cfdebug_queries") AND cfdebug_queries.RecordCount GT 0
OR IsDefined("cfdebug_cfoql") AND cfdebug_cfoql.RecordCount GT 0
OR IsDefined("cfdebug_storedproc") AND cfdebug_storedproc.RecordCount GT 0>
	<database>
	<cfif IsDefined("cfdebug_queries") AND cfdebug_queries.RecordCount GT 0>
		<sql_queries>
			<cfloop query="cfdebug_queries">
			<sql_query>
				<jump_to_line>
					<uri><![CDATA[#cfdebug_queries.template#]]></uri>
					<file><![CDATA[#cfdebug_queries.template#]]></file>
					<line_number><![CDATA[#cfdebug_queries.line#]]></line_number>
				</jump_to_line>
				<name><![CDATA[#cfdebug_queries.name#]]></name>
				<dsn><![CDATA[#cfdebug_queries.datasource#]]></dsn>
				<record_count><![CDATA[#cfdebug_queries.rowcount#]]></record_count>
				<cfif IsDefined("cfdebug_queries.response.columnList")>
    				<column_list><![CDATA[#cfdebug_queries.response.columnList#]]></column_list>
				</cfif>
				<execution_time><![CDATA[#Max(cfdebug_queries.executionTime, 0)# ms]]></execution_time>
				<statement><![CDATA[#cfdebug_queries.body#]]></statement>
			</sql_query>
			</cfloop>
		</sql_queries>
	</cfif>

	<cfif IsDefined("cfdebug_storedproc") AND cfdebug_storedproc.RecordCount GT 0>
		<stored_procs>
        <cfloop query="cfdebug_storedproc">
			<proc>
				<name><![CDATA[#cfdebug_storedproc.name#]]></name>
				<dsn><![CDATA[#cfdebug_storedproc.datasource#]]></dsn>
				<dbserver><![CDATA[]]></dbserver>
				<jump_to_line>
					<uri><![CDATA[#cfdebug_storedproc.template#]]></uri>
					<file><![CDATA[#cfdebug_storedproc.template#]]></file>
					<line_number><![CDATA[#cfdebug_storedproc.line#]]></line_number>
				</jump_to_line>
				<execution_time><![CDATA[#Max(cfdebug_storedproc.executionTime, 0)# ms]]></execution_time>
				<proc_params>
                    <cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.attributes)#">
                    <cfset thisParam = #cfdebug_storedproc.attributes[cfdebug_storedproc.currentRow][x]#>
					<param>
						<cfif StructKeyExists(thisParam, "dbVarName")><db_var_name><![CDATA[#thisParam.dbVarName#]]></db_var_name></cfif>
						<cfif StructKeyExists(thisParam, "variable")><variable><![CDATA[#thisParam.variable#]]></variable></cfif>
						<cfif StructKeyExists(thisParam, "value")><value><![CDATA[#thisParam.value#]]></value></cfif>
						<cfif StructKeyExists(thisParam, "resultSet")><result_set><![CDATA[#thisParam.resultSet#]]></result_set></cfif>
						<cfif StructKeyExists(thisParam, "maxRow")><max_row><![CDATA[#thisParam.maxRow#]]></max_row></cfif>
						<cfif StructKeyExists(thisParam, "type")><type><![CDATA[#thisParam.type#]]></type></cfif>
                        <cfif StructKeyExists(thisParam, "sqlType")><sql_type><![CDATA[#thisParam.sqlType#]]></sql_type></cfif>
						<cfif StructKeyExists(thisParam, "nullAttribute")><null><![CDATA[#thisParam.nullAttribute#]]></null></cfif>
					</param>
                    </cfloop>
				</proc_params>
				<proc_results>
                    <cfloop index="x" from=1 to="#arrayLen(cfdebug_storedproc.result)#">
                        <cfset thisResult = #cfdebug_storedproc.result[cfdebug_storedproc.currentRow][x]#>
    					<result>
    						<cfif StructKeyExists(thisResult, "name")><name><![CDATA[#thisResult.name#]]></name></cfif>
    						<cfif StructKeyExists(thisResult, "resultSet")><result_set><![CDATA[#thisResult.resultSet#]]></result_set></cfif>
    						<cfif StructKeyExists(thisResult, "maxRow")><max_row><![CDATA[#thisResult.maxRow#]]></max_row></cfif>
    					</result>
                    </cfloop>
				</proc_results>
			</proc>
        </cfloop>
		</stored_procs>
	</cfif>
	</database>
</cfif>
	
<cfif IsDefined("cfkdebugger") AND bFoundScopeVars>
	<variables>
	<cftry>
	<cfif IsDefined("APPLICATION") AND StructCount(APPLICATION) GT 0 AND cfkdebugger.check("ApplicationVar")>
		<application>#dwSortedScope(application)#</application>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>

	<cftry>
	<cfif IsDefined("CGI") AND StructCount(CGI) GT 0 AND cfkdebugger.check("CGIVar")>
		<cgi>#dwSortedScope(cgi)#</cgi>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>	
	
	<cftry>
	<cfif IsDefined("CLIENT") AND StructCount(CLIENT) GT 0 AND cfkdebugger.check("ClientVar")>
		<client>#dwSortedScope(client)#</client>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>	
	
	<cftry>
	<cfif IsDefined("COOKIE") AND StructCount(COOKIE) GT 0 AND cfkdebugger.check("CookieVar")>
		<cookie>#dwSortedScope(cookie)#</cookie>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>
		
	<cftry>
	<cfif IsDefined("FORM") AND StructCount(FORM) GT 0 AND cfkdebugger.check("FormVar")>
		<form>#dwSortedScope(form)#</form>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<cftry>
	<cfif IsDefined("REQUEST") AND StructCount(REQUEST) GT 0 AND cfkdebugger.check("RequestVar")>
		<request>#dwSortedScope(request)#</request>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>

	<cftry>
	<cfif IsDefined("SERVER") AND StructCount(SERVER) GT 0 AND cfkdebugger.check("ServerVar")>
		<server>#dwSortedScope(server)#</server>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	
	<cftry>
	<cfif IsDefined("SESSION") AND StructCount(SESSION) GT 0 AND cfkdebugger.check("SessionVar")>
		<session>#dwSortedScope(session)#</session>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>	

	<cftry>
	<cfif IsDefined("URL") AND StructCount(URL) GT 0 AND cfkdebugger.check("URLVar")>
		<url>#dwSortedScope(url)#</url>
	</cfif>
		<cfcatch type="Any"></cfcatch>
	</cftry>
	</variables>
</cfif>

<cfif IsDefined("cfdebug_trace") AND cfdebug_trace.RecordCount GT 0>
	<trace_path>
        <cfset firstTrace=true>
        <cfset prevDelta=0>
		<cfloop query="cfdebug_trace">
        <cfset deltaFromRequest = Val(cfdebug_trace.endTime)>
        <cfset deltaFromLast = Val(deltaFromRequest-prevDelta)>
		<cftry>
		<trace_point>
			<jump_to_line>
				<uri><![CDATA[#cfdebug_trace.template#]]></uri>
				<file><![CDATA[#cfdebug_trace.template#]]></file>
				<line_number><![CDATA[#cfdebug_trace.line#]]></line_number>
			</jump_to_line>
			<timestamp><![CDATA[#TimeFormat(cfdebug_trace.timestamp,"HH:mm:ss.SSS")#]]></timestamp>
            <duration>#deltaFromRequest# ms (<cfif firstTrace>1st trace<cfelse>#deltaFromLast# ms</cfif>)</duration>
			<type><![CDATA[#cfdebug_trace.priority#]]></type>
            <cfif #cfdebug_trace.category# NEQ "">
    			<category><![CDATA[#cfdebug_trace.category#]]></category>            
            </cfif>
            <cfif #cfdebug_trace.message# NEQ "">
                <text><![CDATA[#cfdebug_trace.message#]]></text>            
            </cfif>
            <cfif #cfdebug_trace.result# NEQ "">
                <cfset equalSignIndex = Find("=", cfdebug_trace.result, 1)>
    			<variable>
    				<name><![CDATA[#Trim(Left(cfdebug_trace.result,equalSignIndex-1))#]]></name>
    				<value><![CDATA[#Trim(Right(cfdebug_trace.result,Len(cfdebug_trace.result)-equalSignIndex))#]]></value>
    			</variable>
            </cfif>            
		</trace_point>
			<cfcatch type="Any"></cfcatch>
		</cftry>
        <cfset prevDelta = deltaFromRequest>
        <cfset firstTrace=false>
		</cfloop>
	</trace_path>
</cfif>
</debug_root> 
cf_debug_end  -->
</cfoutput>

<cfsetting enablecfoutputonly="No">
