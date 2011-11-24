package com.clay

import grails.util.GrailsConfig

class VoteService {

    static transactional = true

    private VoteType up;
    private VoteType down;

    def commentUp(User user, Comment comment) {
        CommentVote vote = CommentVote.findByUserAndComment(user,comment)
        if (!vote){
            vote = new CommentVote()
            vote.user = user
            vote.comment = comment
        }
        vote.type = up
        vote.save()

        return vote
    }

    def commentDown(User user, Comment comment) {
        CommentVote vote = CommentVote.findByUserAndComment(user,comment)
        if (!vote){
            vote = new CommentVote()
            vote.user = user
            vote.comment = comment
        }
        vote.type = down
        vote.save()

        return vote
    }

    def designUp(User user, Design design){
        DesignVote vote = DesignVote.findByUserAndDesign(user,design)
        if (!vote){
            vote = new DesignVote()
            vote.user = user
            vote.design = design
        }
        vote.type = up
        vote.save()

        return vote
    }

    def designDown(User user, Design design){
        DesignVote vote = DesignVote.findByUserAndDesign(user,design)
        if (!vote){
            vote = new DesignVote()
            vote.user = user
            vote.design = design
        }
        vote.type = up
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
