package com.clay

class Image {

    String url

    Date lastUpdate
    Date dateCreated

    static hasMany = [
            points : ImagePoint
    ]

    static constraints = {
    }
}
