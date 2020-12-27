//
//  FreeBoardWriteViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/26.
//

import Combine

class FreeBoardWriteViewModel : ObservableObject
{
    @Published var writeSuccess = false
    
    func postArticle(title: String, content: String)
    {
        LensAPIClient.postArticle(title: title, content: content){ result in
            switch result {
            case .success:
                self.writeSuccess = true
            case .failure(let error):
                self.writeSuccess = false
                print(error.localizedDescription)
            }
        }
    }
}
