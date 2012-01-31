

import com.the6hours.grails.springsecurity.facebook.FacebookUserDomain

import com.clay.User
import org.springframework.security.core.GrantedAuthority

class FacebookUser implements FacebookUserDomain {

	long uid
    String secret
    String session
    String email
    String accessToken

	static belongsTo = [user: User]

	static constraints = {
		uid unique: true
        secret nullable: true
        session nullable: true
        email nullable: true
        accessToken nullable : true
	}
}
