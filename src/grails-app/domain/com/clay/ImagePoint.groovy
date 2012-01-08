package com.clay

class ImagePoint {

    double left
    double top
    double width
    double height
    Product product

    Date lastUpdated
    Date dateCreated

    static belongsTo = [image:Image]

    static constraints = {
    }
}
