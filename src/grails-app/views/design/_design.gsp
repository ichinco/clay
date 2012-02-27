<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 12/3/11
  Time: 4:46 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <div class="designThumb">
        <div class="designText">
            <g:link controller="design" action="show" params="[id:design.id]">
                <div class="inline title">${design.title}</div>
            </g:link>
            by
            <g:link controller="search" action="userById" params="[userId:design.user.id]">
                <div class="inline user">${design.user.username}</div>
            </g:link>
        </div>
        <div>
            <g:link controller="design" action="show" params="[id:design.id]">
                <div class="designFrame">
                    <img class="designImage" src="${design.images.url[0]}" />
                </div>
                <img class="designShadow" src="http://assets.tumblr.com/images/theme_gallery_shadow.png?2" />
            </g:link>
        </div>
    </div>
</html>