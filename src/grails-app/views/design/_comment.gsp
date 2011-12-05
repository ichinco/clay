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
            <div class="commentVote">
                <g:render template="vote" model="[upvoteAction:'upvoteComment', downvoteAction:'downvoteComment', actionparams:[commentId:currentComment.id]]" />
            </div>
            <div class="commentHeader">
                <div class="inline user">${currentComment.user.username}</div>
                <div class="commentDate">
                    <g:formatDate date="${currentComment.lastUpdated}" format="MM/dd/yyyy hh:mma" />
                </div>
            </div>
        <div class="commentText">
            ${currentComment.text}
        </div>

    </g:if>


<g:form class="comment" controller="design" action="comment" method="POST">
    <g:hiddenField name="designId" value="${designId}" />
    <g:hiddenField name="parentId" value="${currentComment ? currentComment.id : 0}" />
    <g:textArea name="commentText" rows="5" cols="50" /> <br />
    <g:submitButton class="submitButton" name="submitButton" value="submit" />
</g:form>

<g:each in="${comments}" var="comment">
    <g:if test="${comment.parent == currentComment}">
        <div class="comment-child">
            <g:render template="comment" model="[currentComment:comment, comments:comments, designId:designId]" />
        </div>
    </g:if>
</g:each>

</html>