

<%@ page import="com.clay.SupportTicket" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supportTicket.label', default: 'SupportTicket')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${supportTicketInstance}">
            <div class="errors">
                <g:renderErrors bean="${supportTicketInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="supportTicket.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supportTicketInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${supportTicketInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="supportTicket.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supportTicketInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${supportTicketInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="text"><g:message code="supportTicket.text.label" default="Text" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supportTicketInstance, field: 'text', 'errors')}">
                                    <g:textField name="text" value="${supportTicketInstance?.text}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ticketStatus"><g:message code="supportTicket.ticketStatus.label" default="Ticket Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supportTicketInstance, field: 'ticketStatus', 'errors')}">
                                    <g:textField name="ticketStatus" value="${supportTicketInstance?.ticketStatus}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ticketType"><g:message code="supportTicket.ticketType.label" default="Ticket Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supportTicketInstance, field: 'ticketType', 'errors')}">
                                    <g:textField name="ticketType" value="${supportTicketInstance?.ticketType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="supportTicket.user.label" default="User" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: supportTicketInstance, field: 'user', 'errors')}">
                                    <g:select name="user.id" from="${com.clay.ClayUser.list()}" optionKey="id" value="${supportTicketInstance?.user?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
