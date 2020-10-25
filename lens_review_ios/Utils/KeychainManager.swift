//
//  KeychainManager.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/25.
//

import KeychainSwift

func setToken(tokenValue : String, tokenKey : String)
{
    KeychainSwift().set(tokenValue, forKey: tokenKey)
}

func getToken(tokenKey: String) -> String
{
    let ret = KeychainSwift().get(tokenKey) ?? ""
    
    return ret
}

func tokenAllClear()
{
    KeychainSwift().clear()
}
