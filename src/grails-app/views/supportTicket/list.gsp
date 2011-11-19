
<%@ page import="com.clay.SupportTicket" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supportTicket.label', default: 'SupportTicket')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'supportTicket.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="email" title="${message(code: 'supportTicket.email.label', default: 'Email')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'supportTicket.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="text" title="${message(code: 'supportTicket.text.label', default: 'Text')}" />
                        
                            <g:sortableColumn property="ticketStatus" title="${message(code: 'supportTicket.ticketStatus.label', default: 'Ticket Status')}" />
                        
                            <g:sortableColumn property="ticketType" title="${message(code: 'supportTicket.ticketType.label', default: 'Ticket Type')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${supportTicketInstanceList}" status="i" var="supportTicketInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${supportTicketInstance.id}">${fieldValue(bean: supportTicketInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: supportTicketInstance, field: "email")}</td>
                        
                            <td>${fieldValue(bean: supportTicketInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: supportTicketInstance, field: "text")}</td>
                        
                            <td>${fieldValue(bean: supportTicketInstance, field: "ticketStatus")}</td>
                        
                            <td>${fieldValue(bean: supportTicketInstance, field: "ticketType")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${supportTicketInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
