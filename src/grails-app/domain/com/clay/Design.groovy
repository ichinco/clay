package com.clay

class Design {

    ClayUser user
    boolean deleted // TODO do not show deleted designs

    Date lastUpdated
    Date dateCreated

    static hasMany = [
            images : Image,
            comments : Comment,
            votes : Vote,
            tags : Tag,
            products : Product
    ]

    static mapping = {
        tablePerHierarchy false
    }
    static constraints = {
    }
}
