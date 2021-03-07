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
    var accountId : Int = 0
    var nickname : String = ""
    var isAuthor : Bool = false
    var isLiked : Bool = false
    var title : String = ""
    var content : String = ""
    var viewCnt : Int = 0
    var likeCnt : Int = 0
    var replyCnt : Int = 0
    var createdAt : String = ""
    var lensId : Int = 0
    var lensPreviewEntity = LensPreview()
}
