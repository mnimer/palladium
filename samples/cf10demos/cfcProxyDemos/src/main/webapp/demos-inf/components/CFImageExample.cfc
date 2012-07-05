<cfcomponent hint="Image manipulation to S3">

    <cffunction name="upload" output="false" >
        <cfargument name="fileName">
        <cfimage action="write"
                source="s3://AdobeDemo/#arguments.fileName#"
                destination="s3://AdobeDemo/#arguments.fileName#_small.JPG"
                overwrite="no" height="100" width="100">
    </cffunction>


    <cffunction name="resizeToThumbnail" output="false" >
        <cfargument name="fileName">
        <cfimage action="resize"
                source="s3://AdobeDemo/#arguments.fileName#"
                destination="s3://AdobeDemo/#arguments.fileName#_small.JPG"
                overwrite="no" height="100" width="100">
    </cffunction>


    <cffunction name="rotate" output="false" >
        <cfargument name="fileName">
        <cfimage action="rotate"
                source="s3://AdobeDemo/#arguments.fileName#"
                destination="s3://AdobeDemo/#arguments.fileName#_rotated.JPG"
                overwrite="no" angle="90">
    </cffunction>
</cfcomponent>