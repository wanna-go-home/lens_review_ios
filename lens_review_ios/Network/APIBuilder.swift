//
//  APIBuilder.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/06.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible
{
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIBuilder: APIConfiguration
{
    case getLensesPreview
    case getLensById(id : Int)
    case getFreeBoardPreview
    case getReviewBoardPreview
    
    var method: HTTPMethod
    {
        switch self {
        case .getLensesPreview, .getLensById, .getFreeBoardPreview, .getReviewBoardPreview:
            return .get
        }
    }
    
    var path: String
    {
        switch self {
        case .getLensesPreview:
            return "/api/lens"
        case .getLensById:
//            return "/api/lensinfo/\(id)"
            return "/api/lens"
        case .getFreeBoardPreview:
            return "/api/boards/free-board"
        case .getReviewBoardPreview:
            return "/api/boards/review-board"
        }
    }
    
    var parameters: Parameters?
    {
        switch self {
        case .getLensesPreview, .getFreeBoardPreview, .getReviewBoardPreview:
            return nil
        case .getLensById(let id):
            return [NetConfig.APIParameterKey.id: id]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try NetConfig.API_BASE_URL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Header
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                switch self {
                case .getLensById(let id):
                    // Parameters 타입 encadable 문제 때문에 encode 함수에서 바로 ["id": id] 넣어줌
                    // parameters 바로 넣을 수 있는 방법 찾아야 함
                    urlRequest = try URLEncodedFormParameterEncoder().encode([NetConfig.APIParameterKey.id: id], into: urlRequest)
                default:
                    break
                    //urlRequest = try JSONParameterEncoder().encode(parameters, into: urlRequest)
                }
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
