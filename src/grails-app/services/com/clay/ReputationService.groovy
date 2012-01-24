package com.clay

import grails.util.GrailsConfig

class ReputationService {

    static transactional = true

    private ReputationType commentUp
    private ReputationType commentDown
    private ReputationType designUp
    private ReputationType designDown

    def awardPoints(User user, ReputationType type, Vote vote){
        ReputationAction action = new ReputationAction()
        action.user = user
        action.type = type
        action.vote = vote
        action.save()

        if (!action.validate()){
            throw new RuntimeException(action.errors.toString())
        }
    }

    def awardPointsForCommentUpvote(User user, Vote vote) {
        awardPoints(user, commentUp, vote)
    }

    def awardPointsForCommentDownvote(User user, Vote vote){
        awardPoints(user, commentDown, vote)
    }

    def awardPointsForDesignUpvote(User user, Vote vote){
        awardPoints(user, designUp, vote)
    }

    def awardPointsForDesignDownvote(User user, Vote vote){
        awardPoints(user, designDown, vote)
    }

    def refreshCache(){
        commentUp = ReputationType.findByType(GrailsConfig.clay.reputation.commentUp)
        commentDown = ReputationType.findByType(GrailsConfig.clay.reputation.commentDown)
        designUp = ReputationType.findByType(GrailsConfig.clay.reputation.designUp)
        designDown = ReputationType.findByType(GrailsConfig.clay.reputation.designDown)
    }

    ReputationService(){
        refreshCache()
    }
}
