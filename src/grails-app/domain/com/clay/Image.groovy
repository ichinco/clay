package com.clay

class Image {

    String url

    static hasMany = [
            points : ImagePoint
    ]

    static constraints = {
    }
}
