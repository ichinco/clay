package com.clay

import grails.plugins.springsecurity.Secured
import grails.util.GrailsConfig
import grails.converters.JSON

class DesignController {

    def springSecurityService
    def tagService
    def imageService

    def index = { }

    @Secured(["ROLE_USER"])
    def signedInList = {
        redirect(controller:"design", action:"list")
    }

    def list = {
        def designs = []
        if (SavedDesign.count() > 0){
            designs = SavedDesign.all;
        }

        def model = [:]
        model["designs"] = designs

        return model
    }

    def show = {
        int id = Integer.parseInt(params.id)

        SavedDesign design = SavedDesign.get(id);
        Comment parentComment = new Comment();
        parentComment.id = 0

        def model = [:]
        model['design'] = design
        model['images'] = design.images.collect{ Image img ->
            [id: img.id,
             url: img.url,
             points: img.points.collect{ ImagePoint pt ->
                 [left: pt.left,
                 top: pt.top,
                 width: pt.width,
                 height: pt.height,
                 product: [name:pt.product.name, url:pt.product.url]]
             }]
        }

        return model
    }

    @Secured(["ROLE_USER"])
    def upload = {
        String designId = params.designId.toString()
        UnsavedDesign design = UnsavedDesign.get(Long.parseLong(designId))
        User user = (ClayUser) springSecurityService.currentUser
        if (user != design.user){
            flash.message = "cannot upload image to someone else's design."
            render(view:"uploadImage")
        }

        def f = request.getFile('image')
        String root = GrailsConfig.clay.design.localImageRoot
        String path = GrailsConfig.clay.design.localImageStore
        String filename = designId + java.util.UUID.randomUUID().toString()
        if(!f.empty) {
            f.transferTo( new File(root + path + filename) )
            String imageUrl1 = g.resource(dir:path, file:filename, absolute:true)
            Image image1 = new Image();
            image1.url = imageUrl1
            image1.design = design
            image1.save()

            if (!image1.validate()){
                throw new RuntimeException(design.errors.toString())
            }

            design.addToImages(image1)
            design.save()

            if (!design.validate()){
                throw new RuntimeException(design.errors.toString())
            }

            render(contentType:"text/json") { image1 }
        }
        else {
            flash.message = 'file cannot be empty'
            render(view:'uploadImage')
        }
    }

    @Secured(["ROLE_USER"])
    def create = {
        UnsavedDesign design = new UnsavedDesign()
        design.user = (ClayUser) springSecurityService.currentUser
        design.save()

        if (!design.validate()){
            throw new RuntimeException(design.errors.toString())
        }

        def model = [:]
        model["design"] = design

        render(view:"create", model:model)
    }

    @Secured(["ROLE_USER"])
    def uploadImage = {
        def model = [:]
        model.designId = params.designId

        model
    }

    @Secured(["ROLE_USER"])
    def save = {
        String unsavedDesignId = params.designId
        String description = params.description
        String title = params.title

        if (!unsavedDesignId) {
            throw new RuntimeException("missing design id")
        }

        UnsavedDesign unsavedDesign = UnsavedDesign.get(Long.parseLong(params.designId))

        SavedDesign design = new SavedDesign();
        design.title = title
        design.description = description
        design.images = unsavedDesign.images
        design.user = (ClayUser) springSecurityService.currentUser
        design.save()

        if (!design.validate()){
            throw new RuntimeException(design.errors.toString());
        }

        unsavedDesign.delete();

        if (!unsavedDesign.validate()){
            throw new RuntimeException(unsavedDesign.errors.toString());
        }

        redirect(action:"list")
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
    }

    @Secured(["ROLE_USER"])
    def addImagePoint = {
        double x = Double.parseDouble(params.left)
        double y = Double.parseDouble(params.top)
        double width = Double.parseDouble(params.width)
        double height = Double.parseDouble(params.height)
        String productName = params["product[name]"]
        String productUrl = params["product[url]"]
        int imageId = Integer.parseInt(params.imageId)
        User user = (ClayUser) springSecurityService.currentUser

        Product product = imageService.createProduct(productName, productUrl)
        Image image = Image.get(imageId)
        ImagePoint imagePoint = imageService.createImagePoint(x,y,width,height,product,user,image)
        imageService.addImagePoint(imagePoint, imageId)
    }
}
