<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay"/>
    </head>
    <body>

        <div class="designWrapper">
            <g:each in="${designs}" var="design" status="i">
                <g:render template="design" model="[design:design]" />
            </g:each>
        </div>
    </body>
</html>