<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/15/11
  Time: 9:22 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:form controller="design" action="addImagePoint">
        <label for="x">x</label>
        <g:textField name="x" /> <br />
        <label for="y">y</label>
        <g:textField name="y" /> <br />
        <label for="productName">productName</label>
        <g:textField name="productName" /> <br />
        <label for="productUrl">productUrl</label>
        <g:textField name="productUrl" /> <br />
        <label for="imageId">image id</label>
        <g:textField name="imageId" /> <br />
        <g:submitButton name="submit" value="submit" />
    </g:form>
</html>