import com.clay.Role
import com.clay.ClayUser
import com.clay.UserRole
import grails.util.GrailsConfig
import com.clay.ReputationType
import com.clay.VoteType
import com.clay.TagType

class BootStrap {

    def userService
    def designService

    def init = { servletContext ->

        new Role(authority:GrailsConfig.clay.role.admin).save(flush:true)
        new Role(authority:GrailsConfig.clay.role.user).save(flush:true)
        new Role(authority:GrailsConfig.clay.role.moderator).save(flush:true)

        ClayUser user = userService.createUser("clay-admin","moldycheese11","admin@clayonion.com",new Date())
        userService.assignRoleToUser(user, GrailsConfig.clay.role.admin)
        userService.assignRoleToUser(user, GrailsConfig.clay.role.user)
        userService.assignRoleToUser(user, GrailsConfig.clay.role.moderator)

        new ReputationType(type:GrailsConfig.clay.reputation.commentUp, reputationAmount:5).save(flush:true)
        new ReputationType(type:GrailsConfig.clay.reputation.commentDown, reputationAmount:10).save(flush:true)
        new ReputationType(type:GrailsConfig.clay.reputation.designUp, reputationAmount:-3).save(flush:true)
        new ReputationType(type:GrailsConfig.clay.reputation.designDown, reputationAmount:-7).save(flush:true)

        new VoteType(name:GrailsConfig.clay.vote.up).save(flush:true)
        new VoteType(name:GrailsConfig.clay.vote.down).save(flush:true)

        new TagType(name:'design').save(flush:true)

        designService.createDesignCache()
    }
    def destroy = {
        File directory = new File("./web-app/designs/");

        File[] files = directory.listFiles();
        for (File file : files)
        {
           if (!file.delete())
           {
               log.error("Failed to delete "+file);
           }
        }
    }
}
