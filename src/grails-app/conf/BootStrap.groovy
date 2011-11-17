import com.clay.Role

class BootStrap {

    def init = { servletContext ->

        Role role = new Role()
        role.authority = "ROLE_USER"
        role.save()

        Role role2 = new Role()
        role2.authority = "ROLE_ADMIN"
        role2.save()
    }
    def destroy = {
    }
}
