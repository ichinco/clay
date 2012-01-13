package com.clay

class SavedDesign extends Design {
    String description
    String title

    static constraints = {
        description nullable: true
    }
}
