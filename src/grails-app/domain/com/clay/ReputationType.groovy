package com.clay

class ReputationType {

    String type
    double reputationAmount

    Date lastUpdated
    Date dateCreated

    static constraints = {
        type(unique:true, nullable:false)
    }
}
