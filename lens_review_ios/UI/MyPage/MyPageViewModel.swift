//
//  MyPageViewModel.swift
//  lens_review_ios
//
//  Created by sance on 2021/01/29.
//

import Combine

class MyPageViewModel: ObservableObject
{
    @Published var nickname = ""
    @Published var reviewCnt = 0
    @Published var articleCnt = 0
    @Published var commentCnt = 0
    var subscription = Set<AnyCancellable>()
    let leaveSuccess = PassthroughSubject<Bool, Never>()
    let leaveError = PassthroughSubject<Bool, Never>()
    
    func getUserInfo()
    {
        LensAPIClient.getUserInfo { result in
            switch result {
            case .success(let info):
                self.nickname = info.nickName
                self.reviewCnt = info.reviewCount
                self.articleCnt = info.freeCount
                self.commentCnt = info.reviewCommentCount + info.freeCommentCount
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func leave(){
        LensAPIClient.leave()
            .sink{response in
                switch response {
                case .success(let _):
                    self.leaveSuccess.send(true)
                case .failure(let error):
                    //에러처리 ui 디자인 다나오면 구체화
                    print("err")
                }
            }
            .store(in : &subscription)
        
    }
}
