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
        <style type="text/css">
            img.thumb {
               max-width : 200px;
               height: auto;
            }

            img.thumb
            {
                width: auto;
                max-height: 150px;
                position: relative;
                top: 2px;
            }

            .thumbContainer {
                display: table-cell;
                text-align: center;
                vertical-align: middle;

                width: 200px;
                height: 150px;
                background-color: #ccc;
            }
/**/
</style>
<!--[if lt IE 8]>
    <style>
        .wraptocenter span {
            display: inline-block;
            height: 100%;
        }
    </style><![endif]-->
    </head>
<body>
    <h1>create design>></h1>

    <label class="formLabel" for="title">title:</label>
    <g:textField class="formInput" name="title" /><br />
    <label class="formLabel" for="description">description:</label>
    <g:textArea class="formTextArea" name="description" rows="3" cols="50" /><br />

    <ul id="uploadedImages"></ul>

    <g:form name="up" action="upload" method="post" enctype="multipart/form-data" encoding="multipart/form-data">
        <g:hiddenField name="designId" value="${design.id}" />
        <label class="formLabel" for="title">image file:</label><input id="image" type="file" name="image" />
        <button id="fileDialog" style="">choose file</button>
        <g:submitButton name="submitButton" value="submit" />
    </g:form>

    <g:submitButton id="submitButton" name="submitButton" value="submit" />

    <jq:plugin name="form" />

<g:javascript>
    $(document).ready(function() {
        $('#up').ajaxForm({
            success : function (responseText, statusText, xhr, $form) {
                var listElement = $(responseText);
                $("#uploadedImages").append(listElement);
            }
        });
    });
</g:javascript>
</body>
</html>