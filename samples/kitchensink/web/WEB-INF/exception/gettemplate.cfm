
<!--- Show or hide "miscellaneous exception properties"  - 
      they don't make sense for some exceptions, e.g., syntax --->
<cfparam name="attributes.DiagnosticDisplay" default="block">

<!---  Show context lines: default number determined by admin --->
<!--- FIXME: testing this facility --->
<cfparam name="attributes.showcontext" default=2>
 
<!--- Discard number of context levels equal to attributes.tagContextOffset --->
<cfparam name="attributes.tagContextOffset" type="numeric" default="0">


<cfscript>
    vjava = Arraynew(1);
	vcfml = arraynew(1);
	b = true;
	while (b) 
	{
		context = error.tagContext;
		for (i = 1 + attributes.tagContextOffset; i lte arrayLen(context); i = i + 1)
		{
			nextLine = context[i];

			if (isDefined("nextline.raw_trace"))
			{
				ArrayAppend(vJava, nextLine.RAW_TRACE);

				if (nextLine.TYPE IS "CFML")
				{
					vfsfilefactory = createObject("java", "coldfusion.vfs.VFSFileFactory");
					errorfile = vfsfilefactory.getFileObject(nextLine.TEMPLATE);
					if( NOT errorfile.exists() )
					{
						//probably a soucreless deployed file.
						CFMLTrace = errorfile.getName() & ": line " & nextLine.LINE;
					}
					else
					{
						CFMLTrace = nextLine.TEMPLATE & ": line " & nextLine.LINE;
					}
					ArrayAppend(vCFML, CFMLTrace);
					if ( not isDefined ( "errorLocation" ) )
					    errorLocation = nextLine;
				}
			}
			else if ( nextLine.type IS "SYNTAX" )
			{
				CFMLTrace = nextLine.TEMPLATE & ": line " & nextLine.LINE;
				ArrayAppend(vCFML, CFMLTrace);

				if ( not isDefined ( "errorLocation" ) )
					errorLocation = nextLine;
			}
		}
		if (ParameterExists(error.rootcause))
		{
			ArrayAppend(vjava, "#chr(13)##chr(10)#");
			error = error.rootCause;
		}
		else
		{
			b = false;
		}
	}
</cfscript>
