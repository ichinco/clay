
<%@ page import="com.clay.ReputationType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'reputationType.label', default: 'ReputationType')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'reputationType.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'reputationType.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'reputationType.lastUpdated.label', default: 'Last Updated')}" />
                        
                            <g:sortableColumn property="reputationAmount" title="${message(code: 'reputationType.reputationAmount.label', default: 'Reputation Amount')}" />
                        
                            <g:sortableColumn property="type" title="${message(code: 'reputationType.type.label', default: 'Type')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${reputationTypeInstanceList}" status="i" var="reputationTypeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${reputationTypeInstance.id}">${fieldValue(bean: reputationTypeInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${reputationTypeInstance.dateCreated}" /></td>
                        
                            <td><g:formatDate date="${reputationTypeInstance.lastUpdated}" /></td>
                        
                            <td>${fieldValue(bean: reputationTypeInstance, field: "reputationAmount")}</td>
                        
                            <td>${fieldValue(bean: reputationTypeInstance, field: "type")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${reputationTypeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
