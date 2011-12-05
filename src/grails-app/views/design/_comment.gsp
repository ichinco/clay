<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/9/11
  Time: 7:28 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

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
        <div class="commentActions">
            <a id="respond_${currentComment.id}" class="actionBn respond"
                onclick="(function(evt){
                    var target = $(evt.target ? evt.target : evt.srcElement);

                    if(target.html() == 'respond')
                    {
                        if(target.parent().children('form').length > 0)
                        {
                            target.parent().children('form').css('display', 'block');
                        }
                        else
                        {
                            var insertForm = $('#replyForm').children('form').clone();
                            target.before(insertForm);
                            insertForm.children('.designId').attr('value','${designId}');
                            insertForm.children('.parentId').attr('value',
                                '${currentComment ? currentComment.id : 0}');
                        }
                        target.html('hide');
                    }
                    else if(target.html() == 'hide')
                    {
                        target.parent().children('form').css('display', 'none');
                        target.html('respond');
                    }
                    else
                    {
                    }
                })(window.event);">respond</a>
            <a class="actionBn report" href="">report</a>
        </div>
    </g:if>



<g:each in="${comments}" var="comment">
    <g:if test="${comment.parent == currentComment}">
        <div class="comment-child">
            <g:render template="comment" model="[currentComment:comment, comments:comments, designId:designId]" />
        </div>
    </g:if>
</g:each>