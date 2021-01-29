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
    
    var body: some View {
        
        VStack{
            
            TextField("user_id".localized(), text: $userID)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .padding()
            SecureField("user_pw".localized(), text: $userPW)
                .autocapitalization(.none)
                .padding()
            Button(action: login)
            {
                Text("login".localized())
            }
            Button(action: openSignUpScene)
            {
                Text("sign_up".localized())
            }
            NavigationLink(destination: SignUpView(), isActive: $showSignUpView){
                EmptyView()
            }
            
        }
        
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
