package com.clay

class ClayUser extends User {

    Date lastUpdate
    Date dateCreated

    static hasMany = [
            reputationAction : ReputationAction,
            designs : Design,
            comments : Comment
    ]

    static constraints = {
    }
}
