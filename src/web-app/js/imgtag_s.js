/*
 * For displaying tagged image
 *
 */

// the tagColObj is JSON of the type:
//  {title: "...",
//   author: "...",
//   images: [imgObj]}
//
// and each imgObj is JSON of the type:
//  {caption: "",
//   tags   : [tagObj]}
// 
// convention being: the first imgObj is default (displayed as main) 
//
// can override the tagObj draw method

function TaggedImg(tagColObj) {
    // rudimentary checks
    if(tagColObj === null || tagColObj.length == 0)
    {
        console.log("shit went down hard...");
        return;
    }

    var container = $('div.ticCont');
    var mainImage = $('div.ticMainImg');
    var tagContainer = $('div.ticTagCont');
    var ticImageBar = $(".ticImgBar");
    var images = tagColObj;

    function createButton(index) {
        var button = $("<div class='ticImgBn'></div>");
        ticImageBar.append(button);

        button.click(function() {
            selectImg(index);
        });
    }

    function selectImg(index, force) {
        if (currentSelectedImage == index && !force) return;

        mainImage.children("img").attr("src", images[index]["url"]);
        var currentImageTags = images[index]["points"];

        mainImage.children(".ticTagger").remove();
        ticImageBar.children('.ticSelImgBn').removeClass('ticSelImgBn');
        $(ticImageBar.children('.ticImgBn')[index]).addClass('ticSelImgBn');

        currentSelectedImage = index;

        if (currentImageTags == null ) { return; }
        for (var i = 0; i < currentImageTags.length; i++) {
            (function(i) {
                var currentTag = currentImageTags[i];
                var width = parseInt(currentTag['width']);
                var height = parseInt(currentTag['height']);

                var setWidth = (width > 76) ? 60 : width - 16;
                var setHeight = (height > 68) ? 60 : height - 16;

                var centerX = parseInt(currentTag['left']) + width / 2;
                var centerY = parseInt(currentTag['top']) + height / 2;

                var tagDIV = $('<div class="ticTagger"></div>');
                tagDIV.css({"width" : String(setWidth) + "px",
                    "height" : String(setHeight) + "px",
                    "top" : String(centerY + 1 - setHeight / 2) + "px",
                    "left" : String(centerX + 1 - setWidth / 2) + "px"});

                tagDIV.mouseover(
                        function(evt) {
                            if (currentSelectedImage != index) return;

                            displayDIV.css("visibility", "visible");
                            displayDIV.css(currentTag);
                        });

                tagDIV.mouseout(function(evt) {
                    displayDIV.css("visibility", "hidden");
                });

                mainImage.append(tagDIV);
            })(i);
        }

        ticImageBar.children('.ticSelImgBn').removeClass('ticSelImgBn');
        $(ticImageBar.children('.ticImgBn')[index]).addClass('ticSelImgBn');

        currentSelectedImage = index;
    }

    function createItem(ItemsJSON, index) {
        var tagItem = $('<div class="tic ticTagItem"></div>');
        tagItem.html(ItemsJSON["product"]["name"]);

        tagItem.mouseover(
                function(evt) {
                    selectImg(index);

                    displayDIV.css("visibility", "visible");
                    displayDIV.css(ItemsJSON);
                });
        tagItem.mouseout(function(evt) {
            displayDIV.css("visibility", "hidden");
        });

        tagContainer.append(tagItem);
    }

    function createItems(index) {
        var currentImageTags = images[index]["points"];
        if (currentImageTags == null ) { return; }
        for (var i = 0; i < currentImageTags.length; i++) {
            (function(i) {
                var currentTag = currentImageTags[i];
                createItem(currentTag, index)
            })(i);
        }
    }

    mainImage.html("<span></span><img class='galleryImage' src='" + images[0]["url"] + "'>");

    var displayDIV = $('<div class="ticImgSel"></div>');
    mainImage.append(displayDIV);

    var currentSelectedImage = -1;
    for (var i = 0; i < images.length; i++) {
        createButton(i);
        createItems(i);
    }

    selectImg(0);

    // render the close button
    $('#ticContClose').click(function(evt)
        {
            $(".imageMain").css("display", "none");
        })

    return {
        "getSelectedNumber" : function() {
            return currentSelectedImage;
        },
        "getSelectedId" : function () {
            return images[currentSelectedImage]["id"];
        },
        "addTag"    : createItem,
        "selectImg" : selectImg
    };
}
