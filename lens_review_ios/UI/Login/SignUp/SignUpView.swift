//
//  SignUpView.swift
//  lens_review_ios
//
//  Created by 김기표 on 2021/01/29.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var signUpViewModel: SignUpViewModel = SignUpViewModel()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var userId = ""
    @State private var userPw = ""
    @State private var userPwCheck = ""
    @State private var userPhoneNum=""
    @State private var userNickname = ""
    
    
    var body: some View {

        VStack{
        
            TextField("sign_up_user_email_hint".localized(), text: $userId)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
            SecureField("sign_up_user_pw_hint".localized(), text: $userPw)
                .autocapitalization(.none)
                .padding()
            SecureField("sign_up_user_pw_check_hint".localized(), text: $userPwCheck)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
            TextField("sign_up_user_contact".localized(), text: $userPhoneNum)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
            TextField("sign_up_user_nichname".localized(), text: $userNickname)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
            Spacer()
            Button(action: signUp, label: {
                Text("sign_up".localized())
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(Color("PrimaryColor"))
                    .foregroundColor(Color.white)
            })
            .padding(.bottom, 10)
        }
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
        SignUpView()
    }
}
