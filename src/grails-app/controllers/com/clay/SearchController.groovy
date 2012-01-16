package com.clay

class SearchController {

    def tagService
    def searchService

    def index = { }

    def tag = {
        def searchTag = params.tag

        Tag tag = Tag.findByName(searchTag)
        def model = [:]
        if (tag){
            model["designs"] = tagService.findByTag(tag)
        } else {
            model["designs"] = [];
        }
        render(view:"/design/list", model:model)
    }

    def tagById = {
        def searchTagId = params.tagId

        if (!searchTagId){
            throw new RuntimeException("no tag id")
        }

        Tag tag = Tag.get(Long.parseLong(searchTagId))
        def model = [:]
        if (tag){
            model["designs"] = tagService.findByTag(tag)
        } else {
            model["designs"] = []
        }
        render(view:"/design/list", model:model)
    }

    def product = {
        def productName = params.product

        // need some efficient way to search through
        // things thatshare words with the product name
    }

    def productById = {
        def productId = params.productId

        if (!productId){
            throw new RuntimeException("missing product id")
        }

        Product product = Product.get(Long.parseLong(productId))
        def model = [:]
        if (product) {
            model["designs"] = searchService.searchByProduct(product)
        } else {
            model["designs"] = []
        }
        render(view:"/design/list", model:model)

    }

    def userById = {
       def userId = params.userId

        if (!userId){
            throw new RuntimeException("no user id for search")
        }

        ClayUser user = ClayUser.get(Long.parseLong(userId))
        def model = [:]
        if (user){
            model["designs"] = user.designs.find({
                it.saved && !it.deleted
            })
        } else {
            model["designs"] = []
        }

        render(view:"/design/list", model:model)
    }

    def commentsByUserId = {
       def userId = params.userId

        if (!userId){
            throw new RuntimeException("no user id for search")
        }

        ClayUser user = ClayUser.get(Long.parseLong(userId))
        def model = [:]
        if (user){
            model["comments"] = user.comments
        } else {
            model["comments"] = []
        }

        render(view:"/design/userCommentList", model:model)
    }
}
