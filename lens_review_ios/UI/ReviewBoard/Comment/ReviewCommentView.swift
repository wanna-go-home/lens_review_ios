//
//  ReviewCommentView.swift
//  lens_review_ios
//
//  Created by sance on 2021/04/03.
//

import SwiftUI

struct ReviewCommentView: View
{
    var selectedCommentId: Int
    var selectedReviewId: Int
    var selectedBundleId: Int
    
    @EnvironmentObject var reviewCommentViewModel: ReviewCommentViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var commentContent = ""

    var body: some View {
        VStack
        {
            customTitleBar
            ScrollView(showsIndicators: false)
            {
                LazyVStack(alignment: .leading, spacing: 0)
                {
                    ForEach(reviewCommentViewModel.commentList) { comment_ in
                        if comment_.depth == CommentConst.parentComment {
                            ReviewCommentRowView(comment: comment_, moreFlag: false, isCommentView: true)
                        }else if comment_.depth == CommentConst.childComment {
                            ReviewChildCommentRowView(comment: comment_, isCommentView: true)
                        }
                    }
                }
                .frame(minHeight: 100)
            }
            
            Divider()
            
            // 댓글 입력
            HStack(spacing: 4){
                TextField("child_comment_hint".localized(), text: $commentContent)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .autocapitalization(.none)
                
                if $commentContent.wrappedValue.count > 0
                {
                    Button(action: { callWriteComment() })
                    {
                        Text("post".localized())
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.bottom, 20)
        }
        .onAppear(perform: callGetAllComments)
        .frame(maxHeight:.infinity,  alignment: .top)
        .onReceive(reviewCommentViewModel.writeCommentSuccess, perform: { value in
            if value == CommentRequestResult.childSuccess
            {
                callGetAllComments()
                commentContent = ""
            }
        })
        .onReceive(reviewCommentViewModel.deleteCommentSuccess, perform: { value in
            if value == CommentRequestResult.childSuccess
            {
                callGetAllComments()
            }
        })
        .onReceive(reviewCommentViewModel.modifyCommentSuccess, perform: { value in
            if value == CommentRequestResult.childSuccess
            {
                callGetAllComments()
            }
        })
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
        reviewCommentViewModel.getAllComments(reviewId: selectedReviewId, commentId: selectedCommentId)
    }
    
    func callWriteComment()
    {
        reviewCommentViewModel.writeComment(reviewId: selectedReviewId, content: commentContent, bundleId: selectedBundleId)
    }
}
