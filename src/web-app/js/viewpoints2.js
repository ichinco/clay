/**
 * User: denise
 * Date: 3/25/12
 * Time: 6:10 PM
 */

var viewer = {
    'lastSelectedThumb' : null,
    'lastSelectedIndex' : -1,
    'lastTaggedArea' : null,
    'imageList' : null,
    'taggedAreaDimensions' : null,
    'taggedArea' : null,

    'getImageById' : function(index) {
        return this.imageList[index]
    },

    'getCurrent' : function() {
        return this.getImageById(lastSelectedIndex);
    },

    'selectImage' : function(i) {
        if (this.lastSelectedIndex == i) return;

        var imageSrc = this.getImageById(i)['url'];
        $('#fullImage').attr("src", imageSrc);
        $('#fullImage').css("display", "block");
        var imageThumbContainer = $('#imageThumbContainer');

        if (this.lastSelectedThumb !== null) {
            this.lastSelectedThumb.removeClass("selected");
        }

        this.lastSelectedThumb =
            imageThumbContainer.children('div.imageThumb:eq(' + String(i + 1)
                    + ')').children('img');

        this.lastSelectedThumb.addClass('selected');
        this.lastSelectedIndex = i;

        if (this.lastTaggedArea !== null) {
            this.lastTaggedArea.removeClass('highlightTaggedArea');
            this.lastTaggedArea = null;
        }
    },

    'populateSelectionBar' : function(imageList) {
        this.imageList = imageList;
        for (var i = 0; i < imageList.length; i++) {
            var imageSrc = this.getImageById(i)['url'];
            var thumbTemplateClone = $('#thumbTemplate').clone();
            var imageThumbContainer = $('#imageThumbContainer');
            thumbTemplateClone.css("display", "inline-block");
            thumbTemplateClone.children('img').attr('src', imageSrc);
            imageThumbContainer.append(thumbTemplateClone);

            (function (i){
                thumbTemplateClone.click(function(evt) {
                    viewer.selectImage(i);
                });
            })(i);
        }
    },

    // add a handler to create/move/resize
    'createMoveResizeHandler' : function(wireFrameInfo) {
        this.taggedArea.css({'left': String(wireFrameInfo.left + 3) + "px",
            'top' : String(wireFrameInfo.top + 3) + "px",
            'width' : String(wireFrameInfo.width) + "px",
            'height': String(wireFrameInfo.height) + "px"});

        this.taggedAreaDimensions = wireFrameInfo;
    },

    'clearWireFrameCanvas' : function() {
        $('.wireFrameCanvas').DisableWireFrame();
        $('.wireFrameCanvas').Clear();
        $('.wireFrameCanvas').css('display', 'none');
        $('#imageContainer .screen').css('display', 'none');
        $('#pointInfoInputBlock').css("display", "none");
        $('#imageSelectionBarScreen').css("display", "none");
        $('a.addPointButton').html('Add an item.').removeClass('disabled');
    },

    'cancelButtonClick' : function(evt) {
        this.clearWireFrameCanvas();
        this.taggedArea.remove();
        $('#pointInfoInputBlock button.submit').off('click', this.addButtonClick);
        $('#pointInfoInputBlock button.cancel').off('click', this.cancelButtonClick);
    },

    'listItemClick' : function(evt) {
        if (this.lastTaggedArea === this.taggedArea) return;

        this.taggedArea.addClass('highlightTaggedArea');
        if (this.lastTaggedArea !== null) {
            this.lastTaggedArea.removeClass('highlightTaggedArea');
            this.lastTaggedArea = null;
        }
        this.lastTaggedArea = this.taggedArea;
    },

    addToDisplay : function(pointObj) {
        // define the list item
        var pointListItem = $('<li>' + pointObj.product.name + '</li>');

        pointListItem.click(listItemClick);

        // add that list item to the ul
        $('#pointDetailListContainer ul').append(pointListItem);

        // clear the screen
        this.clearWireFrameCanvas();

        // remove the addButtonClick
        $('#pointInfoInputBlock button.submit').off('click', addButtonClick);
        $('#pointInfoInputBlock button.cancel').off('click', cancelButtonClick);

        // remove the event handlers for wireframe
        $('.wireFrameCanvas').Off('resize', createMoveResizeHandler);
        $('.wireFrameCanvas').Off('moveEnd', createMoveResizeHandler);
        $('.wireFrameCanvas').Off('create', createMoveResizeHandler);
    },

    'addButtonClick' : function(evt) {
        if (this.taggedAreaDimensions === null) {
            //todo:warning
            return;
        }

        // get the name and the url
        var pointname = $('#pointName').attr('value');
        var pointurl = $('#pointLink').attr('value');

        // define the point object
        var pointObj = { 'id': undefined,
            'product' : {
                'name': pointname,
                'url': pointurl
            },
            'imageId' : getCurrent().id,
            'left': taggedAreaDimensions.left,
            'top' : taggedAreaDimensions.top,
            'width': taggedAreaDimensions.width,
            'height': taggedAreaDimensions.height
        };

        // add that point object to the list of image objects
        this.getCurrent().points.push(pointObj);

        this.addToDisplay(pointObj)

        $.post("/src/design/addImagePoint", pointObj);
    },

    'addPoint' : function(){
        this.taggedArea = $('<div class="taggedArea"></div>');
        if (this.lastTaggedArea !== null) {
            this.lastTaggedArea.removeClass('highlightTaggedArea');
            this.lastTaggedArea = null;
        }

        if ($('a.addPointButton').hasClass('disabled')) return;
        $('#pointInfoInputBlock').css("display", "block");
        $('#imageSelectionBarScreen').css("display", "block");
        $('#imageContainer .screen').css("display", "block");
        ($('.wireFrameCanvas').css("display", "block")).EnableWireFrameCanvas();
        $('a.addPointButton').addClass("disabled");
        $('a.addPointButton').html('Adding an item...');

        // add a tagged area to the image container
        $('#imageContainer').append(this.taggedArea);

        $('.wireFrameCanvas').resize(this.createMoveResizeHandler);
        $('.wireFrameCanvas').create(this.createMoveResizeHandler);
        $('.wireFrameCanvas').moveEnd(this.createMoveResizeHandler);

        $('#pointInfoInputBlock button.cancel').click(this.cancelButtonClick);
        $('#pointInfoInputBlock button.submit').click(this.addButtonClick);
    }
};
