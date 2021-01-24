//
//  CommentViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/21.
//

import Combine

class CommentViewModel : ObservableObject
{
    @Published var commentList = [FreeBoardComment]()
    let writeCommentSuccess = PassthroughSubject<Int, Never>()
    let deleteCommentSuccess = PassthroughSubject<Bool, Never>()
    let modifyCommentSuccess = PassthroughSubject<Bool, Never>()

    func getCommentList(id: Int)
    {
        LensAPIClient.getFreeBoardComment(articleId: id){ result in
            switch result {
            case .success(let comments_):
                self.commentList = comments_
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getAllComments(articleId: Int, commentId: Int)
    {
        LensAPIClient.getFreeBoardAllComments(articleId: articleId, commentId: commentId){ result in
            switch result {
            case .success(let comments_):
                self.commentList = comments_
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func writeComment(articleId: Int, content: String, bundleId: Int? = nil)
    {
        LensAPIClient.postArticleComment(articleId: articleId, bundleId: bundleId, content: content){ result in
            switch result {
            case .success:
                if bundleId == nil
                {
                    self.writeCommentSuccess.send(CommentWriteResult.parentSuccess)
                }else
                {
                    self.writeCommentSuccess.send(CommentWriteResult.childSuccess)
                }
            case .failure(let error):
                self.writeCommentSuccess.send(CommentWriteResult.failure)
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteComment(postId: Int, commentId: Int)
    {
        LensAPIClient.deleteArticleComment(articleId: postId, commentId: commentId){ result in
            switch result {
            case .success:
                self.deleteCommentSuccess.send(true)
            case .failure(let error):
                self.deleteCommentSuccess.send(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func modifyComment(postId: Int, commentId: Int, comment: String)
    {
        LensAPIClient.putArticleComment(articleId: postId, commentId: commentId, content: comment){ result in
            switch result {
            case .success:
                self.modifyCommentSuccess.send(true)
            case .failure(let error):
                self.modifyCommentSuccess.send(false)
                print(error.localizedDescription)
            }
        }
    }
}
