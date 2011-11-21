<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.clay.Comment" contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay" />
    </head>
    <div>
        <g:link controller="vote" action="upvoteDesign" params="[designId:design.id]">up</g:link>
        <g:link controller="vote" action="downvoteDesign" params="[designId:design.id]">down</g:link>
    </div>
    <div>${design.id}</div>
    <div>${design.title}</div>
    <div>${design.description}</div>

    <g:render template="comment" model="[currentComment:null, comments:design.comments, designId:design.id]" />

    <g:each in="${design.tags}" var="tag">
        <div>${tag.name}</div>
    </g:each>

    <g:form controller="design" action="tagDesign">
        <g:hiddenField name="designId" value="${design.id}" />
        <g:hiddenField name="tagTypeId" value="1" />
        <label for="tagName">tag</label>
        <g:textField name="tagName" />
        <g:submitButton name="submit" value="submit" />
    </g:form>
</html>