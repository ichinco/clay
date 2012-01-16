package com.clay

class SearchService {

    static transactional = true

    def searchByProduct(Product product) {
        return product.points.collect { it.image.design }.find {
            Design it ->
            it.saved && !it.deleted
        }
    }

    def searchByWord(String word){

    }
}
