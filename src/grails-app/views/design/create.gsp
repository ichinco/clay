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
            max-width : 200px;
            height: auto;
        }

        img.thumb
        {
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


        /**/
        </style>
        <!--[if lt IE 8]>
    <style>
        .wraptocenter span {
            display: inline-block;
            height: 100%;
        }
    </style><![endif]-->
        <script src="${resource(dir:'js', file:'wireframe.js')}" type="text/javascript"></script>
        <script src="${resource(dir:'js', file:'viewpoints.js')}" type="text/javascript"></script>
        <link rel="stylesheet" href="${resource(dir:'css', file:'viewpoints.css')}" />
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
	    Currently you have not tagged any items. <br />
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
         <span class="label">name</span><input id="pointName" value="name" /><br />
	 <span class="label">link</span><input id="pointLink" value="link" />
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