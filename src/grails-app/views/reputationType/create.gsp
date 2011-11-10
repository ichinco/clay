

<%@ page import="com.clay.ReputationType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'reputationType.label', default: 'ReputationType')}" />
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
            <g:hasErrors bean="${reputationTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${reputationTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reputationAmount"><g:message code="reputationType.reputationAmount.label" default="Reputation Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reputationTypeInstance, field: 'reputationAmount', 'errors')}">
                                    <g:textField name="reputationAmount" value="${fieldValue(bean: reputationTypeInstance, field: 'reputationAmount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="reputationType.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reputationTypeInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${reputationTypeInstance?.type}" />
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
