package com.clay

class ClayUser extends User {

    Date lastUpdated
    Date dateCreated

    static hasMany = [
            reputationAction : ReputationAction,
            designs : Design,
            comments : Comment
    ]

    static constraints = {
    }
}
