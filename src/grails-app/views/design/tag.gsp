<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 3/25/12
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="clay"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400' rel='stylesheet' type='text/css'/>
    <style type="text/css">
    /**/
    </style>
    <!--[if lt IE 8]>
    <style>
        .wraptocenter span {
            display: inline-block;
            height: 100%;
        }
    </style><![endif]-->
    <script src="${resource(dir: 'js', file: 'wireframe.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js', file: 'viewpoints2.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js', file: 'viewpoints.js')}" type="text/javascript"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'viewpoints.css')}"/>
</head>
<body>
<div id="imageGalleryContainer">
    <div id="imageGalleryCommands">
        <div class="closeButton">help</div>
    &sdot;
        <div class="closeButton">quicksave</div>
    &sdot;
        <div class="closeButton">close</div>
    </div>
    <div class="screen"></div>
    <div id="imageGallery" class="shadow">
        <div id="featureDisabledMessage">
            <div>
                Oh Bummer!
            </div>
            <p>
                This feature is not supported by the browser's javascript settings.
                We are working to enable feature support for all users, and we are
                deeply sorry for this incovenience. For more information, please
                <a>click here</a>.</p>
        </div>
        <div id="pointDetailListContainer">
            <ul id="pointDetailList">
                Currently you have not tagged any items. <br/>
            </ul>
            <a class="addPointButton">Add an item.</a>
        </div>
        <div id="imageContainer">
            <div class="filler">
                no image selected...
            </div>
            <span></span>
            <img id="fullImage" src="">
            <button class="addPointButton">
                <div>
                    <img src="http://cdn5.iconfinder.com/data/icons/TWG_Retina_Icons/64/tag_add.png">
                    add an item
                </div>
            </button>
            <div class="status">
                tagging...<button id="cancelAddPointButton">(cancel)</button>
            </div>
            <div class="screen"></div>
            <div class="wireFrameCanvas"></div>
        </div>
        <div id="imageSelectionBar">
            <button id="scrollImageSelectionLeft" class="disabled">
                <img src='http://evilwire.net/images/leftrighticons.png'>
            </button>
            <button id="scrollImageSelectionRight" class="disabled">
                <img src='http://evilwire.net/images/leftrighticons.png'>
            </button>
            <div id="imageThumbContainer">
                <div id="thumbTemplate" class="imageThumb">
                    <img src="">
                </div>
            </div>
            <div id="imageSelectionBarScreen">
            </div>
        </div>
        <div id="pointInfoInputBlock">
            <span class="label">name</span><input id="pointName" value="name"/><br/>
            <span class="label">link</span><input id="pointLink" value="link"/>
            <button class="cancel">
                <img src="http://math.rutgers.edu/~knightfu/images/icons.png">
            </button>
            <button class="submit">
                <img src="http://math.rutgers.edu/~knightfu/images/icons.png">
            </button>
        </div>
    </div>
    <div class="spaceFiller"></div>
</div>

<g:javascript>
    var imageList = ${images};
</g:javascript>

</body>
</html>
