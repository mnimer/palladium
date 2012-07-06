<cfcomponent>

    <cffunction name="imageInfo">
        <cfargument name="image"/>

        <cfimage
                action="info"
                source="#expandPath(arguments.image)#"
                structname="cfimage">

        <cfreturn cfimage/>
    </cffunction>

    <cffunction name="rotateImage">
        <cfargument name="image"/>
        <cfargument name="angle" default="90"/>

        <cfimage
                action="rotate"
                angle="#arguments.angle#"
                source="#expandPath(arguments.image)#"
                name="cfimage">

        <cfreturn cfimage/>
    </cffunction>


    <cffunction name="resizeImage">
        <cfargument name="image"/>
        <cfargument name="width" default="1024"/>
        <cfargument name="height" default="768"/>

        <cfimage
                action="resize"
                width="#arguments.width#"
                height="#arguments.height#"
                source="#expandPath(arguments.image)#"
                interpolation="bicubic"
                name="cfimage">

        <cfreturn cfimage/>
    </cffunction>


    <cffunction name="addBorder">
        <cfargument name="image"/>
        <cfargument name="color" default="1024"/>
        <cfargument name="thickness" default="10"/>

        <cfimage
                action="border"
                color="#arguments.color#"
                thickness="#arguments.thickness#"
                source="#expandPath(arguments.image)#"
                name="cfimage">

        <cfreturn cfimage/>
    </cffunction>



    <cffunction name="addWatermark">
        <cfargument name="image"/>
        <cfargument name="watermark"/>

        <cfset myImage = ImageNew(expandPath(arguments.image))>

        <cfset ImageSetDrawingColor(myImage, "white")>
        <cfset attr=StructNew()>
        <cfset attr.size=50>
        <cfset attr.style="bold">
        <cfset ImageDrawText(myImage, watermark,650,610, attr)>


        <cfreturn myImage/>
    </cffunction>



    <cffunction name="generateCaptcha">
        <cfargument name="difficulty"/>
        <cfargument name="width"/>
        <cfargument name="height"/>
        <cfargument name="text"/>

        <cfimage
                action="captcha"
                difficulty="#arguments.difficulty#"
                width="#arguments.width#"
                height="#arguments.height#"
                text="#arguments.text#"
                fontSize="40"
                fonts="Verdana,Arial,Courier New,Courier"
                name="cfimage">


        <!---cfimage name="cfimage" action="captcha" fontSize="25" width="162" height="75" text="rEadMe"
                fonts="Verdana,Arial,Courier New,Courier"--->


        <cfreturn cfimage/>
    </cffunction>


    <cffunction name="dump">
        <cfargument name="data">

        <cfsavecontent variable="dump">
            <cfdump var="#data#" expand="true"/>
        </cfsavecontent>

        <cfreturn dump>
    </cffunction>
</cfcomponent>