package com.clay

class TagType {

    String name

    Date lastUpdated
    Date dateCreated

    static constraints = {
        name(unique:true, nullable:false)
    }
}
