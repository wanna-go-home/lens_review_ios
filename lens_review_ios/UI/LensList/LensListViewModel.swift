//
//  LensDB.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/08.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Combine

class LensListViewModel: ObservableObject
{
    @Published var lensList = [LensPreview]()

    func getLensList()
    {
        LensAPIClient.getLensesPreview {result in
            switch result{
            case .success(let lens_):
                self.lensList.append(contentsOf: lens_)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
