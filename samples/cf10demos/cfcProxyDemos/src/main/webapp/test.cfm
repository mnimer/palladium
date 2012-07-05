<cfscript>
    if( isDefined("form.FileContents") )
    {
        cfc = createObject("component", "demos-inf.components.CFFileExample");
        cfc.s3Upload();
    }
</cfscript>


<form method="post" enctype="multipart/form-data">

    <input type="file" name="FileContents" value="Choose File">
    <input type="submit" value="Upload File">

</form>