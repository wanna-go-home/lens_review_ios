//
//  ReviewBoardDetailViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/13.
//

import Combine

class ReviewBoardDetailViewModel : ObservableObject
{
    @Published var review = ReviewBoardDetail()
    
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
}
