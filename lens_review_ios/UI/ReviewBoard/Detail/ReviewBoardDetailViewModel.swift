//
//  ReviewBoardDetailViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/13.
//

import Combine

class ReviewBoardDetailViewModel : ObservableObject
{
    var subscription = Set<AnyCancellable>()
    let reviewDeleteSuccess = PassthroughSubject<Bool, Never>()
    @Published var review = ReviewBoardDetail()

    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
    func getReviewBoardDetail(id: Int)
    {
        LensAPIClient.getReviewBoardDetail(reviewId: id){ result in
            switch result {
            case .success(let review_):
                self.review = review_
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func delReview(reviewId: Int)
    {
        LensAPIClient.deleteReview(reviewId: reviewId)
            .sink { response in
                switch response {
                case .success:
                    self.reviewDeleteSuccess.send(true)
                case .failure:
                    self.reviewDeleteSuccess.send(false)
                }
            }
            .store(in: &subscription)
    }
}
