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
    <g:javascript library="jquery" plugin="jquery"/>
    <jq:plugin name="form" />
    <script type="text/javascript">
        $(function() {
          $('#fileUploadForm').ajaxForm({
            beforeSubmit: ShowRequest,
            success: SubmitSuccesful,
            error: AjaxError
          });
        });

        function ShowRequest(formData, jqForm, options) {
          var queryString = $.param(formData);
          alert('BeforeSend method: \n\nAbout to submit: \n\n' + queryString);
          return true;
        }

        function AjaxError() {
          alert("An AJAX error occured.");
        }

        function SubmitSuccesful(responseText, statusText) {
          alert("SuccesMethod:\n\n" + responseText);
        }
    </script>
</head>
<body>
    <form id="fileUploadForm" method="POST" action="Default.aspx" enctype="multipart/form-data">
      <input type="text" name="filename" />
      <input type="file" id="postedFile" name="postedFile" />
      <input type="submit" value="Submit" />
    </form>
</body>

    %{--<head>--}%
        %{--<meta name="layout" content="clay" />--}%
    %{--</head>--}%

    %{--<label for="title">title:</label>--}%
    %{--<g:textField name="title" /><br />--}%
    %{--<label for="description">description</label>--}%
    %{--<g:textArea name="description" rows="3" cols="50" /><br />--}%

    %{--<ul id="uploadedImages"></ul>--}%

    %{--<g:form id="up" action="upload" method="post" enctype="multipart/form-data" encoding="multipart/form-data">--}%
        %{--<g:hiddenField name="designId" value="${design.id}" />--}%
        %{--<input id="image" type="file" name="image" /><br />--}%
        %{--<g:submitButton name="submitButton" value="submit" />--}%
    %{--</g:form>--}%

    %{--<g:submitButton id="submitButton" name="submitButton" value="submit" />--}%
    %{--<g:javascript library="jquery" plugin="jquery"/>--}%
    %{--<jq:plugin name="validate" />--}%
    %{--<jq:plugin name="form" />--}%
%{----}%
%{--<g:javascript>--}%
    %{--$(document).ready(function() {--}%
        %{--$("#up").ajaxForm();--}%
    %{--});--}%
%{--</g:javascript>--}%
</html>