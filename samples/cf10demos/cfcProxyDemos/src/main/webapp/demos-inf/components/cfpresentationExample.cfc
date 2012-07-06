<cfcomponent>


    <cffunction name="slideDeckFlash">
        <cfargument name="dir">

        <cfif not directoryExists(expandPath(dir))>
            <cfdirectory action="create" directory="#expandPath(dir)#">
        </cfif>

        <cfpresentation
                title="ColdFusion JAX Presentation"
                autoplay="no"
                textcolor="##D3D3D3"
                destination="#expandPath(dir)#" overwrite="true">
            <cfpresenter name="Elishia" title="Solution Consultant" email="elishia@adobe.com">
            <cfpresenter name="Nimer" title="Solution Architect" email="mike.nimer@universalmind.com">

            <cfpresentationslide Title="ColdFusion Editions">
                <h3>ColdFusion 10 Editions</h3>
                <ul>
                    <li>
                        <strong>Standard Edition</strong> Targeted at a workgroup or single application deployed in an easy-to-manage configuration that is ideal for small to medium-sized businesses.
                    </li>
                    <li>
                        <strong>Enterprise Edition</strong> Created to deliver high-performing websites and multiple applications in a JEE, clustered or virtualized environment.
                    </li>
                    <li>
                        <strong>Developer Edition</strong> No cost, not licensed for production use. All features of Enterprise edition, but limited to access by only 2 IP addresses.
                    </li>
                    <li>
                        <strong>30-day Trial</strong> Fully functional enterprise edition that expires after 30 days. Reverts to developer edition at that time.
                    </li>

                </ul>
            </cfpresentationslide>

            <cfpresentationslide Title="Productivity without complexity">
                <h3>Productivity</h3>

                <li>Lower Development Costs</li>
                <li>Lower Maintenance Costs</li>
                <li>Enterprise Services</li>
                <li>Hibernate-based ORM</li>
                <li>Reporting / Charting / Graphs</li>
                <li>PDF Documents / Forms</li>
                <li>MS Exchange / SharePoint</li>
                <li>MS Office Interoperability</li>
                <li>Full-text Document Search</li>
                <li>Java EE Portlet Support</li>
                <li>AJAX UI Controls</li>
                <li>Monitoring & Management Tools</li>
                <li>Flash Remoting</li>
                <li>Much more...</li>

            </cfpresentationslide>
        </cfpresentation>

    </cffunction>

    <cffunction name="slideDeckHTML">
        <cfargument name="dir">
        <cfif not directoryExists(expandPath(dir))>
            <cfdirectory action="create" directory="#expandPath(dir)#">
        </cfif>

        <cfpresentation
                title="ColdFusion JAX Presentation"
                autoplay="no"
                textcolor="##D3D3D3"
                format="html"
                destination="#expandPath(dir)#" overwrite="true">
            <cfpresenter name="Elishia" title="Solution Consultant" email="elishia@adobe.com">
            <cfpresenter name="Nimer" title="Solution Architect" email="mike.nimer@universalmind.com">

            <cfpresentationslide Title="ColdFusion Editions">
                <h3>ColdFusion 10 Editions</h3>
                <ul>
                    <li>
                        <strong>Standard Edition</strong> Targeted at a workgroup or single application deployed in an easy-to-manage configuration that is ideal for small to medium-sized businesses.
                    </li>
                    <li>
                        <strong>Enterprise Edition</strong> Created to deliver high-performing websites and multiple applications in a JEE, clustered or virtualized environment.
                    </li>
                    <li>
                        <strong>Developer Edition</strong> No cost, not licensed for production use. All features of Enterprise edition, but limited to access by only 2 IP addresses.
                    </li>
                    <li>
                        <strong>30-day Trial</strong> Fully functional enterprise edition that expires after 30 days. Reverts to developer edition at that time.
                    </li>

                </ul>
            </cfpresentationslide>

            <cfpresentationslide Title="Productivity without complexity">
                <h3>Productivity</h3>

                <li>Lower Development Costs</li>
                <li>Lower Maintenance Costs</li>
                <li>Enterprise Services</li>
                <li>Hibernate-based ORM</li>
                <li>Reporting / Charting / Graphs</li>
                <li>PDF Documents / Forms</li>
                <li>MS Exchange / SharePoint</li>
                <li>MS Office Interoperability</li>
                <li>Full-text Document Search</li>
                <li>Java EE Portlet Support</li>
                <li>AJAX UI Controls</li>
                <li>Monitoring & Management Tools</li>
                <li>Flash Remoting</li>
                <li>Much more...</li>

            </cfpresentationslide>
        </cfpresentation>

    </cffunction>


    <cffunction name="slideDeckPPT">
        <cfargument name="dir">

        <cfif not directoryExists(expandPath(dir))>
            <cfdirectory action="create" directory="#expandPath(dir)#">
        </cfif>

        <cfpresentation
                title="ColdFusion JAX Presentation"
                autoplay="no"
                format="ppt"
                textcolor="##D3D3D3"
                destination="#expandPath(dir)#/preso.ppt"
                overwrite="true">
            <cfpresenter name="Elishia" title="Solution Consultant" email="elishia@adobe.com">
            <cfpresenter name="Nimer" title="Solution Architect" email="mike.nimer@universalmind.com">

            <cfpresentationslide Title="ColdFusion Editions">
                <h3>ColdFusion 10 Editions</h3>
                <ul>
                    <li>
                        <strong>Standard Edition</strong> Targeted at a workgroup or single application deployed in an easy-to-manage configuration that is ideal for small to medium-sized businesses.
                    </li>
                    <li>
                        <strong>Enterprise Edition</strong> Created to deliver high-performing websites and multiple applications in a JEE, clustered or virtualized environment.
                    </li>
                    <li>
                        <strong>Developer Edition</strong> No cost, not licensed for production use. All features of Enterprise edition, but limited to access by only 2 IP addresses.
                    </li>
                    <li>
                        <strong>30-day Trial</strong> Fully functional enterprise edition that expires after 30 days. Reverts to developer edition at that time.
                    </li>

                </ul>
            </cfpresentationslide>

            <cfpresentationslide Title="Productivity without complexity">
                <h3>Productivity</h3>

                <li>Lower Development Costs</li>
                <li>Lower Maintenance Costs</li>
                <li>Enterprise Services</li>
                <li>Hibernate-based ORM</li>
                <li>Reporting / Charting / Graphs</li>
                <li>PDF Documents / Forms</li>
                <li>MS Exchange / SharePoint</li>
                <li>MS Office Interoperability</li>
                <li>Full-text Document Search</li>
                <li>Java EE Portlet Support</li>
                <li>AJAX UI Controls</li>
                <li>Monitoring & Management Tools</li>
                <li>Flash Remoting</li>
                <li>Much more...</li>

            </cfpresentationslide>
        </cfpresentation>

    </cffunction>


    <cffunction name="example1">
        <cfargument name="dir">
        <cfset var expandedDir = expandPath(dir)>

        <cfif not directoryExists(expandPath(dir))>
            <cfdirectory action="create" directory="#expandPath(dir)#">
        </cfif>

        <cfpresentation
                title="Sample"
                autoplay="no"
                destination="#expandPath(dir)#"
                overwrite="true">

            <cfpresentationslide advance="click">
                <h1>Sample CFPresentation PDF Output!</h1>
                The time is
                <cfoutput>#now()#</cfoutput>
            </cfpresentationslide>
            <cfpresentationslide advance="click">
                <h1>Slide Two</h1>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            </cfpresentationslide>
            <cfpresentationslide advance="click">
                <h1>Slide Three: Its a loop!</h1>
                <cfloop from="1" to="12" index="current">
                    <cfoutput>#monthAsString(current)#<br/></cfoutput>
                </cfloop>
            </cfpresentationslide>

        </cfpresentation>

    </cffunction>





    <cffunction name="example2">
        <cfargument name="dir">
        <cfset var expandedDir = expandPath(dir)>

        <cfif not directoryExists(expandPath(dir))>
            <cfdirectory action="create" directory="#expandPath(dir)#">
        </cfif>

