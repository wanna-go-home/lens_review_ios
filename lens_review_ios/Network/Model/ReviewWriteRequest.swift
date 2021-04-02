//
//  ReviewWriteRequest.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/28.
//

import Foundation

struct ReviewWriteRequest : Encodable
{
    let title : String
    let content : String
    let lensId : Int
}
