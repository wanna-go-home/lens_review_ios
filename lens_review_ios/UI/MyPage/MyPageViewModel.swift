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
}
