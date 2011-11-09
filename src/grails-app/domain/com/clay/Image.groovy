package com.clay

class Image {

    String url

    Date lastUpdated
    Date dateCreated

    static hasMany = [
            points : ImagePoint
    ]

    static constraints = {
    }
}
