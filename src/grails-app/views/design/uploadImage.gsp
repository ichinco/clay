<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/15/11
  Time: 9:20 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay" />
    </head>
    <g:form action="upload" method="post" enctype="multipart/form-data">
        <g:hiddenField name="designId" value="${designId}" />
        <input id="image" type="file" name="image" /><br />
        <input id="submitButton" type="submit" />
    </g:form>

    <jq:plugin name="validate" />
    <g:javascript>
        jQuery.validator.addMethod("image", function(val, element) {
            var ext = $('#image').val().split('.').pop().toLowerCase();
            var allow = new Array('gif','png','jpg','jpeg');
            return jQuery.inArray(ext, allow) != -1
        },  "Must upload image with extension .png, .jpg, .jpeg, or .gif.");

        $("form").validate({
            submitHandler : function(form){
                $("#submitButton").attr('disabled','disabled');
                form.submit();
            }
        });
    </g:javascript>
</html>