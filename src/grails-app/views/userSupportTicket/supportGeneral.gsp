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
      <label for="name">name </label>
      <g:textField name="name"/> <br />
      <label for="email">email</label>
      <g:textField name="email"/> <br />
      <g:textArea name="text" /> <br />
      <g:submitButton name="submitButton" value="submit" />
  </g:form>

<jq:plugin name="validate"/>
<g:javascript>
  $("form").validate({
      rules : {
          text : "required",
          email: "required"
      },
      message : {
          text : "must enter question or suggestion",
          email : "must enter a email address so that we can reply."
      },
      submitHandler : function(form) {
          $("#submitButton").attr('disabled','disabled');
          form.submit();
      }
  });
</g:javascript>

</html>