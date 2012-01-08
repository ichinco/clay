package com.clay

class Image {

    String url

    Date lastUpdated
    Date dateCreated

    static belongsTo = [design:Design]

    static hasMany = [
            points : ImagePoint
    ]

    static constraints = {
    }
}
