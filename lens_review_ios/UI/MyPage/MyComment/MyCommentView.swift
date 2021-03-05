//
//  MyCommentView.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/05.
//

import SwiftUI

struct MyCommentView: View
{
    @ObservedObject var myCommentViewModel = MyCommentViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View
    {
        VStack(spacing: 0)
        {
            customTitleBar
            ScrollView(showsIndicators: false)
            {
                LazyVStack(alignment: .leading)
                {
                    ForEach(myCommentViewModel.commentList) { comment in
                        MyCommentRow(comment: comment)
                    }
                }
                .frame(minHeight: 100)
            }
            .padding([.leading, .trailing, .top])
            .navigationBarHidden(true)
            .onAppear(perform: {
                myCommentViewModel.getMyComments()
            })
        }
    }
    
    var customTitleBar : some View {
        HStack
        {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 1) {
                        Image("arrow-left") // set image here
                            .aspectRatio(contentMode: .fit)
                            .frame(width:35, height: 35)
                            .foregroundColor(Color("IconColor"))
                        Text("go_back".localized())
                            .foregroundColor(.gray)
                    }
            }
            
            Spacer()
        }
    }
}

struct MyCommentRow: View
{
    var comment: Comment
    
    var body: some View {
        VStack(alignment: .leading)
        {
            HStack(spacing: 10)
            {
                if comment.type == "REVIEW" {
                    Image("review-comment")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:35, height: 35)
                        .foregroundColor(Color("IconColor"))
                }else if comment.type == "ARTICLE" {
                    Image("article-comment")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:35, height: 35)
                        .foregroundColor(Color("IconColor"))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(comment.content)")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Text("\(convertDateFormat(createdAt: comment.createdAt))")
                        .font(.system(size: 12))
                        .foregroundColor(Color("BoardContentColor"))
                }
            }
            .padding([.leading, .trailing], 5)
            
            Divider()
        }
    }
}
