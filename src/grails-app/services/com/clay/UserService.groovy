package com.clay

class UserService {

    def springSecurityService
    static scope = "singleton"

    static transactional = true

    def synchronized createUser(String username, String password, String email, Date birthday) {
        ClayUser existingUser = ClayUser.findByUsername(username)

        if (existingUser) {
            return null
        }
        ClayUser user = new ClayUser()
        user.username = username
        user.password = password
        user.email = email
        user.birthday = birthday
        user.accountExpired = false
        user.accountLocked = false
        user.enabled = true
        user.save()

        if (!user.validate()){
            throw new RuntimeException(user.errors.toString())
        }

        return user
    }

    def assignRoleToUser(ClayUser user, String role){
        UserRole ur = new UserRole()
        ur.user = user
        ur.role = Role.findByAuthority(role)
        ur.save()

        if (!ur.validate()){
            throw new RuntimeException(ur.errors.toString())
        }
    }
}
