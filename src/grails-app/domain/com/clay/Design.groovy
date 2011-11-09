package com.clay

class Design {

    ClayUser user
    String description
    String title

    static hasMany = [
            images : Image,
            comments : Comment,
            votes : Vote,
            tags : Tag,
            products : Product
    ]

    static constraints = {
    }
}
