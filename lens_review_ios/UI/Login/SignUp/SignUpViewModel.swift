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
    
    let emailError = CurrentValueSubject<String, Never>("")
    let pwError = CurrentValueSubject<String, Never>("")
    let pwCheckError = CurrentValueSubject<String, Never>("")
    let phoneNumberError = CurrentValueSubject<String, Never>("")
    let nicknameError = CurrentValueSubject<String, Never>("")
    
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
    
    func checkVaildEmail(email : String){
        emailError.send(email)
    }
    
    func checkValidNickname(nickname:String){
        print("check n" + nickname)
    }
    
    func checkValidPw(pw : String){
        
    }
    
    func checkValidPwCheck(pw : String){
        
    }
    
    func checkValidPhoneNumber(phoneNumber:String){
            print("check ph" + phoneNumber)
    }
}
