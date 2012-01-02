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
    var container = $('div.ticCont');
    var mainImage = $('div.ticMainImg').css({"position": "absolute",
        "top":"30px"});
    var tagContainer = $('div.ticTagCont');

    function createButton(index) {
        var button = $("<div class='ticImgBn'></div>");
        ticImageBar.append(button);

        button.click(function() {
            selectImg(index);
        });
    }

    function selectImg(index, force) {
        if (currentSelectedImage == index && !force) return;

        mainImage.children("img").attr("src", images[index]["src"]);
        var currentImageTags = images[index]["tags"];

        mainImage.children(".ticTagger").remove();
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
        tagItem.html(ItemsJSON["content"]["name"]);

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
        var currentImageTags = images[index]["tags"];
        for (var i = 0; i < currentImageTags.length; i++) {
            (function(i) {
                var currentTag = currentImageTags[i];
                createItem(currentTag, index)
            })(i);
        }
    }

    var ticImageBar = $(".ticImgBar");
    var images = tagColObj["images"];

    mainImage.html("<img src='" + images[0]["src"] + "'>");

    mainImage.append(displayDIV);

    var currentSelectedImage = -1;

    for (var i = 0; i < images.length; i++) {
        createButton(i);
        createItems(i);
    }

    selectImg(0);

    var displayDIV = $('<div class="ticImgSel"></div>');

    return {
        "getSelNum" : function() {
            return currentSelectedImage;
        },
        "addTag"    : createItem,
        "selectImg" : selectImg
    };
}
