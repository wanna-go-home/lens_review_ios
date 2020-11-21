//
//  LensDetail.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/20.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import Foundation

struct LensDetail : Decodable, Identifiable
{
    var id : Int = 0
    var name : String = ""
    var graphicDia: Float = 0
    var perPackage : Int = 0
    var price : Int = 0
    var reviewCnt : Int = 0
    // let bc : Numeric
    // let dia : Numeric
    // let per : Json
    // let url : String
    var productImage = [String]()

    enum CodingKeys: String, CodingKey {
        case id = "lensId"
        case name
        case graphicDia
        case perPackage
        case price
        case reviewCnt
        case productImage
    }
}
