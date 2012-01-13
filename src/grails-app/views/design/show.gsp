<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="grails.converters.deep.JSON; com.clay.Comment" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="clay"/>
    <link rel="stylesheet" href="${resource(dir:'css', file:'tag-image-control.css')}" />
</head>
<body>

<div class="designShow">
    <g:render template="imageGallery" />

    <div style="float: left;">
        <g:render template="vote" model="[upvoteAction:'upvoteDesign',downvoteAction:'downvoteDesign', actionparams:[designId:design.id]]"/>
    </div>
    <div>${design.title} by <div class="user inline">${design.user.username}</div></div>
    <div>${design.description}</div>

    <g:each in="${design.tags}" var="tag">
        <div class="smallTag">${tag.name}</div>
    </g:each>

    <g:form controller="design" action="tagDesign">
        <g:hiddenField name="designId" value="${design.id}"/>
        <g:hiddenField name="tagTypeId" value="1"/>
        <label for="tagName">tag</label>
        <g:textField name="tagName"/>
        <g:submitButton name="submit" value="submit"/>
    </g:form>

    <g:render template="comment" model="[currentComment:null, comments:design.comments, designId:design.id]"/>
</div>

<div id="replyForm" style="display: none;">
    <g:form class="comment" controller="design" action="comment" method="POST">
        <g:hiddenField class="designId" name="designId" value=""/>
        <g:hiddenField class="parentId" name="parentId" value=""/>
        <g:textArea name="commentText" rows="5" cols="50"/> <br/>
        <g:submitButton class="submitButton" name="submitButton" value="submit"/>
    </g:form>
</div>

<script src="${resource(dir: 'js', file: 'imgtag_s.js')}" type="text/javascript"></script>
<script src="${resource(dir: 'js', file: 'imgtag_w.js')}" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {
        TagFrames(${images as JSON});
    });
</script>
</body>

</html>