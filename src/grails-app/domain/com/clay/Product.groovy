package com.clay

class Product {

    String name
    String url

    Date lastUpdated
    Date dateCreated

    static hasMany = [
            points : ImagePoint
    ]

    static constraints = {
    }
}
