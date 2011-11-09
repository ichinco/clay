<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.clay.Comment" contentType="text/html;charset=UTF-8" %>
<html>

    <div>${design.id}</div>
    <div>${design.title}</div>
    <div>${design.description}</div>

    <g:render template="comment" model="[currentComment:null, comments:design.comments, designId:design.id]" />
</html>