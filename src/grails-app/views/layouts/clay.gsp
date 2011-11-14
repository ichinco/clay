<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/13/11
  Time: 6:25 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Humble Abode" /></title>
        <g:layoutHead />
        <g:javascript library="application" />
        <g:javascript library="jquery" plugin="jquery"/>
    </head>
    <body>
        <g:if test="${request.signedIn}">
            <div>${request.username} |
            <g:link controller="logout">logout</g:link> </div>
        </g:if>
        <g:else >
            <div>
                <g:link controller="login" action="create.gsp">Sign Up</g:link> |
                <g:link controller="login">Sign In</g:link>
            </div>
        </g:else>
        <g:layoutBody />
    </body>
</html>