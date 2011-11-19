import com.clay.Role
import com.clay.ClayUser
import com.clay.UserRole
import grails.util.GrailsConfig

class BootStrap {

    def userService

    def init = { servletContext ->

        new Role(authority:GrailsConfig.clay.role.admin).save(flush:true)
        new Role(authority:GrailsConfig.clay.role.user).save(flush:true)

        ClayUser user = userService.createUser("clay-admin","moldycheese11","admin@clayonion.com",new Date())
        userService.assignRoleToUser(user, GrailsConfig.clay.role.admin)
        userService.assignRoleToUser(user, GrailsConfig.clay.role.user)
    }
    def destroy = {
    }
}
