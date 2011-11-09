<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:each in="${designs}" var="design">
        <div>${design.id}</div>
        <div>${design.title}</div>
    </g:each>
</html>