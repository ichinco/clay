<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:form controller="design" action="save" >
        <label for="title">title:</label>
        <g:textField name="title" /><br />
        <label for="description">description</label>
        <g:textArea name="description" rows="3" cols="50" /><br />
        <label for="imageUrl1">image url:</label>
        <g:textField name="imageUrl1" /><br />
        <label for="imageUrl2">image url:</label>
        <g:textField name="imageUrl2" /><br />
        <label for="imageUrl3">image url:</label>
        <g:textField name="imageUrl3" /><br />
        <g:submitButton name="submit" value="submit" />
    </g:form>

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