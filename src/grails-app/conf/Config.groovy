// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
    }
    development {
        grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
        grails.serverURL = "http://localhost:8080/${appName}"
    }

}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console
    // appender:
    //
    //appenders {
    //    console name:'stdout', layout:pattern(conversionPattern: '%c{2} %m%n')
    //}

    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
           'org.codehaus.groovy.grails.web.pages', //  GSP
           'org.codehaus.groovy.grails.web.sitemesh', //  layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping', // URL mapping
           'org.codehaus.groovy.grails.commons', // core / classloading
           'org.codehaus.groovy.grails.plugins', // plugins
           'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'

    warn   'org.mortbay.log'
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.clay.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.clay.UserRole'
grails.plugins.springsecurity.authority.className = 'com.clay.Role'

grails.views.javascript.library="jquery"

grails.plugins.springsecurity.bcrypt.logrounds = 10 // configure workfactor for bcrypt

clay.design.localImageRoot = 'web-app/'
clay.design.localImageStore = 'designs/'
clay.role.admin = "ROLE_ADMIN"
clay.role.user = "ROLE_USER"
clay.role.moderator = "ROLE_MODERATOR"

clay.reputation.commentUp = "COMMENT_UP"
clay.reputation.commentDown = "COMMENT_DOWN"
clay.reputation.designUp = "DESIGN_UP"
clay.reputation.designDown = "DESIGN_DOWN"

clay.vote.up = "UP"
clay.vote.down = "DOWN"

clay.facebook.appId = "315482448486796"
clay.facebook.secret = "26c78b6e258e86979afc15a8a571d580"
clay.facebook.redirectUrl = "http://localhost:8080/src/facebook/login"
clay.facebook.login = "https://www.facebook.com/dialog/oauth?client_id=[APPID]&redirect_uri=[REDIRECTURL]"
clay.facebook.authentication = "https://graph.facebook.com/oauth/access_token?client_id=[APPID]&redirect_uri=[REDIRECTURL]&client_secret=[SECRET]&code=[CODE]"
clay.facebook.share = "http://www.facebook.com/dialog/feed?app_id=[APPID]&redirect_uri=[REDIRECTURL]&display=popup"
clay.facebook.user = "https://graph.facebook.com/[ID]?access_token=[ACCESS]&fields=id,name,email,birthday"
clay.facebook.friends = "https://graph.facebook.com/[ID]/friends?access_token=[ACCESS]"

grails.plugins.springsecurity.facebook.appId='315482448486796'
grails.plugins.springsecurity.facebook.secret='26c78b6e258e86979afc15a8a571d580'
grails.plugins.springsecurity.facebook.bean.dao='facebookAuthDaoImpl'

grails.plugins.springsocial.facebook.clientId='315482448486796'
grails.plugins.springsocial.facebook.clientSecret='26c78b6e258e86979afc15a8a571d580'
