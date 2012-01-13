<%--
  User: denise
  Date: 11/15/11
  Time: 9:22 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="clay"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400' rel='stylesheet' type='text/css'/>
    <link rel="stylesheet" href="${resource(dir:'css', file:'tag-image-control.css')}" />
</head>
<body>
    <g:render template="imageGallery" />

    <script src="${resource(dir: 'js', file: 'imgtag_s.js')}" type="text/javascript"></script>
    <script src="${resource(dir: 'js', file: 'imgtag_w.js')}" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            TagFrames(${images});
        });
    </script>
</body>

</html>