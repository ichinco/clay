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

    <div class="designShow">
        <div class="tagViewer">
            <img src="http://cdn.slashgear.com/wp-content/uploads/2009/07/holger_schubert_maserati_living_room_garage_1-540x400.jpg" />
        </div>

        <div style="float: left;">
        <g:render template="vote" model="[upvoteAction:'upvoteDesign',downvoteAction:'downvoteDesign', actionparams:[designId:design.id]]" />
        </div>
        <div>${design.title} by <div class="user inline">${design.user.username}</div></div>
        <div>${design.description}</div>

        <g:each in="${design.tags}" var="tag">
            <div class="smallTag">${tag.name}</div>
        </g:each>

        <g:form controller="design" action="tagDesign">
            <g:hiddenField name="designId" value="${design.id}" />
            <g:hiddenField name="tagTypeId" value="1" />
            <label for="tagName">tag</label>
            <g:textField name="tagName" />
            <g:submitButton name="submit" value="submit" />
        </g:form>

        <g:render template="comment" model="[currentComment:null, comments:design.comments, designId:design.id]" />
    </div>


</html>