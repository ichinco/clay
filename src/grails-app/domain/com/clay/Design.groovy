package com.clay

class Design {

    String description
    String title
    ClayUser user
    boolean deleted // TODO do not show deleted designs
    boolean saved = false

    Date lastUpdated
    Date dateCreated

    static hasMany = [
            images : Image,
            comments : Comment,
            votes : Vote,
            tags : Tag,
    ]

    static mapping = {
        tablePerHierarchy false
        images cascade:"save-update"
        tags cascade: "save-update"
    }
    static constraints = {
        title nullable: true
        description nullable: true
    }
}
