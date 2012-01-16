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

        Product product = Product.get(Long.parseLong(productId))
        def model = [:]
        if (product) {
            model["designs"] = searchService.searchByProduct(product)
        } else {
            model["designs"] = []
        }
        render(view:"/design/list", model:model)

    }
}
