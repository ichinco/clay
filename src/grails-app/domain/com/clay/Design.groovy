package com.clay

class Design {

    User user

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
