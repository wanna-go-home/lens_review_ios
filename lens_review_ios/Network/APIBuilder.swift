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
    case getFreeBoardComment(id: Int)
    case postArticle(title: String, content: String)
    case putArticle(id: Int, title: String, content: String)
    case deleteArticle(id: Int)
    case getCommentsByCommentId(id: Int, commentId: Int)
    case getReviewBoardPreview
    case getReviewBoardById(id: Int)
    
    var method: HTTPMethod
    {
        switch self {
        case .login, .postArticle:
            return .post
        case .getLensesPreview, .getLensById,
             .getFreeBoardPreview, .getFreeBoardById, .getFreeBoardComment, .getCommentsByCommentId,
             .getReviewBoardPreview, .getReviewBoardById:
            return .get
        case .putArticle:
            return .put
        case .deleteArticle:
            return .delete
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
        case .getFreeBoardPreview, .postArticle:
            return "/api/boards/article"
        case .getFreeBoardById(let id), .putArticle(let id, _, _), .deleteArticle(let id):
            return "/api/boards/article/\(id)"
        case .getFreeBoardComment(let id):
            return "/api/boards/article/\(id)/comments"
        case .getCommentsByCommentId(let id, let commentId):
            return "/api/boards/article/\(id)/comment/\(commentId)"
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
        case .postArticle(let title_, let content_), .putArticle(_, let title_, let content_):
            return ["title": title_, "content": content_]
        case .getLensesPreview, .getLensById,
             .getFreeBoardPreview, .getFreeBoardById, .getFreeBoardComment, .deleteArticle,
             .getCommentsByCommentId,
             .getReviewBoardPreview, .getReviewBoardById:
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
        let token_ = getToken(tokenKey: "token")
        if(token_ != "")
        {
            urlRequest.addValue(token_, forHTTPHeaderField: "Authorization")
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
