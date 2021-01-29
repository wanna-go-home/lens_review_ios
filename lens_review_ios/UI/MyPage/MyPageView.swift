//
//  MyPageView.swift
//  lens_review_ios
//
//  Created by sance on 2021/01/29.
//

import SwiftUI

struct MyPageView: View
{
    @EnvironmentObject var myPageViewModel: MyPageViewModel
        
    var body: some View
    {
        VStack
        {
            // User Info Container
            VStack
            {
                HStack
                {
                    Text("NickName")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {})
                    {
                        Image("person")
                            .aspectRatio(contentMode: .fit)
                            .frame(width:15, height: 15)
                        Text("modify".localized())
                            .font(.system(size: 13))
                    }
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color("DarkButtonColor"))
                }
                .padding(.bottom, 15)
                
                HStack
                {
                    VStack(alignment:.leading, spacing: 5){
                        Text("my_review_count".localized()).foregroundColor(.gray)
                            .font(.system(size: 13))
                        Text("1").foregroundColor(.white)
                    }
                    
                    VStack(alignment:.leading, spacing: 5){
                        Text("my_article_count".localized()).foregroundColor(.gray)
                            .font(.system(size: 13))
                        Text("1").foregroundColor(.white)
                    }
                    
                    VStack(alignment:.leading, spacing: 5){
                        Text("my_comment_count".localized()).foregroundColor(.gray)
                            .font(.system(size: 13))
                        Text("1").foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .frame(height: 150)
            .padding()
            .background(Color("ContainerColor"))
            
            VStack
            {
                Button(action: {})
                {
                    Text("my_review".localized())
                        .foregroundColor(.black)
                    Spacer()
                    Image("arrow-right")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("IconColor"))
                }
                .padding(10)
                
                Button(action: {})
                {
                    Text("my_article".localized())
                        .foregroundColor(.black)
                    Spacer()
                    Image("arrow-right")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("IconColor"))
                }
                .padding(10)

                
                Button(action: {})
                {
                    Text("my_comment".localized())
                        .foregroundColor(.black)
                    Spacer()
                    Image("arrow-right")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("IconColor"))
                }
                .padding(10)
                
                ScrollDivider()
                
                Button(action: {})
                {
                    Text("my_leave".localized()).foregroundColor(.red)
                    Spacer()
                    Image("arrow-right")  
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color("IconColor"))
                }
                .padding(10)
            }
            
            Spacer()
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
