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
    static func login(account: String, pw: String, completion:@escaping (String)->Void) {
        // TODO 토큰 없을때? validate 추가
        AF.request(APIBuilder.login(account: account, pw: pw))
            .responseString {
                (response) in completion((response.response?.headers["Authorization"])!)
        }
    }
    
    static func getLensesPreview(completion: @escaping(Result<[LensPreview], AFError>) -> Void)
    {
        AF.request(APIBuilder.getLensesPreview)
            .responseDecodable {
                (response: DataResponse<[LensPreview], AFError>) in completion(response.result)
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

    static func getFreeBoardPreview(completion: @escaping(Result<[FreeBoardPreview], AFError>) -> Void)
    {
        AF.request(APIBuilder.getFreeBoardPreview)
            .responseDecodable {
                (response: DataResponse<[FreeBoardPreview], AFError>) in completion(response.result)
                print(response)
        }
    }
    
    static func getReviewBoardPreview(completion: @escaping(Result<[ReviewBoardPreview], AFError>) -> Void)
    {
        AF.request(APIBuilder.getReviewBoardPreview)
            .responseDecodable {
                (response: DataResponse<[ReviewBoardPreview], AFError>) in completion(response.result)
                print(response)
        }
    }
}
