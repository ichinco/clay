package com.clay

class CommentVote extends Vote {

    Comment comment

    static constraints = {
        comment(unique:'user', nullable:false)
    }

    static mapping = {
        discriminator "comment"
    }
}
