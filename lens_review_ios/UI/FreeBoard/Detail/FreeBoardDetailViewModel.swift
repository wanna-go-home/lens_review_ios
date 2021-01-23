//
//  FreeBoardDetailViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/06.
//

import Combine

class FreeBoardDetailViewModel : ObservableObject
{
    @Published var article = FreeBoardDetail()
    @Published var commentList = [FreeBoardComment]()
    @Published var deleteSuccess = false
    let writeCommentSuccess = PassthroughSubject<Bool, Never>()
    
    func getFreeBoardDetail(id: Int)
    {
        LensAPIClient.getFreeBoardDetail(articleId: id){ result in
            switch result {
            case .success(let article_):
                self.article = article_
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
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
    
    func delArticle(articleId: Int)
    {
        LensAPIClient.deleteArticle(id: articleId){ result in
            switch result {
            case .success:
                self.deleteSuccess = true
            case .failure(let error):
                self.deleteSuccess = false
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
}
