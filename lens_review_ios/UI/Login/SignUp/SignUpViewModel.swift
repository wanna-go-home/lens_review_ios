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
    
    
    var subscription = Set<AnyCancellable>()
    
    let userIdSubject = PassthroughSubject<String, Never>()
    let userPwSubject = PassthroughSubject<String, Never>()
    let userPwCheckSubject = PassthroughSubject<(String,String), Never>()
    let userNicknameSubject = PassthroughSubject<String, Never>()
    let userPhoneNumberSubject = PassthroughSubject<String, Never>()
    
    init(){

        

        let debounceInterval = RunLoop.SchedulerTimeType.Stride.milliseconds(300)
        
        
        userIdSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] email in
                checkValidEmail(email: email)
            }.store(in: &subscription)
        
        userNicknameSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{ [self] nickname in
                checkValidNickname(nickname: nickname)
            }.store(in: &subscription)
        
        userPhoneNumberSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] ph in
                checkValidPhoneNumber(phoneNumber: ph)
            }.store(in: &subscription)
        
        userPwSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] pw in
                checkValidPw(pw:pw)
            }.store(in: &subscription)
        
        userPwCheckSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] pw, pwCheck in
                checkValidPwCheck(pw: pw, pwCheck: pwCheck)
            }.store(in: &subscription)
    }
    
    
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
    
    private func checkValidEmailForm(email : String) -> Bool{
        
        if(email.isEmpty){
            emailError.send("empty_email".localized())

            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let matchResult = emailTest.evaluate(with: email)
        
        if(!matchResult){
            emailError.send("not_email_form".localized())
            return false
        }
        
        emailError.send("")

        return true
    }
    
    func checkValidEmail(email : String){
        if(!checkValidEmailForm(email: email)){
            return
        }
            
        //send req


    }
    private func checkValidNicknameForm(nickname:String)->Bool{
        if(nickname.isEmpty){
            nicknameError.send("empty_nickname".localized())
            return false
        }
        return true
    }
    func checkValidNickname(nickname:String){
        if(!checkValidNicknameForm(nickname: nickname)){
            return
        }
        
        //send req
    }
    
    private func checkValidPhoneNumberForm(phoneNumber:String)->Bool{
        if(phoneNumber.isEmpty){
            phoneNumberError.send("empty_phone_number".localized())
            return false
        }
        
        if(phoneNumber.count != 11){
            phoneNumberError.send("invalid_phone_number".localized())
            return false
        }
        phoneNumberError.send("")
        return true
    }
    
    func checkValidPhoneNumber(phoneNumber:String){
        if(!checkValidPhoneNumberForm(phoneNumber: phoneNumber)){
            return
        }
        
        // send req
    }
    
    func checkValidPw(pw : String) -> Bool{
        if(pw.isEmpty){
            pwError.send("empty_pw".localized())
            return false
        }
        
        let reg = "[0-9|a-zA-Z|!|@|#]{6,15}"
        let pwText = NSPredicate(format:"SELF MATCHES %@", reg)
        let matchResult = pwText.evaluate(with : pw)
        
        if(!matchResult){
            pwError.send("pw_not_acceptable".localized())
            return false
        }
        pwError.send("")

        
        return true
    }
    
    func checkValidPwCheck(pw : String, pwCheck:String) -> Bool{
        
        if(pw != pwCheck){
            pwCheckError.send("different_pw_check".localized())
            return false
        }
        pwCheckError.send("")
        return true
    }

}
