package com.clay

class VoteType {

    String name

    Date lastUpdated
    Date dateCreated

    static constraints = {
        name(unique:true, nullable:false)
    }
}
