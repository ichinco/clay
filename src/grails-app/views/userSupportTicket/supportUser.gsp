<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/18/11
  Time: 7:59 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
      <meta name="layout" content="clay" />
  </head>

  <g:form controller="userSupportTicket" action="saveGeneral">
      <div>A response will be sent to ${email}.</div><br />
      <g:textArea name="text" cols="100" rows="5" /> <br />
      <g:submitButton name="submitButton" value="submit" />
  </g:form>

  <jq:plugin name="validate"/>
  <g:javascript>
    $("form").validate({
        rules : {
            text : "required"
        },
        message : {
            text : "must enter question or suggestion"
        },
        submitHandler : function(form) {
            $("#submitButton").attr('disabled','disabled');
            form.submit();
        }
    });
  </g:javascript>
</html>