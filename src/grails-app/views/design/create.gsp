<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:01 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay" />
    </head>

    <label for="title">title:</label>
    <g:textField name="title" /><br />
    <label for="description">description</label>
    <g:textArea name="description" rows="3" cols="50" /><br />

    <ul id="uploadedImages"></ul>

    <g:form name="up" action="upload" method="post" enctype="multipart/form-data" encoding="multipart/form-data">
        <g:hiddenField name="designId" value="${design.id}" />
        <input id="image" type="file" name="image" /><br />
        <g:submitButton name="submitButton" value="submit" />
    </g:form>

    <g:submitButton id="submitButton" name="submitButton" value="submit" />

    <jq:plugin name="form" />

<g:javascript>
    $(document).ready(function() {
        alert($('#up').length);
        $('#up').ajaxForm();
    });
</g:javascript>
</html>