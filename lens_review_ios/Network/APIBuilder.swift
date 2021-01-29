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
    var parameters: Data? { get }
}

enum APIBuilder: APIConfiguration
{
    case login(loginRequest: LoginRequest)
    case signUp(signUpRequest : SignUpRequest)
    case getUserInfo
    case getLensesPreview
    case getLensById(id : Int)
    case getFreeBoardPreview
    case getFreeBoardById(id: Int)
    case postArticle(articleRequest: ArticleWriteRequest)
    case putArticle(id: Int, articleRequest: ArticleWriteRequest)
    case deleteArticle(id: Int)
    case getFreeBoardComment(id: Int)
    case getCommentsByCommentId(id: Int, commentId: Int)
    case postArticleComment(id: Int, commentRequest: ArticleCommentWriteRequest)
    case putArticleComment(id: Int, commentId: Int, commentRequest: ArticleCommentWriteRequest)
    case deleteArticleComment(id: Int, commentId: Int)
    case getReviewBoardPreview
    case getReviewBoardById(id: Int)
    
    var method: HTTPMethod
    {
        switch self {
        case .login, .signUp, .postArticle, .postArticleComment:
            return .post
        case .getUserInfo,
             .getLensesPreview, .getLensById,
             .getFreeBoardPreview, .getFreeBoardById, .getFreeBoardComment, .getCommentsByCommentId,
             .getReviewBoardPreview, .getReviewBoardById:
            return .get
        case .putArticle, .putArticleComment:
            return .put
        case .deleteArticle, .deleteArticleComment:
            return .delete
        }
    }
    
    var path: String
    {
        switch self {
        case .login:
            return "/api/user/login"
        case .signUp:
            return "/api/user/signup"
        case .getUserInfo:
            return "/api/user/me"
        case .getLensesPreview:
            return "/api/lens"
        case .getLensById(let id):
            return "/api/lens/\(id)"
        case .getFreeBoardPreview, .postArticle:
            return "/api/boards/article"
        case .getFreeBoardById(let id), .putArticle(let id, _), .deleteArticle(let id):
            return "/api/boards/article/\(id)"
        case .getFreeBoardComment(let id), .postArticleComment(let id, _):
            return "/api/boards/article/\(id)/comments"
        case .getCommentsByCommentId(let id, let commentId), .putArticleComment(let id, let commentId, _), .deleteArticleComment(let id, let commentId):
            return "/api/boards/article/\(id)/comments/\(commentId)"
        case .getReviewBoardPreview:
            return "/api/boards/review-board"
        case .getReviewBoardById(let id):
            return "/api/boards/review-board/\(id)"
        }
    }
    
    var parameters: Data?
    {
        switch self {
        case .login(let loginRequest):
            return try? JSONEncoder().encode(loginRequest)
        case .signUp(let signUpRequest):
            return try? JSONEncoder().encode(signUpRequest)
        case .postArticle(let articleRequest), .putArticle(_, let articleRequest):
            return try? JSONEncoder().encode(articleRequest)
        case .postArticleComment(_, let commentRequest), .putArticleComment(_, _, let commentRequest):
            return try? JSONEncoder().encode(commentRequest)
        case .getUserInfo,
             .getLensesPreview, .getLensById,
             .getFreeBoardPreview, .getFreeBoardById, .getFreeBoardComment, .deleteArticle,
             .getCommentsByCommentId, .deleteArticleComment,
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
            urlRequest.httpBody = parameters
        }
        
        return urlRequest
    }
}
