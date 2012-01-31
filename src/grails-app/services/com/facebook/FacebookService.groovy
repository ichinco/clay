package com.facebook

import grails.util.GrailsConfig
import com.clay.ClayUser

class FacebookService {

    static transactional = true

    private static String FACEBOOK_LOGIN;
    private static String FACEBOOK_AUTH;
    private static String FACEBOOK_SHARE;
    private static String FACEBOOK_USER;
    private static String FACEBOOK_FRIENDS;

    String getAccessToken(String code){
        def url = new URL (getFacebookAuthUrl(code))
        def conn = url.openConnection()
        conn.setRequestMethod("GET")
        conn.doOutput = true
        conn.connect()
        return conn.content.text.access_token
    }

    Map<String,String> getUser(String id, String accessToken){
        def url = new URL (getFacebookUserUrl(id, accessToken))
        def conn = url.openConnection()
        conn.setRequestMethod("GET")
        conn.doOutput = true
        conn.connect()

        def facebookMap = [:]
        facebookMap["id"] = conn.content.text.id
        facebookMap["email"] = conn.content.text.email
        facebookMap["birthday"] = conn.content.text.birthday
        facebookMap["name"] = conn.content.text.name

        return facebookMap
    }

    Map<String,String> getUser(String code){
        String accessToken = getAccessToken(code)
        return getUser(id, accessToken)
    }

    List<String> getFriends(String id, String accessToken) {
        def url = new URL (getFacebookFriendsUrl(id, accessToken))
        def conn = url.openConnection()
        conn.setRequestMethod("GET")
        conn.doOutput = true
        conn.connect()
        return conn.content.data.collect {
            it.id
        }
    }

    def getFacebookLoginUrl() {
        return FACEBOOK_LOGIN;
    }

    def getFacebookAuthUrl(String code){
        return FACEBOOK_AUTH.replace("[CODE]", code)
    }

    def getFacebookShareUrl(String id, String access){
        return FACEBOOK_SHARE.replace("[ID]", id)
                             .replace("[ACCESS]", access);
    }

    def getFacebookUserUrl(String id, String access){
        return FACEBOOK_USER.replace("[ID]", id)
                             .replace("[ACCESS]", access);
    }

    def getFacebookFriendsUrl(String id, String access){
        return FACEBOOK_FRIENDS.replace("[ID]", id)
                             .replace("[ACCESS]", access);
    }

    def refreshFacebookConfig(){
        String appId = GrailsConfig.clay.facebook.appId;
        String redirectUrl = GrailsConfig.clay.facebook.redirectUrl;
        String facebookLoginUrl = GrailsConfig.clay.facebook.login;
        String facebookAuthUrl = GrailsConfig.clay.facebook.authentication;
        String secret = GrailsConfig.clay.facebook.secret
        String shareUrl = GrailsConfig.clay.facebook.share
        FACEBOOK_LOGIN = facebookLoginUrl.replace("[APPID]", appId)
                                         .replace("[REDIRECTURL", redirectUrl);

        FACEBOOK_AUTH = facebookAuthUrl.replace("[APPID]", appId)
                                       .replace("[SECRET]", secret)
                                       .replace("[REDIRECTURL]", redirectUrl)

        FACEBOOK_SHARE = shareUrl.replace("[APPID]", appId)
                                 .replace("[REDIRECTURL]", redirectUrl)

        FACEBOOK_USER = GrailsConfig.clay.facebook.user
        FACEBOOK_FRIENDS = GrailsConfig.clay.facebook.friends
    }

    FacebookService(){
       refreshFacebookConfig()
    }
}
