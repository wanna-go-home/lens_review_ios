//
//  Review.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/17.
//

import Foundation

struct Review : Decodable, Identifiable
{
    var id : Int = 0
    var accountId : String = ""
    var name : String = ""
    var title : String = ""
    var content : String = ""
    var likeCnt : Int = 0
    var replyCnt : Int = 0
//    var createdAt : String = ""
    var lensId : Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case accountId
        case name
        case title
        case content
        case likeCnt
        case replyCnt
//        case createdAt = "created_at"
        case lensId
    }
}
