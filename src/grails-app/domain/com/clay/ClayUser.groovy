package com.clay

class ClayUser extends User {

    Date lastUpdated
    Date dateCreated
    Date birthday
    String email

    static hasMany = [
            reputationAction : ReputationAction,
            designs : Design,
            comments : Comment
    ]

    static constraints = {
        email(unique:true, nullable:false)
    }
}
