package com.clay

import grails.util.GrailsConfig

class VoteService {

    static transactional = true

    private VoteType up;
    private VoteType down;

    def commentUp(User user, Comment comment) {
        CommentVote vote = new CommentVote()
        vote.user = user
        vote.type = up
        vote.comment = comment
        vote.save()

        return vote
    }

    def commentDown(User user, Comment comment) {
        CommentVote vote = new CommentVote()
        vote.user = user
        vote.type = down
        vote.comment = comment
        vote.save()

        return vote
    }

    def designUp(User user, Design design){
        DesignVote vote = new DesignVote()
        vote.user = user
        vote.type = up
        vote.design = design
        vote.save()

        return vote
    }

    def designDown(User user, Design design){
        DesignVote vote = new DesignVote()
        vote.user = user
        vote.type = up
        vote.design = design
        vote.save()

        return vote
    }

    def refreshCache(){
        up = VoteType.findByName(GrailsConfig.clay.vote.up)
        down = VoteType.findByName(GrailsConfig.clay.vote.down)
    }

    def VoteService(){
        refreshCache()
    }
}
