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
    var price : Int = 0
    var graphicDia: Float = 0
    var productImage = [String]()
    var perPackage : Int = 0
    var reviewCnt : Int = 0
    var bc : Float = 0
    var dia : Float = 0
    var url : String = ""
    var demonstrationImage = [String]()
    var pwr = [Float]()

    enum CodingKeys: String, CodingKey {
        case id = "lensId"
        case name
        case price
        case graphicDia
        case productImage
        case perPackage
        case reviewCnt
        case bc
        case dia
        case url
        case demonstrationImage
        case pwr
    }
}
