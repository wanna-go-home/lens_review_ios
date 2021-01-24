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
    // user
    static func login(account: String, pw: String, completion:@escaping (String)->Void)
    {
        let loginReq = LoginRequest(account: account, pw: pw)
    
        // TODO 토큰 없을때? validate 추가
        AF.request(APIBuilder.login(loginRequest: loginReq))
            .responseString {
                (response) in completion((response.response?.headers["Authorization"])!)
        }
    }
    
    // lens
    static func getLensesPreview(completion: @escaping(Result<[LensPreview], AFError>) -> Void)
    {
        AF.request(APIBuilder.getLensesPreview)
            .responseDecodable {
                (response: DataResponse<[LensPreview], AFError>) in completion(response.result)
        }
    }

    static func getLensDetail(lensId: Int, completion: @escaping(Result<LensDetail, AFError>) -> Void)
    {
        AF.request(APIBuilder.getLensById(id: lensId))
            .responseDecodable {
                (response: DataResponse<LensDetail, AFError>) in
                    completion(response.result)
            }
    }

    // FreeBoard
    static func getFreeBoardPreview(completion: @escaping(Result<[FreeBoardPreview], AFError>) -> Void)
    {
        AF.request(APIBuilder.getFreeBoardPreview)
            .responseDecodable {
                (response: DataResponse<[FreeBoardPreview], AFError>) in completion(response.result)
        }
    }
    
    static func getFreeBoardDetail(articleId: Int, completion: @escaping(Result<FreeBoardDetail, AFError>) -> Void)
    {
        AF.request(APIBuilder.getFreeBoardById(id: articleId))
            .responseDecodable {
                (response: DataResponse<FreeBoardDetail, AFError>) in completion(response.result)
        }
    }
    
    static func postArticle(title: String, content: String, completion: @escaping(Result<String, AFError>)->Void)
    {
        let articleReq = ArticleWriteRequest(title: title, content: content)
        
        AF.request(APIBuilder.postArticle(articleRequest: articleReq))
            .responseString {
                (response) in completion(response.result)
        }
    }
    
    static func putArticle(id: Int, title: String, content: String, completion: @escaping(Result<String, AFError>)->Void)
    {
        let articleReq = ArticleWriteRequest(title: title, content: content)
        
        AF.request(APIBuilder.putArticle(id: id, articleRequest: articleReq))
            .responseString {
                (response) in completion(response.result)
        }
    }
    
    static func deleteArticle(id: Int, completion: @escaping(Result<String, AFError>)->Void) {
        AF.request(APIBuilder.deleteArticle(id: id))
            .responseString {
                (response) in completion(response.result)
        }
    }
    
    static func getFreeBoardComment(articleId: Int, completion: @escaping(Result<[FreeBoardComment], AFError>) -> Void)
    {
        AF.request(APIBuilder.getFreeBoardComment(id: articleId))
            .responseDecodable {
                (response: DataResponse<[FreeBoardComment], AFError>) in completion(response.result)
        }
    }
    
    static func getFreeBoardAllComments(articleId: Int, commentId: Int, completion: @escaping(Result<[FreeBoardComment], AFError>) -> Void)
    {
        AF.request(APIBuilder.getCommentsByCommentId(id: articleId, commentId: commentId))
            .responseDecodable {
                (response: DataResponse<[FreeBoardComment], AFError>) in completion(response.result)
        }
    }
    
    static func postArticleComment(articleId: Int, bundleId: Int? = nil, content: String, completion: @escaping(Result<String, AFError>)->Void)
    {
        let commentReq = ArticleCommentWriteRequest(bundleId: bundleId, content: content)
        
        AF.request(APIBuilder.postArticleComment(id: articleId, commentRequest: commentReq))
            .responseString {
                (response) in completion(response.result)
        }
    }
    
    static func putArticleComment(articleId: Int, commentId: Int, bundleId: Int? = nil, content: String, completion: @escaping(Result<String, AFError>)->Void)
    {
        let commentReq = ArticleCommentWriteRequest(bundleId: bundleId, content: content)
        
        AF.request(APIBuilder.putArticleComment(id: articleId, commentId: commentId, commentRequest: commentReq))
            .responseString {
                (response) in completion(response.result)
        }
    }
    
    static func deleteArticleComment(articleId: Int, commentId: Int, completion: @escaping(Result<String, AFError>)->Void) {
        AF.request(APIBuilder.deleteArticleComment(id: articleId, commentId: commentId))
            .responseString {
                (response) in completion(response.result)
        }
    }
    
    // ReviewBoard
    static func getReviewBoardPreview(completion: @escaping(Result<[ReviewBoardPreview], AFError>) -> Void)
    {
        AF.request(APIBuilder.getReviewBoardPreview)
            .responseDecodable {
                (response: DataResponse<[ReviewBoardPreview], AFError>) in completion(response.result)
        }
    }
    
    static func getReviewBoardDetail(reviewId: Int, completion: @escaping(Result<ReviewBoardDetail, AFError>) -> Void)
    {
        AF.request(APIBuilder.getReviewBoardById(id: reviewId))
            .responseDecodable {
                (response: DataResponse<ReviewBoardDetail, AFError>) in completion(response.result)
        }
    }
}
