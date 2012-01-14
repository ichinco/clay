<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:28 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay" />
    </head>
    <div id="userCreateFailed"></div>
    <g:form id="userCreate" controller="user" action="create" method="POST">
        <label class="formLabel" for="username">username</label>
        <g:textField id="username" name="username" class="required formInput" />  <br />
        <label class="formLabel" for="email">email</label>
        <g:textField name="email" id="email" class="formInput"/> <br />
        <label class="formLabel" for="birthday">birthday</label>
        <g:textField name="birthday" id="birthday" class="formInput" /><br />
        <label class="formLabel" for="password">password</label>
        <g:passwordField id="password" name="password" class="required formInput" /> <br />
        <label class="formLabel" for="retype">retype password</label>
        <g:passwordField id="retype" name="retype" class="required formInput" /> <br />
        %{--//TODO require captcha--}%
        <g:submitButton id="submitButton" name="submitButton" value="submit" />
    </g:form>

    <jq:plugin name="validate" />
    <g:javascript>
        $("form").validate({
            rules : {
                password : "required",
                username : "required",//TODO check for uniqueness
                retype : { equalTo: "#password"},
                email : "required"// TODO that is mostly an email address
//                birthday : "" // TODO check for > 13
            },
            messages : {
                password : "Must enter password.",
                username : "Must enter username.",
                retype : "Passwords do not match.",
                birthday : "Must be older than 13",
                email : "Must enter email. We won't misuse it."
            },
            errorClass : "invalid",
            invalidHandler : function(e, validator) {
			    var errors = validator.numberOfInvalids();
                if (errors) {
                    var message = "Errors have been highlighted below.";
                    $("#userCreateFailed").html(message);
                    $("#userCreateFailed").show();
                } else {
                    $("#userCreateFailed").hide();
                }
            },
            submitHandler : function(form) {
                $("#submitButton").attr('disabled','disabled');
                form.submit();
            }
        });
    </g:javascript>
</html>