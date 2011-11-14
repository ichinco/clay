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
    <g:form id="userCreate" controller="user" action="create">
        <label for="username">email</label>
        <g:textField id="username" name="username" class="required" />  <br />
        <label for="password">password</label>
        <g:passwordField id="password" name="password" class="required" /> <br />
        <label for="retype">retype password</label>
        <g:passwordField id="retype" name="retype" class="required" /> <br />
        <g:submitButton name="submit" value="submit" />
    </g:form>

    <jq:plugin name="validate" />
    <g:javascript>
        $("form").validate({
            rules : {
                password : "required",
                username : "required",
                retype : { equalTo: "#password"}
            },
            messages : {
                password : "Must enter password.",
                username : "Must enter username.",
                retype : "Passwords do not match."
            },
            errorClass : "invalid",
            invalidHandler : function(e, validator) {
			    var errors = validator.numberOfInvalids();
                if (errors) {
                    var message = errors == 1
                        ? 'You missed 1 field. It has been highlighted below'
                        : 'You missed ' + errors + ' fields.  They have been highlighted below';
                    $("#userCreateFailed").html(message);
                    $("#userCreateFailed").show();
                } else {
                    $("#userCreateFailed").hide();
                }
            }
        });
    </g:javascript>
</html>