//
//  MyArticleViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/02/18.
//

import Combine

class MyArticleViewModel: ObservableObject
{
    @Published var articleList = [FreeBoardPreview]()
    
    var subscription = Set<AnyCancellable>()
    
    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
    func getMyArticle()
    {
        LensAPIClient.getMyArticle()
            .sink{ response in
                switch response {
                case .success(let articles):
                    self.articleList = articles
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.store(in: &subscription)
    }
}

