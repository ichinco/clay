package com.clay

import org.springframework.security.core.GrantedAuthority

class Role implements GrantedAuthority {

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
