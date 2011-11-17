<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/15/11
  Time: 9:20 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:form action="upload" method="post" enctype="multipart/form-data">
        <g:hiddenField name="designId" value="${designId}" />
        <input type="file" name="image" /><br />
        <input type="submit" />
    </g:form>
</html>