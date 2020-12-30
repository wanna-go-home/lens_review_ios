//
//  ArticleModifyViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/27.
//

import Combine

class ArticleModifyViewModel : ObservableObject
{
    @Published var modifySuccess = false
    
    func putArticle(articleId: Int, title: String, content: String)
    {
        LensAPIClient.putArticle(id: articleId, title: title, content: content){ result in
            switch result {
            case .success:
                self.modifySuccess = true
            case .failure(let error):
                self.modifySuccess = false
                print(error.localizedDescription)
            }
        }
    }
}
