package com.clay

import grails.plugins.springsecurity.Secured
import grails.util.GrailsConfig

class DesignController {

    def springSecurityService
    def tagService
    def imageService

    def index = { }

    def list = {
        def designs = []
        if (Design.count() > 0){
            designs = Design.all;
        }

        def model = [:]
        model["designs"] = designs

        return model
    }

    def show = {
        int id = Integer.parseInt(params.id)

        Design design = Design.get(id);
        Comment parentComment = new Comment();
        parentComment.id = 0

        def model = [:]
        model['design'] = design

        return model
    }

    @Secured(["ROLE_USER"])
    def upload = {
        String designId = params.designId.toString()
        def f = request.getFile('image')

        String path = GrailsConfig.clay.design.localImageStore
        String filename = designId + java.util.UUID.randomUUID().toString()
        if(!f.empty) {
            f.transferTo( new File(path + filename) )
            String imageUrl1 = path + filename
            Image image1 = new Image();
            image1.url = imageUrl1
            image1.save()
            Design design = Design.get(Long.parseLong(designId))
            design.addToImages(image1)
            design.save()

            response.sendError(200,'Done');
        }
        else {
            flash.message = 'file cannot be empty'
            render(view:'uploadImage')
        }
    }

    @Secured(["ROLE_USER"])
    def create = {

    }

    @Secured(["ROLE_USER"])
    def uploadImage = {
        def model = [:]
        model.designId = params.designId

        model
    }

    @Secured(["ROLE_USER"])
    def save = {
        String description = params.description
        String title = params.title

        Design design = new Design();
        design.title = title
        design.description = description
        design.images = []
        design.user = (ClayUser) springSecurityService.currentUser
        design.save()

        redirect(action:"uploadImage.gsp", params:[designId:design.id]);
    }

    @Secured(["ROLE_USER"])
    def comment = {
        String text = params.commentText
        int designId = Integer.parseInt(params.designId)
        int parentId = Integer.parseInt(params.parentId)
        ClayUser user = (ClayUser) springSecurityService.currentUser

        Comment comment = new Comment();
        comment.text = text
        comment.user = user
        comment.parent = Comment.get(parentId)
        comment.save()

        Design design = Design.get(designId);
        if (design.comments == null) design.comments = []
        design.comments.add(comment)
        design.save()

        redirect(action:"show", params:[id:designId])
    }

    @Secured(["ROLE_USER"])
    def tagDesign = {
        String tagName = params.tagName
        int tagTypeId = Integer.parseInt(params.tagTypeId)
        int designId = Integer.parseInt(params.designId)

        Tag tag = tagService.getTag(tagTypeId, tagName)
        tagService.tagDesign(tag, Design.get(designId))

        redirect(action:"show", params:[id:designId])
    }

    @Secured(["ROLE_USER"])
    def addImagePoint = {
        double x = Double.parseDouble(params.x)
        double y = Double.parseDouble(params.y)
        double width = Double.parseDouble(params.width)
        double height = Double.parseDouble(params.height)
        String productName = params.productName
        String productUrl = params.productUrl
        int imageId = Integer.parseInt(params.imageId)

        Product product = imageService.createProduct(productName, productUrl)
        ImagePoint imagePoint = imageService.createImagePoint(x,y,width,height,product)
        imageService.addImagePoint(imagePoint, imageId)
    }
}
