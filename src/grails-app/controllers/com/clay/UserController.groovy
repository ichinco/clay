package com.clay

import org.joda.time.format.DateTimeFormatter
import org.joda.time.format.DateTimeFormat
import grails.util.GrailsConfig

class UserController {

    def springSecurityService
    def userService

    def index = { }

     static allowedMethods = [create: "POST"]

    def create = {
        String username = params.username
        String password = params.password
        String email = params.email
        String birthday = params.birthday
        DateTimeFormatter fmt = DateTimeFormat.forPattern("MM-dd-yyyy");
        Date date = fmt.parseDateTime(birthday).toDate()

        ClayUser user = userService.createUser(username,password,email, date)
        userService.assignRoleToUser(user, GrailsConfig.clay.role.user)

        if (!user.validate()){
            redirect()   //TODO
        } else {
            springSecurityService.reauthenticate(username,password)
            redirect(controller:"design", action:"list")
        }
    }
}
