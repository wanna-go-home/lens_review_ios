//
//  LensAPI.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/05.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Foundation
import Alamofire

class LensAPI
{
    func getAllLensInfo()
    {
        print("Test")
        let url = "http://15.165.122.0:8080/api/lensinfo"
        let request = AF.request(url)
        request.responseJSON{(data) in
            print(data)
        }
    }
}
