<cfparam name="request.errorMessage" default="Unknown Error"/>

<cfinclude template="_header.cfm"/>
<!-- wrapper block to constrain widths -->
<div id="wrapper">

    <!-- begin body content -->
    <div id="content">
        <cfoutput>

            <cfif request.errorMessage is not "">
                <p><strong>#request.errorMessage#</strong></p>
                <cfdump var="#request#"/>
            </cfif>

        </cfoutput>
    </div>

</div>
<cfinclude template="_footer.cfm">