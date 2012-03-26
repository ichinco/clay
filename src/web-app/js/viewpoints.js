/**
 * Created by IntelliJ IDEA.
 * User: denise
 * Date: 3/15/12
 * Time: 10:38 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(evt) {
    $('#featureDisabledMessage').css("display", "none");

    viewer.populateSelectionBar(imageList);
    viewer.selectImage(0);

    $('a.addPointButton').click(function(evt) {
        viewer.addPoint();
    });
});