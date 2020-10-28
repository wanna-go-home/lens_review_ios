//
//  Login.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/25.
//

import Foundation

struct LoginRequest : Encodable
{
    let account : String
    let pw : String

    enum CodingKeys: String, CodingKey {
        case account
        case pw
    }
}
