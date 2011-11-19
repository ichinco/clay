<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/18/11
  Time: 10:56 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta name="layout" content="clay" />
  </head>

  <g:form id="settingsForm" controller="user" action="saveSettings">
      <label for="email">change email address</label>
      <g:textField name="email" value="${email}" /><br />
      <g:submitButton id="submitButtonSettings" name="submitButton" value="submit" />
  </g:form>

  <g:form id="passwordForm" controller="user" action="savePassword">
      <label for="password">password</label>
      <g:passwordField id="passwordField" name="password" /><br />
      <label for="retype">retype password</label>
      <g:passwordField name="retype" /><br/>
      <g:submitButton id="submitButtonPassword" name="submitButton" value="submit" />
  </g:form>

  <jq:plugin name="validate" />
  <g:javascript>
    $("#settingsForm").validate({
        rules : {
            email:"required"
        },
        messages : {
            email:"must enter email."
        },
        submitHandler : function(form) {
            $("#submitButtonSettings").attr('disabled','disabled');
            form.submit();
        }
    });
    $("passwordForm").validate({
        rules : {
            password : "required",
            retype : { equalTo: "#passwordField" }
        },
        messages : {
            password : "must enter password",
            retype : "passwords must match."
        },
        submitHandler : function(form) {
            $("#submitButtonPassword").attr('disabled','disabled');
            form.submit();
        }
    });
  </g:javascript>
</html>