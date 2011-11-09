package com.clay

class Role {

	String authority

    Date lastUpdate
    Date dateCreated

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
