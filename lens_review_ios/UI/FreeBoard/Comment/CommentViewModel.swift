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
}
