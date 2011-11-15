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

    <g:link controller="design" action="create">create design</g:link><br/><br/>

    <g:each in="${designs}" var="design">
        <g:link controller="design" action="show" params="[id:design.id]">
            <div>${design.title}</div>
        </g:link>
    </g:each>
</html>