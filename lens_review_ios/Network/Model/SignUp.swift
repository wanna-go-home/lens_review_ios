//
//  SignUpRequest.swift
//  lens_review_ios
//
//  Created by 김기표 on 2021/01/29.
//

import Foundation

struct SignUpRequest : Encodable {
    let accountEmail : String
    let accountPw : String
    let phoneNum : String
    let nickname : String
}

struct CheckSameInfoResponse : Codable{
    let available : Bool
    let checkCode : Int
}
