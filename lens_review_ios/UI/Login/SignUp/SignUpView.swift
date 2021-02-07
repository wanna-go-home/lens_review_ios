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
    


    init(){
        
    }
    
    @State var textBinding = ""
    
    
    var body: some View {
        
        
        return VStack(alignment: .leading, spacing:20){
            
            VStack(alignment:.leading, spacing:0){
                TextField("sign_up_user_email_hint".localized(), text: $userId)
                    .autocapitalization(.none)
                    .onChange(of: userId){ v in
                        signUpViewModel.userIdSubject.send(v)
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
                        signUpViewModel.userPwSubject.send(v)
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
                        signUpViewModel.userPwCheckSubject.send((userPw, v))
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
                        signUpViewModel.userPhoneNumberSubject.send(ph)
                        
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

                        signUpViewModel.userNicknameSubject.send(v)
                        
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
