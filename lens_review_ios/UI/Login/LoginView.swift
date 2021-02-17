//
//  LoginView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/24.
//

import SwiftUI
import KeychainSwift

struct LoginView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var userID = ""
    @State private var userPW = ""
    @State private var showSignUpView = false
    @State private var showingAlert = false
    @State private var alertMsg = ""
    
    var body: some View {
        VStack
        {
            Spacer()
            
            VStack
            {
                TextField("login_email_hint".localized(), text: $userID)
                    .autocapitalization(.none)
                    .padding(.horizontal, 30)
                Divider()
                    .padding(.horizontal, 30)
                
                SecureField("login_pw_hint".localized(), text: $userPW)
                    .autocapitalization(.none)
                    .padding(.horizontal, 30).padding(.top, 20)
                Divider()
                    .padding(.horizontal, 30)
                
                // TODO 회원가입
                Button(action: openSignUpScene)
                {
                    Text("signup".localized())
                        .foregroundColor(Color("BoardContentColor"))
                }
                .padding(.top, 30)
            }
            
            Spacer()
            
            Button(action: login)
            {
                Text("login".localized())
                    .frame(maxWidth:.infinity, minHeight: 50)
                    .background(Color("PrimaryColor"))
                    .foregroundColor(Color.white)
            }
            .padding(.bottom, 10)
            
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("login_fail".localized()), message: Text(alertMsg), dismissButton: .default(Text("ok".localized())))
            }
            NavigationLink(destination: SignUpView(), isActive: $showSignUpView){
                
                EmptyView()
            }
            
        }

        .onReceive(loginViewModel.loginError, perform: { value in
            if value == LoginErrType.WrongInput
            {
                alertMsg = "login_fail_wrong_input".localized()
                showingAlert = true
            }else if value == LoginErrType.ServerError
            {
                alertMsg = "login_fail_for_server".localized()
                showingAlert = true
            }
        })
    }
        
    
    
    func login() {
        loginViewModel.login(id:userID, pw:userPW)
    }
    
    func openSignUpScene(){

        self.showSignUpView = true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
