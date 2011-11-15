package com.clay

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class VoteTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [voteTypeInstanceList: VoteType.list(params), voteTypeInstanceTotal: VoteType.count()]
    }

    def create = {
        def voteTypeInstance = new VoteType()
        voteTypeInstance.properties = params
        return [voteTypeInstance: voteTypeInstance]
    }

    def save = {
        def voteTypeInstance = new VoteType(params)
        if (voteTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'voteType.label', default: 'VoteType'), voteTypeInstance.id])}"
            redirect(action: "show", id: voteTypeInstance.id)
        }
        else {
            render(view: "create", model: [voteTypeInstance: voteTypeInstance])
        }
    }

    def show = {
        def voteTypeInstance = VoteType.get(params.id)
        if (!voteTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voteType.label', default: 'VoteType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [voteTypeInstance: voteTypeInstance]
        }
    }

    def edit = {
        def voteTypeInstance = VoteType.get(params.id)
        if (!voteTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voteType.label', default: 'VoteType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [voteTypeInstance: voteTypeInstance]
        }
    }

    def update = {
        def voteTypeInstance = VoteType.get(params.id)
        if (voteTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (voteTypeInstance.version > version) {
                    
                    voteTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'voteType.label', default: 'VoteType')] as Object[], "Another user has updated this VoteType while you were editing")
                    render(view: "edit", model: [voteTypeInstance: voteTypeInstance])
                    return
                }
            }
            voteTypeInstance.properties = params
            if (!voteTypeInstance.hasErrors() && voteTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'voteType.label', default: 'VoteType'), voteTypeInstance.id])}"
                redirect(action: "show", id: voteTypeInstance.id)
            }
            else {
                render(view: "edit", model: [voteTypeInstance: voteTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voteType.label', default: 'VoteType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def voteTypeInstance = VoteType.get(params.id)
        if (voteTypeInstance) {
            try {
                voteTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'voteType.label', default: 'VoteType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'voteType.label', default: 'VoteType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'voteType.label', default: 'VoteType'), params.id])}"
            redirect(action: "list")
        }
    }
}
