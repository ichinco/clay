package com.clay

class Comment {

    Comment parent
    String text
    User user
    boolean deleted // todo do not show deleted comments

    Date lastUpdated
    Date dateCreated

    static constraints = {
    }
}
