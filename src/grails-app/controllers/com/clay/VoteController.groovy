package com.clay

import grails.plugins.springsecurity.Secured

@Secured(['ROLE_USER'])
class VoteController {

    def reputationService
    def voteService
    def springSecurityService

    def index = { }

    def upvoteComment = {
        def commentId = params.commentId
        User user = (User) springSecurityService.currentUser
        Comment comment = Comment.get(Long.parseLong(commentId))

        Vote vote = voteService.commentUp(user,comment)

        reputationService.awardPointsForCommentUpvote(comment.user,vote)
    }

    def downvoteComment = {
        def commentId = params.commentId
        User user = (User) springSecurityService.currentUser
        Comment comment = Comment.get(Long.parseLong(commentId))

        Vote vote = voteService.commentDown(user, comment)

        reputationService.awardPointsForCommentDownvote(comment.user,vote)
    }

    def upvoteDesign = {
        def designId = params.designId
        User user = (User) springSecurityService.currentUser
        Design design = Design.get(Long.parseLong(designId))

        Vote vote = voteService.designUp(user, design)

        reputationService.awardPointsForCommentUpvote(design.user,vote)
    }

    def downvoteDesign = {
        def designId = params.designId
        User user = (User) springSecurityService.currentUser
        Design design = Design.get(Long.parseLong(designId))

        Vote vote = voteService.designDown(user,design)

        reputationService.awardPointsForCommentUpvote(design.user,vote)
    }
}
