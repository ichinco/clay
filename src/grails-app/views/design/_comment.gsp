<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/9/11
  Time: 7:28 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

    <g:if test="${currentComment}">
        <g:render template="currentComment" model="[currentComment:currentComment]" />
    </g:if>



<g:each in="${comments}" var="comment">
    <g:if test="${comment.parent == currentComment}">
        <div class="comment-child">
            <g:render template="comment" model="[currentComment:comment, comments:comments, designId:designId]" />
        </div>
    </g:if>
</g:each>