<!--- The following query extracts employee data from the cfdocexamples
database. --->
        <cfquery name="GetSalaryDetails" datasource="cfdocexamples">
            SELECT Departmt.Dept_Name,
                Employee.FirstName,
                Employee.LastName,
                Employee.StartDate,
                Employee.Salary,
                Employee.Contract
            From Departmt, Employee
            Where Departmt.Dept_ID = Employee.Dept_ID
            ORDER BY Employee.LastName, Employee.Firstname
        </cfquery>

<!--- The following code creates a presentation with three presenters. --->
        <cfpresentation title="Employee Satisfaction" primaryColor="##0000FF" glowColor="##FF00FF" lightColor="##FFFF00" showoutline="no">
            <cfpresenter name="Jeff" title="CFO" email="jeff@company.com"
                    logo="../cfdocs/getting_started/photos/somewhere.jpg"
                    image="../cfdocs/images/artgallery/jeff01.jpg">
            <cfpresenter name="Lori" title="VP Marketing" email="lori@company.com"
                    logo="../cfdocs/getting_started/photos/somewhere.jpg"
                    image="../cfdocs/images/artgallery/lori01.jpg">
            <cfpresenter name="Paul" title="VP Sales" email="paul@company.com"
                    logo="../cfdocs/getting_started/photos/somewhere.jpg"
                    image="../cfdocs/images/artgallery/paul01.jpg">

