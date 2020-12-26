//
//  ReviewBoardDetail.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/13.
//

import Foundation

struct ReviewBoardDetail : Decodable, Identifiable
{
    var id : Int = 0
    var email : String = ""
    var nickname : String = ""
    var title : String = ""
    var content : String = ""
    var viewCnt : Int = 0
    var likeCnt : Int = 0
    var replyCnt : Int = 0
    var createdAt : String = ""
    var lensId : Int = 0

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case nickname
        case title
        case content
        case viewCnt
        case likeCnt
        case replyCnt
        case createdAt
        case lensId
    }
}
