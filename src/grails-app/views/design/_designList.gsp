<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 2/4/12
  Time: 5:34 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<g:each in="${designs}" var="design" status="i">
    <g:render template="/design/design" model="[design:design]" />
</g:each>

<g:form name="nextChunk" class="nextChunk" action="nextListChunk" controller="design">
    <g:hiddenField name="listName" value="${listName}" />
    <g:hiddenField name="listIndex" value="${listIndex}" />
    <g:hiddenField name="listCount" value="${listCount}" />
</g:form>