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
    let writeCommentSuccess = PassthroughSubject<Bool, Never>()
    let deleteCommentSuccess = PassthroughSubject<Bool, Never>()

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
    
    func writeComment(articleId: Int, content: String)
    {
        LensAPIClient.postArticleComment(articleId: articleId, content: content){ result in
            switch result {
            case .success:
                self.writeCommentSuccess.send(true)
            case .failure(let error):
                self.writeCommentSuccess.send(false)
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
}
