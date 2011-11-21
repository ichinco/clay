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
        <div>
            <g:link controller="vote" action="upvoteComment" params="[commentId:currentComment.id]">up</g:link>
            <g:link controller="vote" action="downvoteComment" params="[commentId:currentComment.id]">down</g:link>
        </div>
        <div>${currentComment.user.username}</div>
        <div>${currentComment.text}</div>
        <div>${currentComment.lastUpdated}</div>
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

    <jq:plugin name="validate" />
    <g:javascript>
        $(".comment").validate({
            rules : {
                commentText : {
                    required : true,
                    minlength : 20,
                    maxlength : 500
                }
            },
            messages : {
                commentText : "Comment must be at least 20 characters."
            },
            submitHandler : function(form) {
                $(form).children(".submitButton").attr('disabled','disabled');
                form.submit();
            }
        });
    </g:javascript>

</html>