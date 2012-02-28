package com.clay

class ClickstreamService {

    static transactional = true

    def writeUserAction(String type, obj) {

    }

    def writeRequest(Long userId, request, response){
        def remoteAddr = request.getRemoteAddr()
        def forwardedFor = request.getHeader("X-Forwarded-For")
        def ip = request.getHeader("Client-IP")
        def clientIp = remoteAddr
        if (!clientIp){
            clientIp = forwardedFor
        }
        if (!clientIp) {
            clientIp = ip
        }

        def requestLog = [:]
        requestLog.sessionId = request.requestedSessionId
        requestLog.userId = userId
        requestLog.request = request.requestURI + "?" + request.queryString
        requestLog.userAgent = request.getHeader("User-Agent")
        requestLog.ip = clientIp
        requestLog.ttc = request["controllerEnd"] - request["start"]
        requestLog.ttv = request["viewEnd"] - request["controllerEnd"]
        requestLog.size = response.bufferSize
        requestLog.referrer = request.getHeader("referrer")
        requestLog.time = new Date()

        writeUserAction("REQUEST", requestLog)
    }
}
