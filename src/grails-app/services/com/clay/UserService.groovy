package com.clay

class UserService {

    def springSecurityService

    static transactional = true

    def createUser(String username, String password, String email, Date birthday) {
        ClayUser user = new ClayUser()
        user.username = username
        user.password = password
        user.email = email
        user.birthday = birthday
        user.accountExpired = false
        user.accountLocked = false
        user.enabled = true
        user.save()

        return user
    }

    def assignRoleToUser(ClayUser user, String role){
        UserRole ur = new UserRole()
        ur.user = user
        ur.role = Role.findByAuthority(role)
        ur.save()
    }
}
