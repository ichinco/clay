package com.clay

class Tag {

    TagType type
    String name

    Date lastUpdated
    Date dateCreated

    static belongsTo = Design

    static hasMany = [
            designs : Design
    ]

    static constraints = {
        name(unique: 'type', nullable:false)
    }
}
