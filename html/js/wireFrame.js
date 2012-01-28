/**
 *
 *
 **/
(function($){
   $.fn.EnableWireFrameCanvas
   {
      // stuff
   }
})( jQuery);

$(document).ready(
   function(evt){
      // create a wireframe
      var wireFrameCanvases = $('#wireFrameCanvas');
      var wireFrame = $('<div class="wireFrame"></div>');

      var initialClickTop = 0;
      var initialClickLeft = 0;
      var wireFrameEnabled = true;
      
      var wireFrameInfo = {
	 "top": 0,
	 "left": 0,
	 "width": 0,
	 "height": 0
      };

      var resizeEventHandlers = [];

      wireFrameCanvases.css("cursor", "crosshair");
      wireFrameCanvases.addClass('wireFrameCanvas');
      wireFrameCanvases.append(wireFrame);
      wireFrameCanvases.mousedown(function(evt)
	 {
	    if(!wireFrameEnabled) return;
	    evt.preventDefault();

	    var eventTarget = (evt.srcElement)? evt.srcElement : evt.target;
	    var curWireFrame = eventTarget.children(".wireFrame");

	    var targetOffset = $(eventTarget).offset();
	    //var bodyOffset = $(document.body).offset();
	    var initialX = parseInt(evt.pageX);
	    var initialY = parseInt(evt.pageY);
	    var initialLeft = initialX - targetOffset.left;
	    var initialTop = initialY - targetOffset.top;

	    wireFrame.css({'top': String(initialTop) + "px", 
	       'left': String(initialLeft) + "px",
	       'display': 'block' });

	    function documentMouseMove(evt)
	    {
	       var width = evt.pageX - initialX;
	       var height = evt.pageY - initialY; 

	       if(width < 0)
		  wireFrame.css('left', String(evt.pageX - targetOffset.left) + "px");

	       if(height < 0)
		  wireFrame.css('top', String(evt.pageY - targetOffset.top) + "px");

	       wireFrame.css({'width': String(Math.abs(width)) + "px",
	                      'height': String(Math.abs(height)) + "px"});
	    }

	    $(document).mousemove(documentMouseMove);

	    function windowMouseUp(evt)
	    {
	       $(document).off('mousemove', documentMouseMove);
	       $(window).off('mouseup', windowMouseUp);
	       var wireFrameOffset = wireFrame.offset();

	       wireFrameInfo = {"left": wireFrameOffset.left,
	          "top": wireFrameOffset.top,
		  "width": wireFrame.width(),
		  "height": wireFrame.height()};

	       for(var i = 0; i < resizeEventHandlers.length; i++)
	       {
		  resizeEventHandlers[i](wireFrameInfo);
	       }
	    }

	    $(window).mouseup(windowMouseUp);
	 });

         function disableWireFrame()
	 {
	    wireFrameEnabled = false;
	 }


         function enableResize(wireFrame)
	 {
	    var resizeBottom = $('<div></div>');
	    var resizeRight = $('<div></div>');
	 }

	 var myFun = function(wireFrame){alert("");};

	 resizeEventHandlers.push(function(wireFrameInfo)
	 {
	    disableWireFrame();
	    wireFrameCanvases.css('cursor', 'default');
	 });
   }
);
