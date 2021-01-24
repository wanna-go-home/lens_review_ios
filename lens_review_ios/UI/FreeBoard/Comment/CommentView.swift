//
//  CommentView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/21.
//

import SwiftUI


struct CommentView: View
{
    var selectedCommentId: Int
    var selectedArticleId: Int
    
    @ObservedObject var commentViewModel:CommentViewModel = CommentViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack(spacing: 0)
        {
            customTitleBar
            ScrollView(showsIndicators: false)
            {
                LazyVStack(alignment: .leading, spacing: 0)
                {
                    ForEach(commentViewModel.commentList) { comment_ in
                        if comment_.depth == CommentConst.parentComment {
                            CommentRowView(comment: comment_, moreFlag: false, isCommentView: true)
                        }else if comment_.depth == CommentConst.childComment {
                            ChildCommentRowView(comment: comment_, isCommentView: true)
                        }
                    }
                }
                .frame(minHeight: 100)
            }
        }
        .onAppear(perform: callGetAllComments)
        .frame(maxHeight:.infinity,  alignment: .top)
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
    
    func callGetAllComments()
    {
        commentViewModel.getAllComments(articleId: selectedArticleId, commentId: selectedCommentId)
    }
}
