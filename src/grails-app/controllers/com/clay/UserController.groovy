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

    def designList = {
        ClayUser u
        if (!params.userId){
            u = (ClayUser) springSecurityService.currentUser
        } else {
            def user = Long.parseLong(params.userId)
            u = ClayUser.get(user)
        }
        def designs = Design.findByUser(u)

        def model = [:]
        model["designs"] = designs

        model
    }

    def settings = {
        ClayUser user = (ClayUser) springSecurityService.currentUser

        def model = [:]
        model["email"] = user.email

        return model
    }

    def saveSettings = {
        String email = params.email
        ClayUser user = (ClayUser) springSecurityService.currentUser
        user.email = email
        user.save(flush:true)
        redirect(controller:"design", action:"list")
    }

    def savePassword = {
        String password = params.password
        ClayUser user = (ClayUser) springSecurityService.currentUser
        user.password = password
        user.save(flush:true)
        redirect(controller:"design", action:"list")
    }
}
