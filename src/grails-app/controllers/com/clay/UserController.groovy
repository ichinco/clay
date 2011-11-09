package com.clay

class UserController {

    def index = { }

    def create = {
        String username = params.username
        String password = params.password

        ClayUser user = new ClayUser()
        user.username = username
        user.password = password
        user.accountExpired = false
        user.accountLocked = false
        user.enabled = true
        user.save()

        if (!user.validate()){
            redirect()
        } else {
            redirect(controller:"login", action:"auth")
        }
    }
}
