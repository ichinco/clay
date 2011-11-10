package com.clay

class ReputationTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [reputationTypeInstanceList: ReputationType.list(params), reputationTypeInstanceTotal: ReputationType.count()]
    }

    def create = {
        def reputationTypeInstance = new ReputationType()
        reputationTypeInstance.properties = params
        return [reputationTypeInstance: reputationTypeInstance]
    }

    def save = {
        def reputationTypeInstance = new ReputationType(params)
        if (reputationTypeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), reputationTypeInstance.id])}"
            redirect(action: "show", id: reputationTypeInstance.id)
        }
        else {
            render(view: "create", model: [reputationTypeInstance: reputationTypeInstance])
        }
    }

    def show = {
        def reputationTypeInstance = ReputationType.get(params.id)
        if (!reputationTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), params.id])}"
            redirect(action: "list")
        }
        else {
            [reputationTypeInstance: reputationTypeInstance]
        }
    }

    def edit = {
        def reputationTypeInstance = ReputationType.get(params.id)
        if (!reputationTypeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [reputationTypeInstance: reputationTypeInstance]
        }
    }

    def update = {
        def reputationTypeInstance = ReputationType.get(params.id)
        if (reputationTypeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (reputationTypeInstance.version > version) {
                    
                    reputationTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'reputationType.label', default: 'ReputationType')] as Object[], "Another user has updated this ReputationType while you were editing")
                    render(view: "edit", model: [reputationTypeInstance: reputationTypeInstance])
                    return
                }
            }
            reputationTypeInstance.properties = params
            if (!reputationTypeInstance.hasErrors() && reputationTypeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), reputationTypeInstance.id])}"
                redirect(action: "show", id: reputationTypeInstance.id)
            }
            else {
                render(view: "edit", model: [reputationTypeInstance: reputationTypeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def reputationTypeInstance = ReputationType.get(params.id)
        if (reputationTypeInstance) {
            try {
                reputationTypeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'reputationType.label', default: 'ReputationType'), params.id])}"
            redirect(action: "list")
        }
    }
}
