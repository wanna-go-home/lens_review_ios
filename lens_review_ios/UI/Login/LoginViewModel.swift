//
//  LoginViewModel.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/24.
//

import Foundation
import KeychainSwift
import Combine

class LoginViewModel: ObservableObject
{
    @Published var isLoginSuccess = false
    let loginError = PassthroughSubject<Int, Never>()
    
    init()
    {
        //TODO 자동로그인 유지하면 Key 지우기 X
        tokenAllClear()
    }
    
    func login(id: String, pw: String)
    {
        LensAPIClient.login(account: id, pw: pw){ (result) in
            switch result.result {
            case .success:
                if result.response?.statusCode == 200 {
                    setToken(tokenValue: (result.response?.headers["Authorization"])!, tokenKey: "token")
                    self.isLoginSuccess = true
                }else {
                    self.loginError.send(LoginErrType.WrongInput)
                }
            case .failure:
                self.loginError.send(LoginErrType.ServerError)
            }
        }
    }
}
