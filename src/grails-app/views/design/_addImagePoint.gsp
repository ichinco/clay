<%--
  User: denise
  Date: 11/15/11
  Time: 9:22 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
    <g:render template="imageGallery" />

    <script src="${resource(dir: 'js', file: 'imgtag_s.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js', file: 'imgtag_w.js')}" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            // just bring up nothing

            //TagFrames(${images});
        });
    </script>