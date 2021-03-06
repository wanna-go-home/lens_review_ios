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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State private var goMyArticleView = false
    @State private var goMyReviewView = false
    @State private var goLoginView = false
    
    @State private var showLeaveAlert = false
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                // User Info Container
                VStack
                {
                    HStack
                    {
                        Text(myPageViewModel.nickname)
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
                            Text("\(myPageViewModel.reviewCnt)").foregroundColor(.white)
                        }
                        
                        VStack(alignment:.leading, spacing: 5){
                            Text("my_article_count".localized()).foregroundColor(.gray)
                                .font(.system(size: 13))
                            Text("\(myPageViewModel.articleCnt)").foregroundColor(.white)
                        }
                        
                        VStack(alignment:.leading, spacing: 5){
                            Text("my_comment_count".localized()).foregroundColor(.gray)
                                .font(.system(size: 13))
                            Text("\(myPageViewModel.commentCnt)").foregroundColor(.white)
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
                    Button(action: openMyReviewView)
                    {
                        Text("my_review".localized())
                            .foregroundColor(.black)
                        Spacer()
                        Image("arrow-right")
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("IconColor"))
                    }
                    .padding(10)
                    
                    Button(action: openMyArticleView)
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
                    
                    Button(action: {
                        //showLeaveAlert = true
                        self.presentationMode.wrappedValue.dismiss()

                    })
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
                
                NavigationLink(destination: MyArticleView(), isActive: $goMyArticleView){
                    EmptyView()
                }
                
                NavigationLink(destination: MyReviewView(), isActive: $goMyReviewView){
                    EmptyView()
                }

            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            callGetUserInfo()
        })
        .alert(isPresented: $showLeaveAlert)
        {
            Alert(title: Text("leave_title".localized()), message: Text("leave_message".localized()),
                  primaryButton: .destructive(Text("leave_yes".localized()) , action: {
                        myPageViewModel.leave()
                  }),
                  secondaryButton: .cancel(Text("leave_no".localized()), action: {
                        showLeaveAlert = false
                  })
            )
        }
        .onReceive(myPageViewModel.leaveSuccess, perform: {value in
            if(value){
                self.presentationMode.wrappedValue.dismiss()
                goLoginView = true
            }
        })
    }
    
    func callGetUserInfo()
    {
        myPageViewModel.getUserInfo()
    }
    
    func openMyArticleView()
    {
        self.goMyArticleView = true
    }
    
    func openMyReviewView()
    {
        self.goMyReviewView = true
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
