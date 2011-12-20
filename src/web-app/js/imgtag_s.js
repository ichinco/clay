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
    var titleBar = $('div.ticTitleBar');
    var display = $('div.ticDisplay');
    var mainImg = $('div.ticMainImg').css({"position": "absolute",
        "top":"30px"});
    var tagCont = $('div.ticTagCont');

    // display title and author
    var title = tagColObj["title"];
    var author = "<div class='tic user'>" + tagColObj["author"] + "</div>";

    titleBar.html(title + " by " + author);

    var ticImgBar = $(".ticImgBar");
    var images = tagColObj["images"];
    mainImg.html("<img src='" + images[0]["src"] + "'>");

    displayDIV = $('<div class="ticImgSel"></div>');
    mainImg.append(displayDIV);

    function createButton(index) {
        var button = $("<div class='ticImgBn'></div>");
        ticImgBar.append(button);

        button.click(function() {
            selectImg(index);
        });
    }

    createButton(0);

    var currentSelectedImg = -1;

    function selectImg(index, force) {
        if (currentSelectedImg == index && !force) return;

        mainImg.children("img").attr("src", images[index]["src"]);
        var curImgTags = images[index]["tags"];

        mainImg.children(".ticTagger").remove();
        for (var i = 0; i < curImgTags.length; i++) {
            (function(i) {
                var curTag = curImgTags[i];
                var width = parseInt(curTag['width']);
                var height = parseInt(curTag['height']);

                var setWidth = (width > 76) ? 60 : width - 16;
                var setHeight = (height > 68) ? 60 : height - 16;

                var centerX = parseInt(curTag['left']) + width / 2;
                var centerY = parseInt(curTag['top']) + height / 2;


                var tagDIV = $('<div class="ticTagger"></div>');
                tagDIV.css({"width" : String(setWidth) + "px",
                    "height" : String(setHeight) + "px",
                    "top" : String(centerY + 1 - setHeight / 2) + "px",
                    "left" : String(centerX + 1 - setWidth / 2) + "px"});

                tagDIV.mouseover(
                        function(evt) {
                            if (currentSelectedImg != index) return;

                            displayDIV.css("visibility", "visible");
                            displayDIV.css(curTag);
                        });

                tagDIV.mouseout(function(evt) {
                    displayDIV.css("visibility", "hidden");
                });

                mainImg.append(tagDIV);
            })(i);
        }

        ticImgBar.children('.ticSelImgBn').removeClass('ticSelImgBn');
        $(ticImgBar.children('.ticImgBn')[index]).addClass('ticSelImgBn');

        currentSelectedImg = index;
    }

    selectImg(0);

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

        tagCont.append(tagItem);
    }

    function createItems(index) {
        var curImgTags = images[index]["tags"];
        for (var i = 0; i < curImgTags.length; i++) {
            (function(i) {
                var curTag = curImgTags[i];
                createItem(curTag, index)
            })(i);
        }
    }

    createItems(0);

    // display other images
    for (var i = 1; i < images.length; i++) {
        var curImg = images[i];
        createButton(i);
        createItems(i);
    }

    return {
        "getSelNum" : function() {
            return currentSelectedImg;
        },
        "addTag"    : createItem,
        "selectImg" : selectImg
    };
}
