<cfimport prefix="spring" taglib="/WEB-INF/spring.tld">
<html>
    <head>
        <title><spring:message code="page.title"/></title>
        <link href='<spring:theme code="css" />' rel="stylesheet" type="text/css" />
    </head>
<body class="">
    Pick a Theme:<br/>
    <p><spring:message code="loremIpsum"/></p>

    <a href="../">Back</a>
    <br/>
    <a href="?theme=default">Default</a>
    <br/>
    <a href="?theme=blue">Blue</a>
    <br/>
    <a href="?theme=yellow">Yellow</a>

<br/><br/>
<cfdump var="#request#" expand="false"/>


</body>
</html>