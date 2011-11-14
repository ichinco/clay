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
    <g:each in="${designs}" var="design">
        <g:link controller="design" action="show" model="[id:${design.id}]">
            <div>${design.title}</div>
        </g:link>
    </g:each>
</html>