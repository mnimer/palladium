<cfcomponent>

    <cffunction name="pdfForm">
        <cfargument name="PolicyNum"/>
        <cfargument name="strInsuredName"/>
        <cfargument name="address1"/>
        <cfargument name="State"/>
        <cfargument name="Zip"/>
        <cfargument name="city"/>
        <cfargument name="phone"/>
        <cfargument name="bankName"/>
        <cfargument name="PaymentName"/>
        <cfargument name="bankAcctNum"/>
        <cfargument name="bankCity"/>


        <cfpdfform name="myForm"
                action="populate"
                source="#expandPath('/demos-inf/pdfs/EFTAuthorization.pdf')#">
            <cfpdfformparam name="ViewPolicy*PolicyNum" value="#PolicyNum#">
            <cfpdfformparam name="ViewPolicy*strInsuredName" value="#strInsuredName#">
            <cfpdfformparam name="ViewPolicy*address1" value="#address1#">
            <cfpdfformparam name="ViewPolicy*State" value="#State#">
            <cfpdfformparam name="ViewPolicy*Zip" value="#Zip#">
            <cfpdfformparam name="ViewPolicy*city" value="#city#">
            <cfpdfformparam name="ViewPolicy*phone" value="#phone#">
            <cfpdfformparam name="EFTAuthorization*bankName" value="#bankName#">
            <cfpdfformparam name="EFTAuthorization*PaymentName" value="#PaymentName#">
            <cfpdfformparam name="EFTAuthorization*bankAcctNum" value="#bankAcctNum#">
            <cfpdfformparam name="EFTAuthorization*bankCity" value="#bankCity#">
        </cfpdfform>

        <cfset binaryPdf = ToBinary(myForm)>

        <cffile action="write"
                file="#expandPath('/demos-inf/pdfs/populatedForm.pdf')#"
                output="#binaryPdf#"/>

        <cfset results = structNew()>
        <cfset results['pdf'] = binaryPdf>
        <cfreturn results>
    </cffunction>




    <cffunction name="readPdf">
        <cfpdfform
                action="read"
                source="#expandPath('/demos-inf/pdfs/populatedForm.pdf')#"
                result="pdfResult"/>


        <cfset results = structNew()>
        <cfset results['pdf'] = pdfResult>
        <cfreturn results>
    </cffunction>



    <cffunction name="dump">
        <cfargument name="data">

        <cfsavecontent variable="dump">
            <cfdump var="#data#" expand="true"/>
        </cfsavecontent>

        <cfreturn dump>
    </cffunction>
</cfcomponent>