<!--- The following code creates the first slide in the presentation
            from HTML. --->
            <cfpresentationslide title="Introduction" presenter="Jeff"
                    audio="myAudio1.mp3" duration="5">
                <h3>Introduction</h3>
                <table>
                    <tr>
                        <td>
                            <ul>
                                <li>Company Overview</li>
                                <li>Salary by Department</li>
                                <li>Employee Salary Details</li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </cfpresentationslide>

<!--- The following code creates the second slide in the presentation.
            The chart is populated with data from the database query. --->
            <cfpresentationslide title="Salary by Department" presenter="Lori"
                    duration="5" audio="myAudio3.mp3">
                <h3>Salary by Department</h3>
                <cfchart format="jpg" xaxistitle="Department" yaxistitle="Salary">
                    <cfchartseries type="bar" query="GetSalaryDetails"
                            itemcolumn="Dept_Name" valuecolumn="salary">
                </cfchartseries>
                </cfchart>
            </cfpresentationslide>

<!--- The following code creates the third slide in the presentation. The table is populated with data from the query. The table also contains an image located relative to the CFM page on the server. --->
            <cfpresentationslide title="Salary Details" presenter="Paul"
                    duration="10" audio="myAudio1.mp3">
                <h3>Employee Salary Details</h3>
                <table border cellspacing=0 cellpadding=5 valign="top">
                <tr>
                <td>
                <table border cellspacing=0 cellpadding=5 valign="top">
                    <tr>
                        <th>Employee Name</th>
                        <th>Start Date</th>
                        <th>Salary</th>
                        <th>Department</th>
                        <th>Contract?</th>
                    </tr>
                <cfoutput query="GetSalaryDetails">
                        <tr>
                        <td>#FirstName# #LastName#</td>
                    <td>#dateFormat(StartDate, "mm/dd/yyyy")#</td>
                    <td>#numberFormat(Salary, "$9999,9999")#</td>
                    <td>#dept_name#</td>
                    <td>#Contract#</td>
                    </tr></cfoutput>
                </table>
                </td>
                    <td width="200">
                        <img src="images/raquel02.jpg"/>
                    </td>
                </table>
            </cfpresentationslide>
        </cfpresentation>

    </cffunction>
</cfcomponent>