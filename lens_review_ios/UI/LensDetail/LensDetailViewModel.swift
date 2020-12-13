//
//  LensDetailViewModel.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/27.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Combine

class LensDetailViewModel : ObservableObject
{
        
    @Published var lens = LensDetail()
    
    func getLensDetail(id: Int)
    {
        LensAPIClient.getLensDetail(lensId: id) {result in
            switch result{
            case .success(let lens_):
                self.lens = lens_
                print(lens_)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
