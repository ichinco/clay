package src

import com.clay.ClayUser

class ClickstreamFilters {

    def clickstreamService
    def springSecurityService

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                request["start"] = new Date().time
            }
            after = {
                request["controllerEnd"] = new Date().time
            }
            afterView = {
                request["viewEnd"] = new Date().time
                def user = springSecurityService.currentUser
                def id = null
                if (user) {
                    id = ((ClayUser) user).id
                }

                clickstreamService.writeRequest(id, request, response)
            }
        }
    }
    
}
