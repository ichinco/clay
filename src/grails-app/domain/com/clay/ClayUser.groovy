package com.clay

class ClayUser extends User {

    static hasMany = [
            reputationAction : ReputationAction,
            designs : Design,
            comments : Comment
    ]

    static constraints = {
    }
}
