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
        KeychainSwift().clear()
    }
    
    func login(id: String, pw: String)
    {
        LensAPIClient.login(account: id, pw: pw){ (result) in
            // TODO Key Set/Get 관련 파일 분리, success/fail 관리
            KeychainSwift().set(result, forKey: "token")
            self.isLoginSuccess = true
        }
    }
}
