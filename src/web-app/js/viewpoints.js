/**
 * Created by IntelliJ IDEA.
 * User: denise
 * Date: 3/15/12
 * Time: 10:38 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(evt)
{
   $('#featureDisabledMessage').css("display", "none");

   var imageList =
   [
   {
      class: "com.clay.Image",
      dateCreated: "2012-01-27T15:57:44Z",
      design: null,
      id: 1,
      lastUpdated: "2012-01-27T15:57:44Z",
      points: [],
      url: "http://evilwire.net/images/livingroom 1.jpg"
   },
   {
      class: "com.clay.Image",
      dateCreated: "2012-01-27T15:57:44Z",
      design: null,
      id: 2,
      lastUpdated: "2012-01-27T15:57:44Z",
      points: [],
      url: "http://evilwire.net/images/livingroom 2.jpg"
   },
   {
      class: "com.clay.Image",
      dateCreated: "2012-01-27T15:57:44Z",
      design: {},
      id: 1,
      lastUpdated: "2012-01-27T15:57:44Z",
      points: [],
      url: "http://evilwire.net/images/livingroom 3.jpg"
   },
   {
      class: "com.clay.Image",
      dateCreated: "2012-01-27T15:57:44Z",
      design: null,
      id: 2,
      lastUpdated: "2012-01-27T15:57:44Z",
      points: [],
      url: "http://evilwire.net/images/livingroom 4.jpg"
   }
   ];

   var lastSelectedThumb = null;
   var lastSelectedIndex = -1;
   var lastTaggedArea = null;

   function selectImage(i)
   {
      if(lastSelectedIndex == i) return;

      var imageSrc = imageList[i]['url'];
      $('#fullImage').attr("src", imageSrc);
      $('#fullImage').css("display", "block");
      var imageThumbContainer = $('#imageThumbContainer');

      if(lastSelectedThumb !== null)
      {
	 lastSelectedThumb.removeClass("selected");
      }

      lastSelectedThumb =
	 imageThumbContainer.children('div.imageThumb:eq(' + String(i + 1)
	 + ')').children('img');

      lastSelectedThumb.addClass('selected');
      lastSelectedIndex = i;

      if(lastTaggedArea !== null)
      {
	 lastTaggedArea.removeClass('highlightTaggedArea');
	 lastTaggedArea = null;
      }
   }

   function populateSelectionBar(imageList)
   {
      for(var i = 0; i < imageList.length; i++)
      {
	 var imageSrc = imageList[i]['url'];
	 var thumbTemplateClone = $('#thumbTemplate').clone();
	 var imageThumbContainer = $('#imageThumbContainer');
	 thumbTemplateClone.css("display", "inline-block");
	 thumbTemplateClone.children('img').attr('src', imageSrc);
	 imageThumbContainer.append(thumbTemplateClone);

         (function(i)
	 {
	    thumbTemplateClone.click(function(evt)
	    {
	       selectImage(i);
	    });
	 })(i);
      }
   }

   populateSelectionBar(imageList);
   selectImage(1);

   $('a.addPointButton').click(function(evt)
   {
      var taggedArea = $('<div class="taggedArea"></div>');
      var taggedAreaDimensions = null;
      if(lastTaggedArea !== null)
      {
	 lastTaggedArea.removeClass('highlightTaggedArea');
	 lastTaggedArea = null;
      }

      if($('a.addPointButton').hasClass('disabled')) return;
      $('#pointInfoInputBlock').css("display", "block");
      $('#imageSelectionBarScreen').css("display", "block");
      $('#imageContainer .screen').css("display", "block");
      ($('.wireFrameCanvas').css("display", "block")).EnableWireFrameCanvas();
      $('a.addPointButton').addClass("disabled");
      $('a.addPointButton').html('Adding an item...');

      // add a tagged area to the image container
      $('#imageContainer').append(taggedArea);

      // add a handler to create/move/resize
      function createMoveResizeHandler(wireFrameInfo)
      {
	 taggedArea.css({'left': String(wireFrameInfo.left + 3) + "px",
	                'top' : String(wireFrameInfo.top + 3) + "px",
			'width' : String(wireFrameInfo.width) + "px",
			'height': String(wireFrameInfo.height) + "px"});

	 taggedAreaDimensions = wireFrameInfo;
      }

      $('.wireFrameCanvas').resize(createMoveResizeHandler);
      $('.wireFrameCanvas').create(createMoveResizeHandler);
      $('.wireFrameCanvas').moveEnd(createMoveResizeHandler);

      function clearWireFrameCanvas()
      {
	 $('.wireFrameCanvas').DisableWireFrame();
	 $('.wireFrameCanvas').Clear();
	 $('.wireFrameCanvas').css('display', 'none');
	 $('#imageContainer .screen').css('display', 'none');
	 $('#pointInfoInputBlock').css("display", "none");
	 $('#imageSelectionBarScreen').css("display", "none");
	 $('a.addPointButton').html('Add an item.').removeClass('disabled');
      }

      function cancelButtonClick(evt)
      {
	 clearWireFrameCanvas();
	 taggedArea.remove();
	 $('#pointInfoInputBlock button.submit').off('click', addButtonClick);
	 $('#pointInfoInputBlock button.cancel').off('click', cancelButtonClick);
      }

      function addButtonClick(evt)
      {
	 if(taggedAreaDimensions === null)
	 {
	    //todo:warning
	    return;
	 }

	 // get the name and the url
	 var pointname = $('#pointName').attr('value');
	 var pointurl = $('#pointLink').attr('value');

	 // get the points of the current image object
	 var pointsOfCurrentImageObj = imageList[lastSelectedIndex].points;

	 // define the point object
	 var pointObj = { 'id': undefined,
	                  'name': pointname,
			  'pointurl': pointurl,
			  'left': taggedAreaDimensions.left,
			  'top' : taggedAreaDimensions.top,
			  'width': taggedAreaDimensions.width,
			  'height': taggedAreaDimensions.height };

	 // define the list item
	 var pointListItem = $('<li>' + pointname + '</li>');

	 // add mouse events to the list item
	 var currentSelection = lastSelectedIndex;
	 function listItemClick(evt)
	 {
	    selectImage(currentSelection);
	    if(lastTaggedArea === taggedArea) return;

	    taggedArea.addClass('highlightTaggedArea');
	    if(lastTaggedArea !== null)
	    {
	       lastTaggedArea.removeClass('highlightTaggedArea');
	       lastTaggedArea = null;
	    }
	    lastTaggedArea = taggedArea;
	 }
	 pointListItem.click(listItemClick);

	 // add that list item to the ul
	 $('#pointDetailListContainer ul').append(pointListItem);

	 // add that point object to the list of image objects
	 pointsOfCurrentImageObj.push(pointObj);

	 // clear the screen
	 clearWireFrameCanvas();

	 // remove the addButtonClick
	 $('#pointInfoInputBlock button.submit').off('click', addButtonClick);
	 $('#pointInfoInputBlock button.cancel').off('click', cancelButtonClick);


	 // remove the event handlers for wireframe
	 $('.wireFrameCanvas').Off('resize', createMoveResizeHandler);
	 $('.wireFrameCanvas').Off('moveEnd', createMoveResizeHandler);
	 $('.wireFrameCanvas').Off('create', createMoveResizeHandler);
      }

      $('#pointInfoInputBlock button.cancel').click(cancelButtonClick);
      $('#pointInfoInputBlock button.submit').click(addButtonClick);
   });
});