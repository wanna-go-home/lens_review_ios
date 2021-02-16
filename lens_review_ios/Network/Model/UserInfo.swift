//
//  UserInfo.swift
//  lens_review_ios
//
//  Created by sance on 2021/01/29.
//

import Foundation

struct UserInfo : Decodable, Identifiable
{
    var id : Int = 0
    var email : String = ""
    var nickName : String = ""
    var reviewCount : Int = 0
    var freeCount : Int = 0
    var reviewCommentCount : Int = 0
    var freeCommentCount : Int = 0
    var likeCount : Int = 0

    enum CodingKeys: String, CodingKey {
        case id = "accountId"
        case email
        case nickName
        case reviewCount
        case freeCount
        case reviewCommentCount
        case freeCommentCount
        case likeCount
    }
}
