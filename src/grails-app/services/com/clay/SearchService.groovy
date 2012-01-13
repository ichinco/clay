package com.clay

class SearchService {

    static transactional = true

    def searchByProduct(Product product) {
        return product.points.collect { it.image.design }
    }

    def searchByWord(String word){

    }
}
