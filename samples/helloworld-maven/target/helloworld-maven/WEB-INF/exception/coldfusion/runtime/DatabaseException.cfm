<cfimport taglib="../.." prefix="ex"/>
<cfscript>
	try {
        factory = CreateObject("JAVA", "coldfusion.server.ServiceFactory");
    	cfdebugger = factory.getDebuggingService();
        bRobustEnabled = cfdebugger.isRobustEnabled();
    } catch( "any" ex ) {
        bRobustEnabled = false;
    }

	errorProperties = structNew();
    if(bRobustEnabled) {
    	if( isdefined("error.sql")) errorProperties.sql = error.sql;
    	if( isdefined("error.datasource")) errorProperties.datasource = error.datasource;
    	if( isdefined("error.nativeerrorcode") AND error.nativeerrorcode NEQ 0) errorProperties.vendorErrorCode = error.nativeerrorcode;
    	if( isdefined("error.sqlState") AND error.sqlState NEQ "n/a") errorProperties.sqlState = error.sqlState;
		if( isdefined("error.exceptions") and not isnull("#error.exceptions#")) errorProperties.exceptions = error.exceptions;
    }
</cfscript>
<ex:detail properties=#errorProperties# error=#error#/>
