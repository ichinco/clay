package com.clay

class UserSupportTicketController {

    def springSecurityService

    def index = { }

    def create = {
        if (springSecurityService.isLoggedIn()){
            redirect(action:"supportUser", params:[email:springSecurityService.currentUser.email])
        } else {
            redirect(action:"supportGeneral.gsp")
        }
    }

    def supportUser = {
        def model = [:]
        model["email"] = params.email

        model
    }

    def saveUser = {
        String text = params.text
        ClayUser user = (ClayUser) springSecurityService.currentUser

        SupportTicket ticket = new SupportTicket();
        ticket.user = user
        ticket.text = text
        ticket.ticketStatus = "UNANSWERED"
        ticket.save()

        redirect (action:"ticketFiled.gsp")
    }

    def saveGeneral = {
        String text = params.text
        String name = params.name
        String email = params.email

        SupportTicket ticket = new SupportTicket();
        ticket.name = name
        ticket.text = text
        ticket.email = email
        ticket.ticketStatus = "UNANSWERED"
        ticket.save()

        redirect (action:"ticketFiled.gsp")
    }
}
