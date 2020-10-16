//
//  Board.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/15.
//

import Foundation

struct Board : Decodable, Identifiable
{
    var id : Int = 0
    var accountId : String = ""
    var name : String = ""
//    var title : String = ""
//    var content : String = ""
//    var viewCnt : Int = 0
//    var likeCnt : Int = 0
//    var replyCnt : Int = 0
//    var createdAt : String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case accountId
        case name
//        case title
//        case content
//        case viewCnt
//        case likeCnt
//        case replyCnt
//        case createdAt = "created_at"
    }
}
