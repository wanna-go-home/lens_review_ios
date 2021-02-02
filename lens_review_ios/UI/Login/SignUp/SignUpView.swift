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
        let userIdBinding = Binding<String>(get: {
                    self.userId
                }, set: {
                    self.userId = $0
                    // do whatever you want here
                    emailEditChanged(self.userId)
                    
                })
        let userPwBinding = Binding<String>(get : {
            self.userPw
        }, set:{
            self.userPw = $0
            pwEditChanged(self.userPw)
        })
        
        VStack{
            
            TextField("sign_up_user_email_hint".localized(), text: userIdBinding)
                .padding()
            SecureField("sign_up_user_pw_hint".localized(), text: userPwBinding)
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
    
    private func emailEditChanged(_ email: String) {
        print("email " + email)
    }
    private func pwEditChanged(_ pw : String){
        print("pw " + pw)
    }

}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
