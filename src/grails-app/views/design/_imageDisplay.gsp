<%--
  Created by IntelliJ IDEA.
  User: denise
  Date: 1/23/12
  Time: 10:12 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <div class="ticCont">
        <div class="tic ticDisplay">
            <div class="tic ticMainImg"></div>
        </div>
        <div class="tic ticImgBar"></div>
        <div class="tic ticTagCont"></div>
        <div class="tagControl" id="addTag">tag products</div>
        <div class="tagControl" id="stopTag">cancel</div>
    </div>
    <div class="tagCntrl">
        <div id="caption">
            <div class="label">url:</div>
            <g:textField id="productUrl" name="productUrl"/>
            <div class="label">name</div>
            <g:textField id="productName" name="productName"/>
            <g:submitButton name="submitter" value="submit" id="addItemBn" class="ticBn ticDisabled">add</g:submitButton>
            <div id=clearBn class="ticBn">clear</div>
        </div>
    </div>
</html>