<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 12/4/11
  Time: 1:17 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <g:link controller="vote" action="${upvoteAction}" params="${actionparams}">
        <img class="voteBn" src="${resource(dir:'images/comments',file:'up.png')}">
    </g:link>
    <g:link controller="vote" action="${downvoteAction}" params="${actionparams}">
        <img class="voteBn" src="${resource(dir:'images/comments',file:'down.png')}">
    </g:link>
</html>