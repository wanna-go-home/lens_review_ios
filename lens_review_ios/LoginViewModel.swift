//
//  LoginViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/24.
//

import Foundation
import KeychainSwift

class LoginViewModel: ObservableObject
{
    @Published var isLoginSuccess = false
    
    init()
    {
        //TODO 자동로그인 유지하면 Key 지우기 X
        tokenAllClear()
    }
    
    func login(id: String, pw: String)
    {
        LensAPIClient.login(account: id, pw: pw){ (result) in
            // TODO success/fail 관리
            setToken(tokenValue: result, tokenKey: "token")
            self.isLoginSuccess = true
        }
    }
}
