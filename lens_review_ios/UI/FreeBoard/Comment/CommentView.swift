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
    var selectedBundleId: Int
    
    @EnvironmentObject var commentViewModel: CommentViewModel
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
            
            Divider()
            
            // 댓글 입력
            HStack(spacing: 4){
                Image("camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("IconColor"))
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
        .onReceive(commentViewModel.writeCommentSuccess, perform: { value in
            if value == CommentRequestResult.childSuccess
            {
                // TODO refresh 후에 제일 스크롤 제일 아래로 내리기
                callGetAllComments()
                commentContent = ""
            }
        })
        .onReceive(commentViewModel.deleteCommentSuccess, perform: { value in
            if value == CommentRequestResult.childSuccess
            {
                callGetAllComments()
            }
        })
        .onReceive(commentViewModel.modifyCommentSuccess, perform: { value in
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
        commentViewModel.getAllComments(articleId: selectedArticleId, commentId: selectedCommentId)
    }
    
    func callWriteComment()
    {
        commentViewModel.writeComment(articleId: selectedArticleId, content: commentContent, bundleId: selectedBundleId)
    }
}
