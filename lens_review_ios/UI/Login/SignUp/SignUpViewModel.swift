//
//  SignUpViewModel.swift
//  lens_review_ios
//
//  Created by 김기표 on 2021/01/29.
//

import Foundation
import KeychainSwift
import Combine
import Alamofire

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
    
    deinit {
        subscription.forEach { (cancelable) in
            cancelable.cancel()
        }
    }
    
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
        
//        signUpSuccess
//            .sink{[self] done in
//                
//                
//            }.store(in : &subscription)
    }
    
    func checkAll(email:String, pw:String, pwCheck:String, phoneNumber:String, nickname:String) -> Just<Bool>{
        let validEmail = checkValidEmailForm(email: email)
        let validPw = checkValidPw(pw: pw)
        let validPwCheck = checkValidPwCheck(pw: pw, pwCheck: pwCheck)
        let validPhoneNumber = checkValidPhoneNumberForm(phoneNumber: phoneNumber)
        let validNickname = checkValidNicknameForm(nickname: nickname)
        
        let ret = validEmail && validPw && validPwCheck && validPhoneNumber && validNickname
        
        return Just<Bool>(ret)
    }
    
    //    func checkSameEmailPublisher(email:String) -> AnyPublisher<Bool, Never>{
    //        let ret = AF.request(APIBuilder.checkSameEmail(id: email))
    //
    //
    ////        LensAPIClient.getLensDetail(lensId: id) {result in
    ////            switch result{
    ////            case .success(let lens_):
    ////                self.lens = lens_
    ////            case .failure(let error):
    ////                print(error.localizedDescription)
    ////            }
    ////        }
    //
    //        Future<Bool, Never> {promise in
    //            LensAPIClient.checkSameEmail(email: email){result in
    //
    //                switch result{
    //                case .success
    //                }
    //            }
    //
    //        }
    //    }
    
    
    func signUp(email: String, pw: String, pwCheck:String, phoneNum:String,nickname:String)
    {
        checkAll(email: email, pw: pw, pwCheck: pwCheck, phoneNumber: phoneNum, nickname: nickname)
            .filter{$0}
            .flatMap{avail in
                Publishers.Zip3(LensAPIClient.checkSameEmail(email: email),
                                LensAPIClient.checkSameNickname(nickname: nickname),
                                LensAPIClient.checkSamePhoneNumber(ph: phoneNum))
            }
            .map{ (emailResult,nicknameResult,phoneNumberResult) -> Bool in
                let emailAvailable = try? emailResult.get().available
                let nicknameAvailable = try? nicknameResult.get().available
                let phoneNumberAvailable = try? phoneNumberResult.get().available
                
                if let emailAvailable = emailAvailable, !emailAvailable{
                    self.emailError.send("already_registered_email".localized())
                }
                
                if let nicknameAvailable = nicknameAvailable, !nicknameAvailable{
                    self.nicknameError.send("already_registered_nickname".localized())
                }
                
                if let phoneNumberAvailable = phoneNumberAvailable, !phoneNumberAvailable{
                    self.phoneNumberError.send("already_registered_phone_number".localized())
                }

                return emailAvailable! && nicknameAvailable! && phoneNumberAvailable!
            }
            .sink { (canSignUp) in
                
                if(canSignUp){
                    print("sign up true")
                    self.callSignUp(email: email, pw: pw, ph: phoneNum, nickname: nickname)
                }
                else{
                    print("sign up false")
                }
            }.store(in : &subscription)
        
        
    }
    private func callSignUp(email:String, pw:String, ph:String, nickname:String){
        print("sign up call")
        LensAPIClient.signUp(email: email, pw: pw, phoneNum: ph, nickname: nickname)
            .sink{response in
                switch response {
                case .success(let _):
                    self.signUpSuccess.send(true)
                    print("sign up done")
                case .failure(let _):
                    //실패처리 어떻게하지?
                    print("sign up fail")
                    self.signUpError.send(SignUpErrType.WrongInput)
                }
            }
            .store(in : &subscription)
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
        
        LensAPIClient.checkSameEmail(email: email)
            .sink { [self] response in
                switch response {
                case .success(let value):
                    if(value.available){
                        emailError.send("")
                    }
                    else{
                        emailError.send("already_registered_email".localized())
                    }
                case .failure(let error):
                    //실패처리 어떻게하지?
                    print(error)
                }
            }.store(in: &subscription)
        
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
        LensAPIClient.checkSameNickname(nickname: nickname)
            .sink { [self] response in
                switch response {
                case .success(let value):
                    if(value.available){
                        nicknameError.send("")
                    }
                    else{
                        nicknameError.send("already_registered_nickname".localized())
                    }
                case .failure(let error):
                    //실패처리 어떻게하지?
                    print(error)
                }
            }.store(in: &subscription)
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
        LensAPIClient.checkSamePhoneNumber(ph: phoneNumber)
            .sink { [self] response in
                switch response {
                case .success(let value):
                    if(value.available){
                        phoneNumberError.send("")
                    }
                    else{
                        phoneNumberError.send("already_registered_phone_number".localized())
                    }
                case .failure(let error):
                    //실패처리 어떻게하지?
                    print(error)
                }
            }.store(in: &subscription)
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
