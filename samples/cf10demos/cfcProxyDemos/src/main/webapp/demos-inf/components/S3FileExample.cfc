<cfcomponent hint="File IO to S3 bucket">


    <cffunction name="s3List" output="false" returntype="Struct" > 
		<cfdirectory name="listDemo" action="list" directory="s3://AdobeDemo" />
		<cfreturn listDemo> 
    </cffunction> 


    <cffunction name="s3Upload" output="false">
		<cfset var FileContents="">
        <cffile action = "upload"  
            fileField = "FileContents"
            destination = "s3://AdobeDemo"
            accept = "image/jpeg,text/plain"
            nameConflict = "MakeUnique">
     </cffunction> 


     <cffunction name="s3write" output="false">
		<cfset var demoContents="">
        <cffile action="append" addnewline="yes" file="s3://AdobeDemo/demo.txt" output="Ama-zing-ly simple...">
		<cffile action="read" file="s3://AdobeDemo/demo.txt" variable="demoContents" >
		<cfreturn demoContents>  
     </cffunction> 
</cfcomponent>