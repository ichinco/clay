package com.clay

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_ADMIN'])
class ClayUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [clayUserInstanceList: ClayUser.list(params), clayUserInstanceTotal: ClayUser.count()]
    }

    def create = {
        def clayUserInstance = new ClayUser()
        clayUserInstance.properties = params
        return [clayUserInstance: clayUserInstance]
    }

    def save = {
        def clayUserInstance = new ClayUser(params)
        if (clayUserInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), clayUserInstance.id])}"
            redirect(action: "show", id: clayUserInstance.id)
        }
        else {
            render(view: "create", model: [clayUserInstance: clayUserInstance])
        }
    }

    def show = {
        def clayUserInstance = ClayUser.get(params.id)
        if (!clayUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            [clayUserInstance: clayUserInstance]
        }
    }

    def edit = {
        def clayUserInstance = ClayUser.get(params.id)
        if (!clayUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [clayUserInstance: clayUserInstance]
        }
    }

    def update = {
        def clayUserInstance = ClayUser.get(params.id)
        if (clayUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (clayUserInstance.version > version) {
                    
                    clayUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'clayUser.label', default: 'ClayUser')] as Object[], "Another user has updated this ClayUser while you were editing")
                    render(view: "edit", model: [clayUserInstance: clayUserInstance])
                    return
                }
            }
            clayUserInstance.properties = params
            if (!clayUserInstance.hasErrors() && clayUserInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), clayUserInstance.id])}"
                redirect(action: "show", id: clayUserInstance.id)
            }
            else {
                render(view: "edit", model: [clayUserInstance: clayUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def clayUserInstance = ClayUser.get(params.id)
        if (clayUserInstance) {
            try {
                clayUserInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'clayUser.label', default: 'ClayUser'), params.id])}"
            redirect(action: "list")
        }
    }
}
