/*
 *
 */
function TagFrames(pictureArray) {
    var addedDIV = null;

    var tagOutput = TaggedImg(pictureArray);

    // add the appropriate controls for the "add tag" button
    var addTagButton = $('#addTag');
    var cancelButton = $('#stopTag');
    cancelButton.click(function(evt){
        $(".ticAddTagItemCont").addClass("folded");
        addTagButton.show();
        cancelButton.hide();
        $('.ticMainImg').undelegate("*", "mousedown");

        $('#inputName').undelegate("*", "keyup");
        $('#cleanBn').undelegate("*", "click");

        $('.ticMainImg').css("cursor", "default");

        if (addedDIV !== null) {
            addedDIV.remove();
            addedDIV = null;
        }
    });
    addTagButton.click(function(evt) {
        var initTop = -1;
        var initLeft = -1;
        var fWidth = -1;
        var fHeight = -1;
        var offset;
        var divBox = $('<div class="ticTagBox"></div>');

        function mousemove(evt) {
            var curLeft = evt.pageX - offset.left;
            var curTop = evt.pageY - offset.top;

            var XStyle = ((curLeft < initLeft) ? "right" : "left");
            var YStyle = ((curTop < initTop) ? "bottom" : "top");

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
            toggleEnableAddItemButton();
        }

        function toggleEnableAddItemButton() {
            if (initTop >= 0 && initLeft >= 0 && fWidth > 0 & fHeight > 0
                    && $('#inputName').val() != "") {
                $('#addItemBn').removeClass("ticDisabled");
            }
            else {
                $('#addItemBn').addClass("ticDisabled");
            }
        }

        $(".ticAddTagItemCont").removeClass("folded");
        addTagButton.hide();
        cancelButton.show();

        $('.ticMainImg').delegate("*", "mousedown", mousedown);

        $('.ticMainImg').css("cursor", "crosshair");

        $('#inputName').keyup(function(evt) {
            toggleEnableAddItemButton();
        });

        $('#clearBn').click(function(evt) {
            // if there is a set div, remove it
            if (addedDIV !== null) {
                addedDIV.remove();
                addedDIV = null;
            }

            // clear the width/height etc
            initTop = initLeft = fWidth = fHeight = -1;

            // clear the dialog box
            $('#productName').val("");
            $('#productUrl').val("");

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
            var currentSelectedNumber = tagOutput.getSelectedNumber();
            var currentSelectedId = tagOutput.getSelectedId();
            var tagItemJSON = {"product": { "name": $('#productName').val(),
                "url" : $("#productUrl").val()},
                "imageId" : currentSelectedId,
                "left"   : initLeft,
                "top"    : initTop,
                "width"  : fWidth,
                "height" : fHeight};

            tagOutput.addTag(tagItemJSON, currentSelectedNumber);
            tagOutput.selectImg(currentSelectedNumber, true);

            // display the item
            $('#clearBn').click();

            $.post("/src/design/addImagePoint", tagItemJSON,
                    function(data){
                        // TODO: something if it fails.
                    });
        });
    });
}
