//
//  MyCommentViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/05.
//

import Combine

class MyCommentViewModel: ObservableObject
{
    @Published var commentList = [Comment]()
    
    var subscription = Set<AnyCancellable>()
    
    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
    func getMyComments()
    {
        LensAPIClient.getMyComments()
            .sink{ response in
                switch response {
                case .success(let comments):
                    self.commentList = comments
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.store(in: &subscription)
    }
}
