package src

class UserLoginFilterFilters {

    def springSecurityService

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                if (springSecurityService.currentUser){
                    request.signedIn = true
                    request.username = springSecurityService.currentUser.username
                }
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
    
}
