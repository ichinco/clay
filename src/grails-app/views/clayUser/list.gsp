
<%@ page import="com.clay.ClayUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'clayUser.label', default: 'ClayUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'clayUser.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'clayUser.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="password" title="${message(code: 'clayUser.password.label', default: 'Password')}" />
                        
                            <g:sortableColumn property="accountExpired" title="${message(code: 'clayUser.accountExpired.label', default: 'Account Expired')}" />
                        
                            <g:sortableColumn property="accountLocked" title="${message(code: 'clayUser.accountLocked.label', default: 'Account Locked')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'clayUser.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${clayUserInstanceList}" status="i" var="clayUserInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${clayUserInstance.id}">${fieldValue(bean: clayUserInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: clayUserInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: clayUserInstance, field: "password")}</td>
                        
                            <td><g:formatBoolean boolean="${clayUserInstance.accountExpired}" /></td>
                        
                            <td><g:formatBoolean boolean="${clayUserInstance.accountLocked}" /></td>
                        
                            <td><g:formatDate date="${clayUserInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${clayUserInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
