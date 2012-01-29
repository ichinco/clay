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

      var initialCreateEventHandlers = [];
      var resizeEventHandlers = [];
      var moveEndEventHandlers = []
      var moveEventHandlers = [];

      wireFrameCanvases.css("cursor", "crosshair");
      wireFrameCanvases.addClass('wireFrameCanvas');
      wireFrameCanvases.append(wireFrame);
      wireFrameCanvases.mousedown(function(evt)
	 {
	    if(!wireFrameEnabled) return;
	    evt.preventDefault();

	    var eventTarget = (evt.srcElement)? evt.srcElement : evt.target;

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

	       $.each(initialCreateEventHandlers, function(index, value)
		  { value(wireFrameInfo); });
	    }

	    $(window).mouseup(windowMouseUp);
	 });

      function disableWireFrame()
      {
	 wireFrameEnabled = false;
      }

      function enableResize(wireFrame)
      {
	 // add a resize at the bottom-right
	 var resizeHandle = $('<div class="resizeButton"></div>');
	 function updateResizeHandlePosition()
	 {
	    var wireFramePosition = wireFrame.position();
	    resizeHandle.css({"left": 
		  String(wireFramePosition.left + wireFrame.width()) + "px",
	       "top": String(wireFramePosition.top + wireFrame.height()) + "px"});


	 }

	 wireFrameCanvases.append(resizeHandle);
	 updateResizeHandlePosition();

	 resizeHandle.mousedown(function(evt)
	    {
	       var initialX = evt.pageX;
	       var initialY = evt.pageY;
	       var initialWidth = wireFrame.width();
	       var initialHeight = wireFrame.height();

	       evt.preventDefault();

	       function documentMouseMove(evt)
	       {
		  var newWidth = initialWidth + evt.pageX - initialX;
		  var newHeight = initialHeight + evt.pageY - initialY;
		  wireFramePosition = wireFrame.position();

		  if(newWidth > 0)
		  {
		     wireFrame.css("width", String(newWidth) + "px");
		     resizeHandle.css("left", String(wireFramePosition.left + 
			wireFrame.width()) + "px");
		  }
		  if(newHeight > 0)
		  {
		     wireFrame.css("height", String(newHeight) + "px");
		     resizeHandle.css("top", String(wireFramePosition.top + 
			wireFrame.height()) + "px");
		  }
	       }

	       function windowMouseUp(evt)
	       {
		  $(document).off("mousemove", documentMouseMove);
		  $(window).off("mouseup", windowMouseUp);
		  var wireFrameOffset = wireFrame.offset();

		  wireFrameInfo = {"left": wireFrameOffset.left,
		     "top": wireFrameOffset.top,
		     "width": wireFrame.width(),
		     "height": wireFrame.height()};

		  $.each(resizeEventHandlers, function(index, value)
		     { value(wireFrameInfo); });
	       }

	       $(document).mousemove(documentMouseMove);
	       $(window).mouseup(windowMouseUp);
	    });

	 moveEventHandlers.push(function(wireFrameInfo)
	    {
	       updateResizeHandlePosition();
	    });
      }

      function enableWireFrameMove(wireFrame)
      {
	 wireFrame.css("cursor", "move");

	 function wireFrameMouseDown(evt)
	 {
	    var initialX = evt.pageX;
	    var initialY = evt.pageY;
	    var wireFramePosition = wireFrame.position();

	    var initialWireFrameLeft = wireFramePosition.left;
	    var initialWireFrameTop = wireFramePosition.top;

	    evt.preventDefault();

	    function documentMouseMove(evt)
	    {
	       var newLeft = initialWireFrameLeft + evt.pageX - initialX;
	       var newTop = initialWireFrameTop + evt.pageY - initialY;

	       wireFrame.css({ "left": String(newLeft) + "px",
	          "top": String(newTop) + "px"});

	       var wireFrameOffset = wireFrame.offset();
	       wireFrameInfo = {"left": wireFrameOffset.left,
		  "top": wireFrameOffset.top,
		  "width": wireFrame.width(),
		  "height": wireFrame.height()};
	       $.each(moveEventHandlers, function(index, value)
		  { value(wireFrameInfo); });
	    }

	    function windowMouseUp(evt)
	    {
	       $(document).off("mousemove", documentMouseMove);
	       $(window).off("mouseup", windowMouseUp);

	       var wireFrameOffset = wireFrame.offset();
	       wireFrameInfo = {"left": wireFrameOffset.left,
		  "top": wireFrameOffset.top,
		  "width": wireFrame.width(),
		  "height": wireFrame.height()};
	       $.each(moveEndEventHandlers, function(index, value)
		  { value(wireFrameInfo); });
	    }

	    $(document).mousemove(documentMouseMove);
	    $(window).mouseup(windowMouseUp);
	 }

	 wireFrame.mousedown(wireFrameMouseDown);
      }

      initialCreateEventHandlers.push(function(wireFrameInfo)
      {
	 disableWireFrame();
	 wireFrameCanvases.css('cursor', 'default');
	 enableResize(wireFrame);
	 enableWireFrameMove(wireFrame);
      });
   }
);
