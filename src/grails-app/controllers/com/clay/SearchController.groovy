package com.clay

class SearchController {

    def tagService
    def searchService

    def index = { }

    def tag = {
        def searchTag = params.tag

        Tag tag = Tag.findByName(searchTag)
        def model = [:]
        model["designs"] = tagService.findByTag(tag)
        render(view:"design/list", model:model)
    }

    def tagById = {
        def searchTagId = params.tagId

        Tag tag = Tag.get(Long.parseLong(searchTagId))
        def model = [:]
        model["designs"] = tagService.findByTag(tag)
        render(view:"design/list", model:model)
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
        model["designs"] = searchService.searchByProduct(product)
        render(view:"design/list", model:model)

    }
}
