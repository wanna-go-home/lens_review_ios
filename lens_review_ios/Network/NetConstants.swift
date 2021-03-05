//
//  NetConstants.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/05.
//  Copyright © 2020 wannagohome. All rights reserved.
//
struct NetConfig
{
    static let API_BASE_URL = "https://wgh-lens.com:8080"
    
    struct APIParameterKey {
        static let id = "id"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
