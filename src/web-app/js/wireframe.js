/**
 * Created by IntelliJ IDEA.
 * User: denise
 * Date: 3/15/12
 * Time: 10:40 PM
 * To change this template use File | Settings | File Templates.
 */
/**
 *
 *
 **/
(function($){
   var wireFrameEnabled = true;
   var wireFrame = $('<div class="wireFrame"></div>');
   var wireFrameMin = $('<div class="minWireFrame"></div>');
   var resizeHandle = $('<div class="resizeButton"></div>');
   var wireFrameSetup = false;

   var initialCreateEventHandlers = [];
   var resizeEventHandlers = [];
   var moveEndEventHandlers = []
   var moveEventHandlers = [];
   var eventNameMap =
   {
      'resize': resizeEventHandlers,
      'moveEnd' : moveEndEventHandlers,
      'create'  : initialCreateEventHandlers
   };

   function disableWireFrame()
   {
      wireFrameEnabled = false;
   }

   $.fn.IsWireFrameEnabled = function()
   {
      return wireFrameEnabled;
   }

   $.fn.IsWireFrameSetup = function()
   {
      return wireFrameSetup;
   }
   $.fn.resize = function(eventHandler) { resizeEventHandlers.push(eventHandler); }
   $.fn.create = function(eventHandler) { initialCreateEventHandlers.push(eventHandler); }
   $.fn.moveEnd = function(eventHandler) { moveEndEventHandlers.push(eventHandler); }

   $.fn.Off = function(eventName, eventHandler)
   {
      var arrayInQuestion = eventNameMap[eventName];
      var indexOf = arrayInQuestion.indexOf(eventHandler);
      if(indexOf > -1)
	 arrayInQuestion.splice(indexOf, 1);
   }

   $.fn.EnableWireFrameCanvas = function(){
      var wireFrameCanvas = this;
      if(wireFrameSetup)
      {
	 wireFrameEnabled = true;
	 wireFrameCanvas.css('cursor', 'crosshair');
	 return;
      }
      var wireFrameOptions = {
	 "minWidth": 40,
	 "maxWidth": 600,
	 "minHeight": 40,
	 "maxHeight": 400,
	 "boundToBox": true,
	 "snap"      : false
      };
      var initialClickTop = 0;
      var initialClickLeft = 0;
      var wireFrameInfo = {
	 "top": 0,
	 "left": 0,
	 "width": 0,
	 "height": 0
      };

      wireFrameCanvas.css("cursor", "crosshair");
      wireFrameCanvas.addClass('wireFrameCanvas');
      wireFrameCanvas.append(wireFrame);
      wireFrameCanvas.append(wireFrameMin);

      wireFrameCanvas.mousedown(function(evt)
	 {
	    if(!wireFrameEnabled) return;
	    evt.preventDefault();

	    var eventTarget = (evt.srcElement)? evt.srcElement : evt.target;

	    var targetOffset = $(eventTarget).offset();
	    var initialX = parseInt(evt.pageX);
	    var initialY = parseInt(evt.pageY);
	    var initialLeft = initialX - targetOffset.left;
	    var initialTop = initialY - targetOffset.top;

	    var minWidth = wireFrameOptions["minWidth"];
	    var minHeight = wireFrameOptions["minHeight"];

	    wireFrame.css({'top': String(initialTop) + "px",
	       'left': String(initialLeft) + "px",
	       'width': "1px",
	       'height': "1px",
	       'display': 'block' });
	    wireFrameMin.css({'top': String(initialTop) + "px",
	       'left': String(initialLeft) + "px",
	       'width': String(minWidth) + "px",
	       'height': String(minHeight) + "px",
	       'display': 'block' });

	    function documentMouseMove(evt)
	    {
	       var width = evt.pageX - initialX;
	       var height = evt.pageY - initialY;
	       var absWidth = Math.abs(width);
	       var absHeight = Math.abs(height);

	       if(width < 0)
	       {
		  wireFrame.css('left', String(evt.pageX - targetOffset.left) + "px");
		  wireFrameMin.css('left', String(initialLeft - minWidth) + "px");
		  if(absHeight < minHeight)
		  {
		     if(absWidth > minWidth)
		     {
			wireFrameMin.css('left', wireFrame.css('left'));
		     }
		  }
	       }
	       else
	       {
		  wireFrame.css('left', String(initialLeft) + "px");
		  wireFrameMin.css('left', String(initialLeft) + "px");
	       }

	       if(height < 0)
	       {
		  wireFrame.css('top', String(evt.pageY - targetOffset.top) + "px");
		  wireFrameMin.css('top', String(initialTop - minHeight) + "px");
		  if(absWidth < minWidth)
		  {
		     if(absHeight > minHeight)
		     {
			wireFrameMin.css('top', wireFrame.css('top'));
		     }
		  }
	       }
	       else
	       {
		  wireFrame.css('top', String(initialTop) + "px");
		  wireFrameMin.css('top', String(initialTop) + "px");
	       }

	       if(absWidth < minWidth)
	       {
		  wireFrameMin.css("display", "block");
		  if(absHeight >= minHeight)
		  {
		     wireFrameMin.css("height", String(absHeight) + "px");
		  }
		  else
		  {
		     wireFrameMin.css({'width': String(minWidth) + 'px',
		                       'height': String(minHeight) + 'px'});
		  }
	       }
	       else
	       {
		  if(absHeight < minHeight)
		  {
		     wireFrameMin.css("width", String(absWidth) + "px");
		     wireFrameMin.css("display", "block");
		  }
		  else
		  {
		     wireFrameMin.css({'display': 'none',
		                       'height' : String(minHeight) + "px",
				       'width'  : String(minWidth) + "px"});
		  }
	       }

	       wireFrame.css({'width': String(Math.abs(width)) + "px",
	                      'height': String(Math.abs(height)) + "px"});
	    }

	    $(document).mousemove(documentMouseMove);

	    function windowMouseUp(evt)
	    {
	       $(document).off('mousemove', documentMouseMove);
	       $(document).off('mouseup', windowMouseUp);
	       var wireFrameOffset = wireFrame.position();

	       if(wireFrameMin.css("display") == "block")
	       {
		  wireFrame.css({'left': wireFrameMin.css("left"),
		                 'top' : wireFrameMin.css("top"),
				 'width': wireFrameMin.css("width"),
				 'height': wireFrameMin.css("height")});
		  wireFrameMin.css("display", "none");
	       }

	       wireFrameInfo = {"left": wireFrameOffset.left,
	          "top": wireFrameOffset.top,
		  "width": wireFrame.width(),
		  "height": wireFrame.height()};

	       $.each(initialCreateEventHandlers, function(index, value)
		  { value(wireFrameInfo); });
	    }

	    $(document).mouseup(windowMouseUp);
	 });

      function enableResize(wireFrame)
      {
	 // add a resize at the bottom-right

	 function updateResizeHandlePosition()
	 {
	    var wireFramePosition = wireFrame.position();
	    resizeHandle.css({"left":
		  String(wireFramePosition.left + wireFrame.width()) + "px",
	       "top": String(wireFramePosition.top + wireFrame.height()) + "px"});


	 }

	 wireFrameCanvas.append(resizeHandle);
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
		  var minWidth = wireFrameOptions['minWidth'];
		  var minHeight = wireFrameOptions['minHeight'];

		  wireFrame.css('cursor', 'nw-resize');

		  wireFramePosition = wireFrame.position();

		  if(newWidth > minWidth)
		  {
		     wireFrame.css("width", String(newWidth) + "px");
		     resizeHandle.css("left", String(wireFramePosition.left +
			wireFrame.width()) + "px");
		  }
		  if(newHeight > minHeight)
		  {
		     wireFrame.css("height", String(newHeight) + "px");
		     resizeHandle.css("top", String(wireFramePosition.top +
			wireFrame.height()) + "px");
		  }
	       }

	       function windowMouseUp(evt)
	       {
		  $(document).off("mousemove", documentMouseMove);
		  $(document).off("mouseup", windowMouseUp);
		  var wireFrameOffset = wireFrame.position();

		  wireFrame.css('cursor', 'move');

		  wireFrameInfo = {"left": wireFrameOffset.left,
		     "top": wireFrameOffset.top,
		     "width": wireFrame.width(),
		     "height": wireFrame.height()};

		  $.each(resizeEventHandlers, function(index, value)
		     { value(wireFrameInfo); });
	       }

	       $(document).mousemove(documentMouseMove);
	       $(document).mouseup(windowMouseUp);
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

	       var wireFrameOffset = wireFrame.position();
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
	       $(document).off("mouseup", windowMouseUp);

	       var wireFrameOffset = wireFrame.position();
	       wireFrameInfo = {"left": wireFrameOffset.left,
		  "top": wireFrameOffset.top,
		  "width": wireFrame.width(),
		  "height": wireFrame.height()};
	       $.each(moveEndEventHandlers, function(index, value)
		  { value(wireFrameInfo); });
	    }

	    $(document).mousemove(documentMouseMove);
	    $(document).mouseup(windowMouseUp);
	 }

	 wireFrame.mousedown(wireFrameMouseDown);
      }

      initialCreateEventHandlers.push(function(wireFrameInfo)
      {
	 disableWireFrame();
	 wireFrameCanvas.css('cursor', 'default');
	 enableResize(wireFrame);
	 enableWireFrameMove(wireFrame);
      });

      wireFrameSetup = true;
   }

   $.fn.DisableWireFrame = function()
   {
      disableWireFrame();
   }

   $.fn.Clear = function()
   {
      wireFrame.css("display", "none");
      wireFrameMin.css("display", "none");
      resizeHandle.remove();
   }
})(jQuery);
