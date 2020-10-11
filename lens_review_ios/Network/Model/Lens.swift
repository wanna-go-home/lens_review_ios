//
//  Lens.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/06.
//  Copyright © 2020 wannagohome. All rights reserved.
//
import Foundation

struct Lens : Decodable, Identifiable
{
    var id : Int = 0
    var name : String = ""
    var price : Int = 0
    // let productImage : Json

    enum CodingKeys: String, CodingKey {
        case id = "lens_id"
        case name
        case price
    }
}
