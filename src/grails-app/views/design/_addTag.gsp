<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 1/16/12
  Time: 11:39 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>

    <div id="categoryTags">
        <div id="categoryTagTemplate" class="smallTag"></div>
        <g:each in="${tags}" var="tag">
            <div class="smallTag">${tag.name}</div>
        </g:each>
    </div>

    <g:if test="${allowTag}">
        <g:form name="categoryTag" controller="design" action="tagDesign">
            <g:hiddenField name="designId" value="${designId}"/>
            <g:hiddenField name="tagTypeId" value="1"/>
            <label for="tagName">tag</label>
            <g:textField name="tagName"/>
            <g:submitButton name="submitCategoryTag" value="submit"/>
        </g:form>
    </g:if>

<g:javascript >
    $("#categoryTag").ajaxForm({
            success : function (responseText, statusText, xhr, $form) {

                var tagUL = $("#categoryTagTemplate").clone();

                tagUL.html(responseText.name);

                // insert the insertUL into the target
                $('#categoryTags').append(tagUL);
            }
    });
</g:javascript>
</html>