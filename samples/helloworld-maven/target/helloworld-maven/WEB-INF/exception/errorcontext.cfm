<!--- 
  errorcontext.cfm reads the file specified by a TAGCONTEXT-type struct 
  and returns an array of structures which contain the text of  the failing 
  line,and lines near it, along with their line numbers.

  @param errorLocation  - the TAGCONTEXT entry for the failed template/line.
  @param showcontext    - number of additional lines before/after failure displayed.
  @param resultVariable - the name of the caller's var where the resulting 

--->

<cfparam name="attributes.errorLocation">
<cfparam name="attributes.showcontext">
<cfparam name="attributes.resultVariable">

<cfif thistag.executionmode is "start">

	<!--- localization --->
	<cfset locale = createObject("java", "java.util.Locale").getDefault().getLanguage()>
	<cfset l10n_caller = "detail">
    
    <cftry>
        <cfif FileExists("exception_#locale#.xml")>
            <cfinclude template="exception_#locale#.xml">
        <cfelse>
            <cfinclude template="exception_en.xml">
        </cfif>
        <cfcatch>
            <cfinclude template="exception_en.xml">
        </cfcatch>
    </cftry>
	
	<cfset result = ArrayNew(1)>
	<cfscript>
		try
		{
		firstLine = attributes.errorLocation.line - attributes.showcontext;
		lastLine  = attributes.errorLocation.line + attributes.showcontext;

		//create an instance of VFSFileFactory to fetch the intputstream
		vfsfilefactory = createObject("java", "coldfusion.vfs.VFSFileFactory");
		
		//get the input stream for the file
		inputStream = vfsfilefactory.getInputStream(attributes.errorLocation.Template);
		
		//  Wrap a InputStreamReader in a LineNumberReader to read the CFML template as text.
		inputStreamReaderClass = createObject("java", "java.io.InputStreamReader");
		inputStreamReader = inputStreamReaderClass.init(inputStream);
		
		lineReaderClass = createObject("java", "java.io.LineNumberReader" );
		lineReader = lineReaderClass.init(inputStreamReader);

		currentLine = lineReader.readLine();

		while ( isDefined("currentLine") and lineReader.getLineNumber() lte lastLine )
		{
			if ( lineReader.getLineNumber() gte firstLine )
			{
			    lineInfoStruct            = structNew();
				lineInfoStruct.line       = currentLine;
				lineInfoStruct.lineNumber = lineReader.getLineNumber();
				ArrayAppend(result, lineInfoStruct);
			}
			currentLine = lineReader.readLine();
		}
		} catch ( "Any" ex) {
			lineInfoStruct = structNew();
			lineInfoStruct.line = s_unable;
			lineInfoStruct.lineNumber = -1;
			lineInfoStruct.diagnostic = ex;
				
			ArrayAppend(result, lineInfoStruct);
		}
		finally
		{
			if(isDefined("lineReader"))
			{
				lineReader.close();
			}
		}	

	</cfscript>

	<cfset setVariable("caller.#attributes.resultVariable#", result )>
</cfif>
