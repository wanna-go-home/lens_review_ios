//
//  UIConstants.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/21.
//

import Foundation

struct CommentConst
{
    static let parentComment = 0
    static let childComment = 1
    static let moreCommentSize = 3
}

struct CommentRequestResult
{
    static let parentSuccess = 0
    static let childSuccess = 1
    static let failure = 2
}

struct LoginErrType
{
    static let WrongInput = 1
    static let ServerError = 2
}

struct SignUpErrType
{
    static let WrongInput = 1
    static let ServerError = 2
}
