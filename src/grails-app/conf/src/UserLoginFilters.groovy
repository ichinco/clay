package src

class UserLoginFilters {

    def userService

    def filters = {
        all(controller:'*', action:'*') {
            before = {
                userService.setUserDataInRequest(request)
            }
            after = {
                
            }
            afterView = {
                
            }
        }
    }
    
}
