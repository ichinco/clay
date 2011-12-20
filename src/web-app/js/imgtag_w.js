/*
 *
 */
function TagFrames(picArr) {
    // from stackoverflow JSON obj to string
    // converts a JSON object to string
    JSON.stringify = JSON.stringify || function (obj) {
        var t = typeof (obj);
        if (t != "object" || obj === null) {
            // simple data type
            if (t == "string") obj = '"' + obj + '"';
            return String(obj);
        }
        else {
            // recurse array or object
            var n, v, json = [], arr = (obj && obj.constructor == Array);
            for (n in obj) {
                v = obj[n];
                t = typeof(v);
                if (t == "string") v = '"' + v + '"';
                else if (t == "object" && v !== null) v = JSON.stringify(v);
                json.push((arr ? "" : '"' + n + '":') + String(v));
            }
            return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
        }
    };

    // build the image object (with empty tags) and load it to the viewer
    var displayArr = {
        "title" : "another living room",
        "author" : "glassfin",
        "images" : $.map(picArr,
                function(elt, index) {
                    return {
                        "src": elt,
                        "caption" : "",
                        "tags" : []
                    }
                })
    };

    var tagOutput = TaggedImg(displayArr);

    $('#jsonout').html(JSON.stringify(displayArr));

    // add the appropriate controls for the "add tag" button
    var addTagButton =
        $(".ticAddTagItem").children(".ticBn").click(function(evt) {
            var initTop = -1;
            var initLeft = -1;
            var fWidth = -1;
            var fHeight = -1;
            var offset;
            var divBox = $('<div class="ticTagBox"></div>');
            var addedDIV = null;

            function mousemove(evt) {
                var curLeft = evt.pageX - offset.left;
                var curTop = evt.pageY - offset.top;

                var XStyle = ((curLeft < initLeft) ? "right" : "left");
                var YStyle = ((curTop < initTop) ? "bottom" : "top");

                $("#width").html(curLeft - initLeft);
                $("#height").html(curTop - initTop);

                divBox.css({
                    "left" : String(initLeft) + "px",
                    "top" : String(initTop) + "px",
                    "width" : String(Math.abs(curLeft - initLeft)) + "px",
                    "height" : String(Math.abs(curTop - initTop)) + "px"
                });
            }

            function mousedown(evt) {
                offset = $(".ticMainImg").offset();
                initLeft = evt.pageX - offset.left;
                initTop = evt.pageY - offset.top;

                $('#x').html(initLeft);
                $('#y').html(initTop);

                evt.stopPropagation();
                evt.preventDefault();

                $(document).delegate("*", "mousemove", mousemove);
                $(document).delegate("*", "mouseup", mouseup);
                $('.ticMainImg').append(divBox);
            }

            function mouseup(evt) {
                evt.stopPropagation();
                $('.ticMainImg').append(addedDIV = divBox.clone());
                fWidth = divBox.width();
                fHeight = divBox.height();
                divBox.remove();
                $(document).undelegate("*", "mousemove");
                $(document).undelegate("*", "mouseup");

                $('.ticMainImg').undelegate("*", "mousedown");
                $('.ticMainImg').css("cursor", "default");
                togEnableAddItemBn();
            }

            function togEnableAddItemBn() {
                if (initTop >= 0 && initLeft >= 0 && fWidth > 0 & fHeight > 0
                        && $('#inputName').val() != "") {
                    $('#addItemBn').removeClass("ticDisabled");
                }
                else {
                    $('#addItemBn').addClass("ticDisabled");
                }
            }

            if (addTagButton.html() == "add tags") {
                $(".ticAddTagItemCont").removeClass("folded");
                addTagButton.html("cancel");

                $('.ticMainImg').delegate("*", "mousedown", mousedown);

                $('.ticMainImg').css("cursor", "crosshair");

                $('#inputName').keyup(function(evt) {
                    togEnableAddItemBn();
                });

                $('#clearBn').click(function(evt) {
                    // if there is a set div, remove it
                    if (addedDIV !== null) {
                        addedDIV.remove();
                        addedDIV = null;
                    }

                    // clear the width/height etc
                    initTop = initLeft = fWidth = fHeight = -1;
                    $("#width").html("width:");
                    $('#height').html("height:");
                    $('#x').html("left:");
                    $('#y').html("top:");

                    // clear the dialog box
                    $('#inputName').val("");

                    // restore your ability to draw
                    divBox = $('<div class="ticTagBox"></div>');
                    $('.ticMainImg').delegate("*", "mousedown", mousedown);

                    $('.ticMainImg').css("cursor", "crosshair");

                    // unset the add button
                    $('#addItemBn').addClass("ticDisabled");
                });

                $('#addItemBn').click(function(evt) {
                    if ($('#addItemBn').hasClass("ticDisabled")) return;

                    // add an item to the object
                    var curSel = tagOutput.getSelNum();
                    var tagItemJSON = {"content": {"name": $('#inputName').val()},
                        "left"   : initLeft,
                        "top"    : initTop,
                        "width"  : fWidth,
                        "height" : fHeight};

                    displayArr["images"][curSel]["tags"].push(tagItemJSON);

                    tagOutput.addTag(tagItemJSON, curSel);
                    tagOutput.selectImg(curSel, true);

                    // display the item
                    $('#jsonout').html(JSON.stringify(displayArr));
                    $('#clearBn').click();

                });

            } else {
                $(".ticAddTagItemCont").addClass("folded");
                addTagButton.html("add tags");
                $('.ticMainImg').undelegate("*", "mousedown");

                $('#inputName').undelegate("*", "keyup");
                $('#cleanBn').undelegate("*", "click");
            }
        });
}
