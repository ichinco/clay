package com.clay

class DesignController {

    def springSecurityService
    def tagService

    def index = { }

    def list = {
        def designs = Design.all;

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

    def create = {
        String description = params.description
        String title = params.title
        String imageUrl1 = params.imageUrl1
        Image image1 = new Image();
        image1.url = imageUrl1
        image1.save()
        String imageUrl2 = params.imageUrl2
        Image image2 = new Image();
        image2.url = imageUrl2
        image2.save()
        String imageUrl3 = params.imageUrl3
        Image image3 = new Image();
        image3.url = imageUrl3
        image3.save()

        Design design = new Design();
        design.title = title
        design.description = description
        design.images = []
        design.images.add(image1)
        design.images.add(image2)
        design.images.add(image3)
        design.user = (ClayUser) springSecurityService.currentUser
        design.save()
    }

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

    def tagDesign = {
        String tagName = params.tagName
        int tagTypeId = Integer.parseInt(params.tagTypeId)
        int designId = Integer.parseInt(params.designId)

        Tag tag = tagService.getTag(tagTypeId, tagName)
        tagService.tagDesign(tag, Design.get(designId))
    }
}
