package com.clay

class Role {

	String authority

    Date lastUpdated
    Date dateCreated

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
