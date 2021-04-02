//
//  WriteReviewViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/28.
//

import Combine

class ReviewWriteViewModel : ObservableObject
{
    var subscription = Set<AnyCancellable>()
    let reviewPostSuccess = PassthroughSubject<Bool, Never>()
    let reviewPostSuccessForSelect = PassthroughSubject<Bool, Never>()
    @Published var lensList = [LensPreview]()   

    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
    func getLensList()
    {
        LensAPIClient.getLensesPreview {result in
            switch result{
            case .success(let lens_):
                self.lensList = lens_
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func postArticle(title: String, content: String, lensId: Int)
    {
        LensAPIClient.postReview(title: title, content: content, lensId: lensId)
            .sink{ response in
                switch response {
                case .success:
                    self.reviewPostSuccess.send(true)
                    self.reviewPostSuccessForSelect.send(true)
                case .failure:
                    self.reviewPostSuccess.send(false)
                    self.reviewPostSuccessForSelect.send(false)
                }
            }
            .store(in: &subscription)
    }
}
