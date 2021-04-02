//
//  ArticleCommentWriteRequest.swift
//  lens_review_ios
//
//  Created by sance on 2021/01/09.
//

import Foundation

struct CommentWriteRequest : Encodable
{
    let bundleId : Int?
    let content : String

    enum CodingKeys: String, CodingKey {
        case bundleId
        case content
    }
}
