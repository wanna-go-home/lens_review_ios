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
    @Published var deleteSuccess = false
    
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
}
