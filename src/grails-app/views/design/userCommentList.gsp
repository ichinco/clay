<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 1/16/12
  Time: 3:40 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><meta name='layout' content='clay'/></head>
  <body>
        <g:each in="comments" var="currentComment">
            <g:render template="currentComment" model="[currentComment:currentComment]" />
        </g:each>
  </body>
</html>