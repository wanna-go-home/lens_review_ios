//
//  ArticleWriteRequest.swift
//  lens_review_ios
//
//  Created by sance on 2021/01/09.
//

import Foundation

struct ArticleWriteRequest : Encodable
{
    let title : String
    let content : String

    enum CodingKeys: String, CodingKey {
        case title
        case content
    }
}
