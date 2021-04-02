//
//  LensAPI.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/05.
//  Copyright © 2020 wannagohome. All rights reserved.
//
import Foundation
import Alamofire
import Combine

class LensAPIClient
{
    // user
    static func login(account: String, pw: String, completion:@escaping (AFDataResponse<Data?>) -> Void)
    {
        let loginReq = LoginRequest(account: account, pw: pw)
        
        AF.request(APIBuilder.login(loginRequest: loginReq))
            .response {
                (response) in completion(response)
            }
    }
    
    static func signUp(email:String,pw:String,phoneNum:String,nickname:String) -> AnyPublisher<Result<Data?, AFError>, Never>
    {
        let signUpReq = SignUpRequest(accountEmail: email, accountPw: pw, phoneNum: phoneNum, nickname: nickname)
        
        return AF.request(APIBuilder.signUp(signUpRequest: signUpReq))
            .validate()
            .publishUnserialized()
            .result()
    }
    
    static func checkSameEmail(email:String)->AnyPublisher<Result<CheckSameInfoResponse, AFError>, Never>{
            return AF.request(APIBuilder.checkSameEmail(id: email))
                .validate()
                .publishDecodable(type : CheckSameInfoResponse.self)
                .result()
        
    }
    
    static func checkSameNickname(nickname:String)->AnyPublisher<Result<CheckSameInfoResponse, AFError>, Never>
    {
        return AF.request(APIBuilder.checkSameNickname(nickname: nickname))
            .validate()
            .publishDecodable(type : CheckSameInfoResponse.self)
            .result()
    }
    static func checkSamePhoneNumber(ph:String)->AnyPublisher<Result<CheckSameInfoResponse, AFError>, Never>
    {
        return AF.request(APIBuilder.checkSamePhoneNumber(phoneNumber: ph))
            .validate()
            .publishDecodable(type : CheckSameInfoResponse.self)
            .result()
    }
    
    static func getUserInfo(completion: @escaping(Result<UserInfo, AFError>) -> Void)
    {
        AF.request(APIBuilder.getUserInfo)
            .responseDecodable {
                (response: DataResponse<UserInfo, AFError>) in completion(response.result)
            }
    }
    
    static func getMyArticle() -> AnyPublisher<Result<[FreeBoardPreview], AFError>, Never>
    {
        return AF.request(APIBuilder.getMyArticle)
            .validate()
            .publishDecodable(type: [FreeBoardPreview].self)
            .result()
    }
    
    static func getMyReview() -> AnyPublisher<Result<[ReviewBoardPreview], AFError>, Never>
    {
        return AF.request(APIBuilder.getMyReview)
            .validate()
            .publishDecodable(type: [ReviewBoardPreview].self)
            .result()
    }
    
    static func getMyComments() -> AnyPublisher<Result<[Comment], AFError>, Never>
    {
        return AF.request(APIBuilder.getMyComments)
            .validate()
            .publishDecodable(type: [Comment].self)
            .result()
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
    
    static func getFreeBoardComment(articleId: Int, completion: @escaping(Result<[Comment], AFError>) -> Void)
    {
        AF.request(APIBuilder.getFreeBoardComment(id: articleId))
            .responseDecodable {
                (response: DataResponse<[Comment], AFError>) in completion(response.result)
            }
    }
    
    static func getFreeBoardAllComments(articleId: Int, commentId: Int, completion: @escaping(Result<[Comment], AFError>) -> Void)
    {
        AF.request(APIBuilder.getCommentsByCommentId(id: articleId, commentId: commentId))
            .responseDecodable {
                (response: DataResponse<[Comment], AFError>) in completion(response.result)
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
    
    static func postReview(title: String, content: String, lensId: Int) -> AnyPublisher<Result<Data?, AFError>, Never>
    {
        let reviewReq = ReviewWriteRequest(title: title, content: content, lensId: lensId)
        
        return AF.request(APIBuilder.postReview(reviewRequest: reviewReq))
            .validate()
            .publishUnserialized()
            .result()
    }
}
