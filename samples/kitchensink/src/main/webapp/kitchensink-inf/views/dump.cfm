<cfdump var="#request['cfcResult']#">
<cfdump var="#request#" expand="true">



<context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>
        /WEB-INF/spring-security.xml
        /WEB-INF/applicationContext.xml
    </param-value>
</context-param>


<!-- SPRING SECURITY -->
<filter>
    <filter-name>springSecurityFilterChain</filter-name>
    <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>


<filter-mapping>
    <filter-name>springSecurityFilterChain</filter-name>
    <url-pattern>/kitchensink/*</url-pattern>
</filter-mapping>
<!-- SPRING SECURITY -->


<listener>
    <listener-class>
        org.springframework.web.context.ContextLoaderListener
    </listener-class>
</listener>

<!-- ********************* CFMJ ************************ -->

<servlet>
    <servlet-name>kitchensink-mvc</servlet-name>
    <servlet-class>coldfusion.bootstrap.BootstrapServlet</servlet-class>
    <init-param>
        <param-name>servlet.class</param-name>
        <param-value>org.springframework.web.servlet.DispatcherServlet</param-value>
    </init-param>

    <load-on-startup>1</load-on-startup>
</servlet>
<servlet>
    <servlet-name>kitchensink-theme-mvc</servlet-name>
    <servlet-class>coldfusion.bootstrap.BootstrapServlet</servlet-class>
    <init-param>
        <param-name>servlet.class</param-name>
        <param-value>org.springframework.web.servlet.DispatcherServlet</param-value>
    </init-param>

    <load-on-startup>1</load-on-startup>
</servlet>
<servlet>
    <servlet-name>kitchensink-propertytest-mvc</servlet-name>
    <servlet-class>coldfusion.bootstrap.BootstrapServlet</servlet-class>
    <init-param>
        <param-name>servlet.class</param-name>
        <param-value>org.springframework.web.servlet.DispatcherServlet</param-value>
    </init-param>

    <load-on-startup>1</load-on-startup>
</servlet>
<servlet>
    <servlet-name>kitchensink-security-mvc</servlet-name>
    <servlet-class>coldfusion.bootstrap.BootstrapServlet</servlet-class>
    <init-param>
        <param-name>servlet.class</param-name>
        <param-value>org.springframework.web.servlet.DispatcherServlet</param-value>
    </init-param>

    <load-on-startup>1</load-on-startup>
</servlet>


<!-- Map all REST request to /requestbroker -->
<servlet-mapping>
    <servlet-name>kitchensink-mvc</servlet-name>
    <url-pattern>/kitchensink/*</url-pattern>
</servlet-mapping>
<servlet-mapping>
    <servlet-name>kitchensink-theme-mvc</servlet-name>
    <url-pattern>/kitchensink/themes/*</url-pattern>
</servlet-mapping>
<servlet-mapping>
    <servlet-name>kitchensink-propertytest-mvc</servlet-name>
    <url-pattern>/kitchensink/propertyTests/*</url-pattern>
</servlet-mapping>

<servlet-mapping>
    <servlet-name>kitchensink-security-mvc</servlet-name>
    <url-pattern>/kitchensink/security/*</url-pattern>
</servlet-mapping>

<!-- ********************* CFMJ ************************ -->


