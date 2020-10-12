//
//  LensDB.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/08.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Combine

class LensViewModel: ObservableObject
{
    @Published var lensList = [Lens]()

    init(lens: [Lens] = [])
    {
        getLensList()
    }

    func getLensList()
    {
        LensAPIClient.getLens {result in
            switch result{
            case .success(let lens_):
                self.lensList.append(contentsOf: lens_)
                print(lens_)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
