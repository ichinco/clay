package com.facebook

import grails.util.GrailsConfig
import grails.plugins.springsecurity.Secured
import com.clay.ClayUser
import org.joda.time.format.DateTimeFormatter

class FacebookController {

    def index = { }
    def facebookService
    def springSecurityService

    @Secured(['ROLE_ADMIN'])
    def refreshUrls = {
        facebookService.refreshFacebookConfig()
    }

    def displayFacebookLogin = {
        redirect(url:facebookService.getFacebookLoginUrl())
    }


    def login = {
        def code = params.code
        String error = params.error
        if (code){
            def facebookInfo = facebookService.getUser(code)
            ClayUser user = ClayUser.findByFacebookId(facebookInfo["id"])
            if (user){

            } else {
                String username = facebookInfo["name"]
                String password = UUID.randomUUID()
                String email = facebookInfo["email"]
                String birthday = facebookInfo["birthday"]
                DateTimeFormatter fmt = DateTimeFormat.forPattern("MM-dd-yyyy");
                Date date = fmt.parseDateTime(birthday).toDate()
            }

        } else if (error) {
            String errorReason = params.error_reason
            String errorDescription = params.error_description
        }
    }

    def friends = {

    }
}
