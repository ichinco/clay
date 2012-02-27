<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/13/11
  Time: 6:25 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Humble Abode" /></title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <g:javascript library="application" />
        <g:javascript library="jquery" plugin="jquery"/>
        <jq:plugin name="validate" />
        <jq:plugin name="form" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300' rel='stylesheet' type='text/css' />
        <link href="${resource(dir:'css', file:'clay.css')}" rel="stylesheet" type="text/css" />
        <g:layoutHead />
    </head>
    <body>
    <div class="header">
        <div class="headerAction container">
            <g:link class="action" controller="search" action="tag" params="[tag:'bath']">bath</g:link>
            <g:link class="action" controller="search" action="tag" params="[tag:'bedroom']">bedroom</g:link>
            <g:link class="action" controller="search" action="tag" params="[tag:'dining room']">dining room</g:link>
        </div>

        <div class="signin">
            <g:if test="${request.signedIn}">
                <g:link controller="user" action="designList">${request.username}</g:link> |
                <g:link controller="user" action="settings">settings</g:link> |
                <g:link controller="logout">logout</g:link>
            </g:if>
            <g:else >
                <facebookAuth:connect permissions="email,user_birthday" />
                <g:link controller="login" action="create.gsp">register</g:link> |
                <g:link controller="design" action="signedInList">log in</g:link>
            </g:else>
        </div>
    </div>

    <div id="status"></div>
    <div class="content">
            <div class="main">
                <g:layoutBody />
            </div>
            <div class="about">
                <div class="aboutLinks">
                    <g:link class="action" controller="userSupportTicket" action="create">feedback</g:link>
                    <g:link class="action" controller="userSupportTicket" action="about">about</g:link>
                    <g:link class="action" controller="userSupportTicket" action="privacy">privacy</g:link>
                </div>
            </div>
    </div>

    <div class="footer">
            <div class="footerAction container">
                <g:link class="action" controller="design" action="create">create</g:link>
            </div>
            <g:link class="homeLink" controller="design" action="list">clay onion</g:link>
        </div>
    </body>
</html>