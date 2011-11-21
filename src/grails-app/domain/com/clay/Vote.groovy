package com.clay

class Vote {

    User user
    VoteType type

    Date lastUpdated
    Date dateCreated

    static constraints = {
    }

    static mapping = {
        tablePerHierarchy false
    }
}
