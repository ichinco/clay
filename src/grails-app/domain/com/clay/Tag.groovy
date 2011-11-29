package com.clay

class Tag {

    TagType type
    String name

    Date lastUpdated
    Date dateCreated

    static constraints = {
        name(unique: 'type', nullable:false)
    }
}
