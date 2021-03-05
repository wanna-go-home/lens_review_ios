//
//  MyReviewViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/05.
//

import Combine

class MyReviewViewModel: ObservableObject
{
    @Published var reviewList = [ReviewBoardPreview]()
    
    var subscription = Set<AnyCancellable>()
    
    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
    func getMyReview()
    {
        LensAPIClient.getMyReview()
            .sink{ response in
                switch response {
                case .success(let reviews):
                    self.reviewList = reviews
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.store(in: &subscription)
    }
}
