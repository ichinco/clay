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

    <g:form controller="design" action="save" method='POST' >
        <label for="title">title:</label>
        <g:textField name="title" /><br />
        <label for="description">description</label>
        <g:textArea name="description" rows="3" cols="50" /><br />
        <g:submitButton id="submitButton" name="submitButton" value="submit" />
    </g:form>

    <g:form action="upload" method="post" enctype="multipart/form-data">
        <g:hiddenField name="designId" value="${designId}" />
        <input id="image" type="file" name="image" /><br />
        <input id="submitButton" type="submit" />
    </g:form>

    <jq:plugin name="validate" />
    <g:javascript>
        $("form").validate({
            rules : {
                title : "required",
                description : {
                    required : true,
                    minlength : 20,
                    maxlength : 500
                }
            },
            messages : {
                title : "Must give it a title!",
                description : "Description must be longer than 20 charaacters."
            },
            submitHandler : function(form) {
                $("#submitButton").attr('disabled','disabled');
                form.submit();
            }
        });
    </g:javascript>
</html>