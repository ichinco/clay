<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>

    <div>${design.id}</div>
    <div>${design.title}</div>
    <div>${design.description}</div>

    <g:each in="${design.comments}" var="comment">
        <div>${comment.user.username}</div> <br />
        <div>${comment.text}</div> <br />
        <g:form controller="design" action="comment">
            <g:hiddenField name="designId" value="${design.id}" />
            <g:hiddenField name="parentId" value="${comment.id}" />
            <g:textArea name="commentText" rows="5" cols="50" /> <br />
            <g:submitButton name="submit" value="submit" />
        </g:form>
    </g:each>

    <g:form controller="design" action="comment">
        <g:hiddenField name="designId" value="${design.id}" />
        <g:hiddenField name="parentId" value="0" />
        <g:textArea name="commentText" rows="5" cols="50" /> <br />
        <g:submitButton name="submit" value="submit" />
    </g:form>
</html>