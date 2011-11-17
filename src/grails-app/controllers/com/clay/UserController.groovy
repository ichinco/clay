package com.clay

import org.joda.time.format.DateTimeFormatter
import org.joda.time.format.DateTimeFormat

class UserController {

    def springSecurityService

    def index = { }

     static allowedMethods = [create: "POST"]

    def create = {
        String username = params.username
        String password = params.password
        String email = params.email
        String birthday = params.birthday
        DateTimeFormatter fmt = DateTimeFormat.forPattern("MM-dd-yyyy");
        Date date = fmt.parseDateTime(birthday).toDate()

        Role role = Role.findByAuthority('ROLE_USER')

        ClayUser user = new ClayUser()
        user.username = username
        user.password = springSecurityService.encodePassword(password)
        user.email = email
        user.birthday = date
        user.accountExpired = false
        user.accountLocked = false
        user.enabled = true
        user.save()

        UserRole ur = new UserRole()
        ur.user = user
        ur.role = role
        ur.save()

        if (!user.validate()){
            redirect()   //TODO
        } else {
            springSecurityService.reauthenticate(username,password)
            redirect(controller:"design", action:"list")
        }
    }
}
