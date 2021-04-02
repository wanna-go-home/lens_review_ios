//
//  ReviewCommentViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/04/03.
//

import Combine

class ReviewCommentViewModel : ObservableObject
{
    var subscription = Set<AnyCancellable>()
    let writeCommentSuccess = PassthroughSubject<Int, Never>()
    let deleteCommentSuccess = PassthroughSubject<Int, Never>()
    let modifyCommentSuccess = PassthroughSubject<Int, Never>()
    @Published var commentList = [Comment]()
    
    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }


    func getCommentList(id: Int)
    {
        LensAPIClient.getReviewComment(reviewId: id)
            .sink { response in
                switch response {
                case .success(let comments_):
                    self.commentList = comments_
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &subscription)
    }
    
    func getAllComments(reviewId: Int, commentId: Int)
    {
        LensAPIClient.getReviewAllComments(reviewId: reviewId, commentId: commentId)
            .sink { response in
                switch response {
                case .success(let comments_):
                    self.commentList = comments_
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .store(in: &subscription)
    }
    
    func writeComment(reviewId: Int, content: String, bundleId: Int? = nil)
    {
        LensAPIClient.postReviewComment(reviewId: reviewId, bundleId: bundleId, content: content)
            .sink { response in
                switch response {
                case .success:
                    if bundleId == nil
                    {
                        self.writeCommentSuccess.send(CommentRequestResult.parentSuccess)
                    }else
                    {
                        self.writeCommentSuccess.send(CommentRequestResult.childSuccess)
                    }
                case .failure(let error):
                    self.writeCommentSuccess.send(CommentRequestResult.failure)
                    print(error.localizedDescription)
                }
            }
            .store(in: &subscription)
    }
    
    func deleteComment(postId: Int, commentId: Int, isChildComment: Bool = false)
    {
        LensAPIClient.deleteReviewComment(reviewId: postId, commentId: commentId)
            .sink{ response in
                switch response {
                case .success:
                    if !isChildComment
                    {
                        self.deleteCommentSuccess.send(CommentRequestResult.parentSuccess)
                    }else
                    {
                        self.deleteCommentSuccess.send(CommentRequestResult.childSuccess)
                    }
                case .failure(let error):
                    self.deleteCommentSuccess.send(CommentRequestResult.failure)
                    print(error.localizedDescription)
                }
            }
            .store(in: &subscription)
    }
    
    func modifyComment(postId: Int, commentId: Int, comment: String, bundleId: Int? = nil)
    {
        LensAPIClient.putReviewComment(reviewId: postId, commentId: commentId, bundleId: bundleId, content: comment)
            .sink { response in
                switch response {
                case .success:
                    if bundleId == nil
                    {
                        self.modifyCommentSuccess.send(CommentRequestResult.parentSuccess)
                    }else
                    {
                        self.modifyCommentSuccess.send(CommentRequestResult.childSuccess)
                    }
                case .failure(let error):
                    self.modifyCommentSuccess.send(CommentRequestResult.failure)
                    print(error.localizedDescription)
                }
            }
            .store(in: &subscription)
    }
}
