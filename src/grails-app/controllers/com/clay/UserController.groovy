package com.clay

class UserController {

    def springSecurityService

    def index = { }

    def create = {
        String username = params.username
        String password = params.password

        ClayUser user = new ClayUser()
        user.username = username
        user.password = springSecurityService.encodePassword(password)
        user.accountExpired = false
        user.accountLocked = false
        user.enabled = true
        user.save()

        if (!user.validate()){
            redirect()   //TODO
        } else {
            springSecurityService.reauthenticate(username,password)
            redirect(controller:"design", action:"list")
        }
    }
}
