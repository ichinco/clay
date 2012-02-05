<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:17 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay"/>
    </head>
    <body>

        <div class="designWrapper">
            <g:render template="designList" model="[designs:designs]" />
        </div>

        <g:javascript>
            $(document).scroll(function(){
                if($(this).scrollTop()>=($(this).height()*.5) && $("#nextChunk")){
                    $("#nextChunk").ajaxSubmit({
                        success: function(responseText, statusText, xhr, $form){
                            $(".designWrapper").append(responseText);
                        },
                        beforeSubmit: function(formData, jqForm, options){
                            $("#nextChunk").remove();
                        }
                    });
                }
            });
        </g:javascript>
    </body>
</html>