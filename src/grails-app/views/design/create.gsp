<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/8/11
  Time: 10:01 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta name="layout" content="clay" />
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400' rel='stylesheet' type='text/css'/>
        <link rel="stylesheet" href="${resource(dir:'css', file:'tag-image-control.css')}" />


        <style type="text/css">
            img.thumb {
                max-width: 200px;
                height: auto;
            }

            img.thumb {
                width: auto;
                max-height: 150px;
                position: relative;
                top: 2px;
            }

            .thumbContainer {
                display: table-cell;
                text-align: center;
                vertical-align: middle;

                width: 200px;
                height: 150px;
                background-color: #ccc;
            }
        </style>
    </head>
<body>
    <h1>create design>></h1>

    <g:form name="metaDesign" action="save" method="post">
        <g:hiddenField name="designId" value="${design.id}" />
        <label class="formLabel" for="title">title:</label>
        <g:textField class="formInput" name="title" value="${design.title}" /><br />
        <label class="formLabel" for="description">description:</label>
        <g:textArea class="formTextArea" name="description" value="${design.description}" rows="3" cols="50" /><br />
    </g:form>


    <g:form name="up" action="upload" method="post" enctype="multipart/form-data" encoding="multipart/form-data">
        <g:hiddenField name="designId" value="${design.id}" />
        <label class="formLabel" for="title">image file:</label><input id="image" type="file" name="image" />
        <button id="fileDialog" style="">choose file</button>
        <g:submitButton name="submitButton" value="submit" />
    </g:form>

    <div class="formLabel"></div>
    <g:render template="addTag" model="[designId:design.id, tags:design.tags, allowTag:true]" />

    <div class="formLabel"></div>
    <ul id="uploadedImages"></ul>

    <div class="formLabel"></div>
    <g:render template="addImagePoint" model="[images:images]" />

    <div class="formLabel"></div>
    <g:submitButton name="saveDesign" value="save" />

    <ul id='imageThumbTemplate'>
        <div class="thumbContainer">
            <span></span>
            <img class="thumb" />
        </div>
        <button class="tag">tag</button>
        <button>remove</button>
    </ul>

<g:javascript>
    var numOfImages = 0;
    var publicImageCollectionArray = [];

    var createImageWithSrc = function(src){
        var insertUL = $('#imageThumbTemplate').clone();

        // change the url for the insert
        insertUL.children("div").children("img").attr('src', src);
        insertUL.css("display", "block");
        insertUL.children("button.tag").click(function(evt){
            $('div.imageMain').css('visibility', 'visible');
        });

        // insert the insertUL into the target
        $('#uploadedImages').append(insertUL);
    };

    $(document).ready(function() {
        var urls = ${images};

        $.each(urls, function(i, url){
            publicImageCollectionArray.push(url);
            createImageWithSrc(url.url)
        });

        $('#up').ajaxForm({
            success : function (responseText, statusText, xhr, $form) {
                publicImageCollectionArray.push(responseText);
                createImageWithSrc(responseText.url)
            }
        });

        TagFrames(publicImageCollectionArray);
    });

    $("#saveDesign").click(function(){
        $("#metaDesign").submit();
    });
</g:javascript>
</body>
</html>