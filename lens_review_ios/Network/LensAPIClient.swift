//
//  LensAPI.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/05.
//  Copyright © 2020 wannagohome. All rights reserved.
//
import Foundation
import Alamofire

class LensAPIClient
{
    static func getLens(completion: @escaping(Result<[Lens], AFError>) -> Void)
    {
        AF.request(APIBuilder.getLens)
            .responseDecodable {
                (response: DataResponse<[Lens], AFError>) in completion(response.result)
                print(response)
        }
    }

    static func getLensByID(lensId: Int, completion: @escaping(Result<LensDetail, AFError>) -> Void)
    {
        AF.request(APIBuilder.getLensById(id: lensId))
            .responseDecodable {
                (response: DataResponse<LensDetail, AFError>) in
                    completion(response.result)
                print(response)
            }
    }
}
