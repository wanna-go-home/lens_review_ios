//
//  SignUpViewModel.swift
//  lens_review_ios
//
//  Created by 김기표 on 2021/01/29.
//

import Foundation
import KeychainSwift
import Combine
class SignUpViewModel: ObservableObject
{
    
    let signUpSuccess = PassthroughSubject<Bool, Never>()
    let signUpError = PassthroughSubject<Int, Never>()
    
    let isSameEmail = PassthroughSubject<Bool, Never>()
    let isSameNickname = PassthroughSubject<Bool, Never>()
    
    func signUp(id: String, pw: String, pwCheck:String, phoneNum:String,nickname:String)
    {
        LensAPIClient.signUp(email: id, pw: pw, phoneNum: phoneNum, nickname: nickname){ (result) in
            switch result.result{
            case.success :
                if result.response?.statusCode == 200{
                    self.signUpSuccess.send(true)
                }
                else{
                    self.signUpError.send(SignUpErrType.WrongInput)
                }
            case .failure:
                self.signUpError.send(SignUpErrType.ServerError)
            }

        }
    }
    
    func checkSameEmail(email : String){
        print("")
    }
}
