//
//  APIBuilder.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/06.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift

protocol APIConfiguration: URLRequestConvertible
{
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIBuilder: APIConfiguration
{
    case login(account: String, pw: String)
    case getLensesPreview
    case getLensById(id : Int)
    case getFreeBoardPreview
    case getFreeBoardById(id: Int)
    case getReviewBoardPreview
    case getReviewBoardById(id: Int)
    
    var method: HTTPMethod
    {
        switch self {
        case .login:
            return .post
        case .getLensesPreview, .getLensById, .getFreeBoardPreview, .getFreeBoardById, .getReviewBoardPreview, .getReviewBoardById:
            return .get
        }
    }
    
    var path: String
    {
        switch self {
        case .login:
            return "/api/user/login"
        case .getLensesPreview:
            return "/api/lens"
        case .getLensById(let id):
            return "/api/lens/\(id)"
        case .getFreeBoardPreview:
            return "/api/boards/free-board"
        case .getFreeBoardById(let id):
            return "/api/boards/free-board/\(id)"
        case .getReviewBoardPreview:
            return "/api/boards/review-board"
        case .getReviewBoardById(let id):
            return "/api/boards/review-board/\(id)"
        }
    }
    
    var parameters: Parameters?
    {
        switch self {
        case .login(let account_, let pw_):
            return ["account": account_, "pw": pw_]
        case .getLensesPreview, .getLensById, .getFreeBoardPreview, .getFreeBoardById ,.getReviewBoardPreview, .getReviewBoardById:
            return nil
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
        
        // Custom Header
        // TODO "Authorization", "token"을 Model이나 Constants로 빼기
        switch self{
        case .login(let account, let pw):
            urlRequest.addValue(account, forHTTPHeaderField: "account")
            urlRequest.addValue(pw, forHTTPHeaderField: "pw")
        default:
            urlRequest.addValue(getToken(tokenKey: "token"), forHTTPHeaderField: "Authorization")
        }
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
