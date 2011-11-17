<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:form controller="design" action="save" method='POST' >
        <label for="title">title:</label>
        <g:textField name="title" /><br />
        <label for="description">description</label>
        <g:textArea name="description" rows="3" cols="50" /><br />
        <g:submitButton name="submit" value="submit" />
        // TODO prevent form monkey-click
    </g:form>
</html>