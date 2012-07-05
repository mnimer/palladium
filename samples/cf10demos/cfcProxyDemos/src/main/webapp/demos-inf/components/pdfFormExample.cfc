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


        <cfpdfform name="myForm" action="populate" source="#expandPath('/demos-inf/pdfs/EFTAuthorization.pdf')#">
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

        <cfset results = structNew()>
        <cfset results['pdf'] = ToBinary(myForm)>
        <cfreturn results>
    </cffunction>
</cfcomponent>

<!---
    <cfpdfform name="myForm" action="populate" source="#expandPath('/demos-inf/pdfs/EFTAuthorization.pdf')#">
            <cfpdfformparam name="ViewPolicy*PolicyNum" value="PY-343434343-01">
            <cfpdfformparam name="ViewPolicy*strInsuredName" value="Matt Gifford Esq">
            <cfpdfformparam name="ViewPolicy*address1" value="454 Groovy Street">
            <cfpdfformparam name="ViewPolicy*State" value="GA">
            <cfpdfformparam name="ViewPolicy*Zip" value="31443">
            <cfpdfformparam name="ViewPolicy*city" value="St Albans">
            <cfpdfformparam name="ViewPolicy*phone" value="(555) 555-5555">
            <cfpdfformparam name="EFTAuthorization*bankName" value="Dewey Cheatem & Howe">
            <cfpdfformparam name="EFTAuthorization*PaymentName" value="Matt Gifford">
            <cfpdfformparam name="EFTAuthorization*bankAcctNum" value="45454545">
            <cfpdfformparam name="EFTAuthorization*bankCity" value="St Albans">
        </cfpdfform>
--->