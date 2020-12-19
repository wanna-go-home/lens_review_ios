//
//  FreeBoardComment.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/19.
//

import Foundation

struct FreeBoardComment: Decodable, Identifiable
{
    var id : Int = 0
    var accountId : String = ""
    var postId : Int = 0
    var content : String = ""
    var likeCnt : Int = 0
    var createdAt : String = ""
    var depth : Int = 0
    var bundleId : Int = 0
    var bundleSize : Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case accountId
        case postId
        case content
        case likeCnt
        case createdAt
        case depth
        case bundleId
        case bundleSize
    }
}
