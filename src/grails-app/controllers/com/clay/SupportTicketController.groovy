package com.clay

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class SupportTicketController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [supportTicketInstanceList: SupportTicket.list(params), supportTicketInstanceTotal: SupportTicket.count()]
    }

    def create = {
        def supportTicketInstance = new SupportTicket()
        supportTicketInstance.properties = params
        return [supportTicketInstance: supportTicketInstance]
    }

    def save = {
        def supportTicketInstance = new SupportTicket(params)
        if (supportTicketInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), supportTicketInstance.id])}"
            redirect(action: "show", id: supportTicketInstance.id)
        }
        else {
            render(view: "create", model: [supportTicketInstance: supportTicketInstance])
        }
    }

    def show = {
        def supportTicketInstance = SupportTicket.get(params.id)
        if (!supportTicketInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), params.id])}"
            redirect(action: "list")
        }
        else {
            [supportTicketInstance: supportTicketInstance]
        }
    }

    def edit = {
        def supportTicketInstance = SupportTicket.get(params.id)
        if (!supportTicketInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [supportTicketInstance: supportTicketInstance]
        }
    }

    def update = {
        def supportTicketInstance = SupportTicket.get(params.id)
        if (supportTicketInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (supportTicketInstance.version > version) {
                    
                    supportTicketInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'supportTicket.label', default: 'SupportTicket')] as Object[], "Another user has updated this SupportTicket while you were editing")
                    render(view: "edit", model: [supportTicketInstance: supportTicketInstance])
                    return
                }
            }
            supportTicketInstance.properties = params
            if (!supportTicketInstance.hasErrors() && supportTicketInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), supportTicketInstance.id])}"
                redirect(action: "show", id: supportTicketInstance.id)
            }
            else {
                render(view: "edit", model: [supportTicketInstance: supportTicketInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def supportTicketInstance = SupportTicket.get(params.id)
        if (supportTicketInstance) {
            try {
                supportTicketInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'supportTicket.label', default: 'SupportTicket'), params.id])}"
            redirect(action: "list")
        }
    }
}
