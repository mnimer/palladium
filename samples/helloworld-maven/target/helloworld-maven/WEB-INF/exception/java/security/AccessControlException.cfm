<cfimport taglib="../.." prefix="ex">
<cfscript>
classname = error.permission.class.name;
// here we can use classname to dynamically construct the access denied
// message...

message = "Security: The requested template has been denied access to ";
message = message & #error.permission.name# & ".";

detail = "The following is the internal exception message: ";
detail = detail & #error.message#;
</cfscript>
<ex:detail message='#message#' detail=#detail# error=#error#/>
