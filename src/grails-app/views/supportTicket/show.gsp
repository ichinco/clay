
<%@ page import="com.clay.SupportTicket" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'supportTicket.label', default: 'SupportTicket')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supportTicketInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supportTicketInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supportTicketInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.text.label" default="Text" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supportTicketInstance, field: "text")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.ticketStatus.label" default="Ticket Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supportTicketInstance, field: "ticketStatus")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.ticketType.label" default="Ticket Type" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: supportTicketInstance, field: "ticketType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="supportTicket.user.label" default="User" /></td>
                            
                            <td valign="top" class="value"><g:link controller="clayUser" action="show" id="${supportTicketInstance?.user?.id}">${supportTicketInstance?.user?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${supportTicketInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
