<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>

    <div>${design.title}</div>
    <div>${design.description}</div>

    <g:each in="${design.comments}" var="comment">
        <div>${comment.user.username}</div> <br />
        <div>${comment.text}</div> <br />
    </g:each>

    <g:form>
        <g:textArea name="commentText" rows="5" cols="50" /> <br />
        <g:submitButton name="submit" value="submit" />
    </g:form>
</html>