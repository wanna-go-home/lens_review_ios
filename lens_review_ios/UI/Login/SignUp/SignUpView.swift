//
//  SignUpView.swift
//  lens_review_ios
//
//  Created by 김기표 on 2021/01/29.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @ObservedObject var signUpViewModel: SignUpViewModel = SignUpViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var userId = ""
    @State private var userPw = ""
    @State private var userPwCheck = ""
    @State private var userPhoneNum=""
    @State private var userNickname = ""
    
    @State private var emailError = ""
    @State private var pwError = ""
    @State private var pwCheckError = ""
    @State private var phoneNumberError = ""
    @State private var nicknameError = ""
    
    let userIdSubject = PassthroughSubject<String, Never>()
    let userPwSubject = PassthroughSubject<String, Never>()
    let userPwCheckSubject = PassthroughSubject<String, Never>()
    
    let userNicknameSubject = PassthroughSubject<String, Never>()
    let userPhoneNumberSubject = PassthroughSubject<String, Never>()
    
    var subscription = Set<AnyCancellable>()

    let debounceInterval = RunLoop.SchedulerTimeType.Stride.milliseconds(300)

    init(){
        
        userIdSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] email in
                self.signUpViewModel.checkValidEmail(email: email)
            }.store(in: &subscription)
        
        userNicknameSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{ [self] nickname in
                self.signUpViewModel.checkValidNickname(nickname: nickname)
            }.store(in: &subscription)
        
        userPhoneNumberSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] ph in
                signUpViewModel.checkValidPhoneNumber(phoneNumber: ph)
            }.store(in: &subscription)
        
        userPwSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] pw in
                self.signUpViewModel.checkValidPw(pw:pw)
            }.store(in: &subscription)
        
        userPwCheckSubject
            .debounce(for: debounceInterval, scheduler: RunLoop.main)
            .sink{[self] pwCheck in
                print("비번 " + self.userPw)
                print("비번 확인 " + pwCheck)
                self.signUpViewModel.checkValidPwCheck(pw: self.userPw, pwCheck: pwCheck)
            }.store(in: &subscription)
    }
    
    @State var textBinding = ""
    
    
    var body: some View {
        
        
        return VStack(alignment: .leading, spacing:20){
            
            VStack(alignment:.leading, spacing:0){
                TextField("sign_up_user_email_hint".localized(), text: $userId)
                    .autocapitalization(.none)
                    .onChange(of: userId){ v in
                        userIdSubject.send(v)
                    }
                Text(emailError)
                    .foregroundColor(.red)
                    .onReceive(signUpViewModel.emailError, perform: { msg in
                        emailError = msg
                    })
            }
            VStack(alignment:.leading, spacing:0){
                
                SecureField("sign_up_user_pw_hint".localized(), text: $userPw)
                    .autocapitalization(.none)
                    .onChange(of: userPw) { v in
                        userPwSubject.send(v)
                    }
                Text(pwError)
                    .foregroundColor(.red)
                    .onReceive(signUpViewModel.pwError, perform: { msg in
                        pwError = msg
                    })
            }
            
            VStack(alignment:.leading, spacing:0){
                SecureField("sign_up_user_pw_check_hint".localized(), text: $userPwCheck)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .onChange(of: userPwCheck) { v in
                        userPwCheckSubject.send(v)
                    }
                Text(pwCheckError)
                    .foregroundColor(.red)
                    .onReceive(signUpViewModel.pwCheckError, perform: { msg in
                        pwCheckError = msg
                    })
                
            }
            VStack(alignment:.leading, spacing:0){
                TextField("sign_up_user_contact".localized(), text: $userPhoneNum)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .onChange(of: userPhoneNum){ph in
                        userPhoneNumberSubject.send(ph)
                        
                    }
                Text(phoneNumberError)
                    .foregroundColor(.red)
                    .onReceive(signUpViewModel.phoneNumberError, perform: { msg in
                        phoneNumberError = msg
                    })
            }
            VStack(alignment:.leading, spacing:0){
                
                TextField("sign_up_user_nichname".localized(), text: $userNickname)
                    .autocapitalization(.none)
                    .onChange(of: userNickname){v in

                        userNicknameSubject.send(v)
                        
                    }
                Text(nicknameError)
                    .foregroundColor(.red)
                    .onReceive(signUpViewModel.nicknameError, perform: { msg in
                        nicknameError = msg
                    })
            }
            
            Spacer()
            Button(action: signUp, label: {
                Text("sign_up".localized())
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(Color("PrimaryColor"))
                    .foregroundColor(Color.white)
            })
            .padding(.bottom, 10)
        }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
        .onReceive(signUpViewModel.signUpSuccess, perform: { value in
            if value {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        
    }
    
    func signUp(){
        signUpViewModel.signUp(id : userId, pw : userPw, pwCheck : userPwCheck, phoneNum : userPhoneNum, nickname : userNickname)
    }
    
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        return SignUpView()
    }
}
