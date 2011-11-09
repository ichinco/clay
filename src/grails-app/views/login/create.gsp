<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:28 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:form controller="user" action="create">
        <label for="username">username</label>
        <g:textField name="username" />
        <label for="password">password</label>
        <g:passwordField name="password" />
        <g:submitButton name="submit" value="submit" />
    </g:form>
</html>