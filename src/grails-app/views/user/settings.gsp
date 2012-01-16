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

<body>

    <g:form name="settingsForm" controller="user" action="saveSettings">
        <label class="formLabel" for="email">change email address</label>
        <g:textField class="formInput" name="email" value="${email}" /><br />
        <label class="formLabel" for="submitButtonSettings"></label>
        <g:submitButton id="submitButtonSettings" name="submitButton" value="submit" />
    </g:form>

    <g:form name="passwordForm" controller="user" action="savePassword">
        <label class="formLabel" for="oldPassword">old password</label>
        <g:passwordField class="formInput" name="oldPassword" /><br />
        <label class="formLabel" for="newPassword">new password</label>
        <g:passwordField class="formInput" name="newPassword" /><br />
        <label class="formLabel" for="retype">retype password</label>
        <g:passwordField class="formInput" name="retype" id="retype" /><br/>
        <label class="formLabel" for="submitButtonPassword"></label>
        <g:submitButton id="submitButtonPassword" name="submitButton" value="submit" />
    </g:form>
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
                $(form).ajaxSubmit({
                    success : function(responseText, statusText, xhr, $form) {
                        $("#status").html("email address successfully updated.");
                        $("#submitButtonSettings").removeAttr('disabled');
                    }
                });
            }
        });
        $("#passwordForm").validate({
            rules : {
                oldPassword : {required: true},
                newPassword : {required: true},
                retype : { equalTo: "#NewPassword" }
            },
            messages : {
                oldPassword : "must enter current password",
                newPassword : "must enter desired new password",
                retype : "must match new password."
            },
            submitHandler : function(form) {
                $("#submitButtonPassword").attr('disabled','disabled');
                $(form).ajaxSubmit({
                    success : function(responseText, statusText, xhr, $form) {
                        $("#status").html("password successfully updated");
                        $("#submitButtonPassword").removeAttr('disabled');
                    }
                });
            }
        });
    </g:javascript>
</body>

</html>