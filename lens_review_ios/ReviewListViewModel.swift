//
//  ReviewListViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/17.
//

import Combine

class ReviewListViewModel: ObservableObject
{
    @Published var reviewList = [ReviewBoardPreview]()

    init(review: [ReviewBoardPreview] = [])
    {
        getReviewList()
    }

    func getReviewList()
    {
        LensAPIClient.getReviewBoardPreview {result in
            switch result{
            case .success(let review_):
                self.reviewList.append(contentsOf: review_)
                print(review_)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
