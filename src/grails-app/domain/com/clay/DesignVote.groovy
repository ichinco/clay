package com.clay

class DesignVote extends Vote {

    Design design

    static constraints = {
        design(unique:'user', nullable:false)
    }

    static mapping = {
        discriminator "design"
    }
}
