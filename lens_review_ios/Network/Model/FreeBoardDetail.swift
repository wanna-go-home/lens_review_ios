//
//  FreeBoardDetail.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/06.
//

import Foundation

struct FreeBoardDetail: Decodable, Identifiable
{
    var id : Int = 0
    var accountId : Int = 0
    var nickname : String = ""
    var title : String = ""
    var content : String = ""
    var viewCnt : Int = 0
    var likeCnt : Int = 0
    var replyCnt : Int = 0
    var createdAt : String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case accountId
        case nickname
        case title
        case content
        case viewCnt
        case likeCnt
        case replyCnt
        case createdAt
    }
}
