//
//  ReviewModifyViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/04/02.
//

import Combine

class ReviewModifyViewModel : ObservableObject
{
    var subscription = Set<AnyCancellable>()
    let reviewModifySuccess = PassthroughSubject<Bool, Never>()
    
    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
    func putReview(reviewId: Int, title: String, content: String, lensId: Int)
    {
        LensAPIClient.putReview(reviewId: reviewId, title: title, content: content, lensId: lensId)
            .sink { response in
                switch response {
                case .success:
                    self.reviewModifySuccess.send(true)
                case .failure:
                    self.reviewModifySuccess.send(false)
                }
            }
            .store(in: &subscription)
    }
}
