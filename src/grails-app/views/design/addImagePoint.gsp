<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 11/15/11
  Time: 9:22 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
            type="text/javascript"></script>

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400' rel='stylesheet' type='text/css'/>
    <style type="text/css">
    .tic {
        font-family: 'Open Sans', sans-serif;
        font-size: 14px;
    }

    .user {
        display: inline;
        color: #006699;
    }

    .ticImgSel {
        position: absolute;
        border: #bbeeff 2px solid;
        visibility: hidden;
    }

    .ticTagger {
        position: absolute;
    }

    img {
        width: 600px;
    }

    .ticTagCont {
        position: absolute;
        left: 624px;

    }

    .ticTagItem {
        margin-top: 1px;
        padding: 2px 15px 2px 15px;
        background-color: #bbb;
        width: 120px;
    }

    .ticImgBar {
        position: absolute;
        top: 430px;
    }

    .ticImgBn {
        position: relative;
        overflow: hidden;

        width: 10px;
        height: 10px;
        background-color: #456;
        border: #123 solid 1px;

        display: inline-block;
        margin-right: 15px;
        margin-top: 5px;
        cursor: pointer;
    }

    .ticSelImgBn {
        background-color: #9ae;
        border-color: #456;
    }

    .tagCntrl {
        position: absolute;
        top: 500px;
    }

    #jsonout {
        margin-top: 30px;
        width: 800px;
    }

    .ticBn {
        font-family: 'Open Sans', sans-serif;
        font-size: 12px;
        color: #069;
        cursor: pointer;
        margin-right: 15px;

        display: inline;
    }

    .folded {
        display: none;
    }

    .ticAddTagItemCont {
    }

    .ticTagBox {
        border: #99eeff solid 1px;
        position: absolute;
    }

    .ticDisabled {
        color: #aaa;
    }

    #addTag {
        border: #99eeff solid 1px;
        position: absolute;
    }

    </style>
</head>
<body>
<div class="ticCont">
    <div class="tic ticTitleBar"></div>
    <div class="tic ticDisplay">
        <div class="tic ticMainImg"></div>
    </div>
    <div class="tic ticImgBar"></div>
    <div class="tic ticTagCont"></div>
    <div id="addTag">add tags</div>
</div>
<div class="tagCntrl">
    <g:form controller="design" action="addImagePoint">
        <g:hiddenField name="imageId" value="${imageId}"/>
        <g:hiddenField name="x" id="x"/>
        <g:hiddenField name="y" id="y"/>
        <g:hiddenField name="width" id="width"/>
        <g:hiddenField name="height" id="height"/>
        <div class="label">caption:</div>
        <g:textField name="productUrl"/>
        <div class="label">name</div>
        <g:textField name="productName" id='inputName'/>
        <div id=addItemBn class="ticBn ticDisabled">add</div>
        <div id=clearBn class="ticBn">clear</div>
        <div id='jsonout'></div>
    </g:form>
</div>
</body>

<script src="${resource(dir: 'js', file: 'imgtag_s.js')}" type="text/javascript"></script>
<script src="${resource(dir: 'js', file: 'imgtag_w.js')}" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {
        var picArr =
                [
                    "http://homeroomideas.com/wp-content/decorating/2011/08/Family_living_room_decorating_ideas.jpg",
                    "http://kurniacyber.com/wp-content/uploads/2011/08/small-living-room-remodel-3.jpg"
                ];

        TagFrames(picArr);
    });
</script>
</html>