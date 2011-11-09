<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/9/11
  Time: 7:28 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>

    <g:if test="${currentComment}">
        <div>${currentComment.user.username}</div> <br />
        <div>${currentComment.text}</div> <br />
    </g:if>

    <g:form controller="design" action="comment">
        <g:hiddenField name="designId" value="${designId}" />
        <g:hiddenField name="parentId" value="${currentComment ? currentComment.id : 0}" />
        <g:textArea name="commentText" rows="5" cols="50" /> <br />
        <g:submitButton name="submit" value="submit" />
    </g:form>

    <g:each in="${comments}" var="comment">
        <g:if test="${comment.parent == currentComment}">
            <div class="comment-child">
                <g:render template="comment" model="[currentComment:comment, comments:comments, designId:designId]" />
            </div>
        </g:if>
    </g:each>

</html>