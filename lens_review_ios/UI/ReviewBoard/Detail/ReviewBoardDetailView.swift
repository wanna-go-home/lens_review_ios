//
//  ReviewBoardDetailView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/13.
//

import SwiftUI

struct ReviewBoardDetailView: View
{
    var selectedReviewId: Int
    @ObservedObject var reviewBoardDetailViewModel:ReviewBoardDetailViewModel = ReviewBoardDetailViewModel()
    @EnvironmentObject var reviewCommentViewModel: ReviewCommentViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showMoreAction = false
    @State private var showMofifyView = false
    @State private var showDeleteAlert = false
    @State private var showReportView = false
    @State private var commentContent = ""
    
    var body: some View {
        VStack{
            customTitleBar
            ReviewDetailRow(review_:reviewBoardDetailViewModel.review, commentsList_: reviewCommentViewModel.commentList, commentContent: $commentContent)
                .onWriteReviewComment {
                    self.callWriteReviewComment()
                }
                
            NavigationLink(destination: ReviewModifyView(reviewId: selectedReviewId, reviewTitle: reviewBoardDetailViewModel.review.title, reviewContent: reviewBoardDetailViewModel.review.content, lensId: reviewBoardDetailViewModel.review.lensId), isActive: $showMofifyView){
                EmptyView()
            }
            
            .alert(isPresented: $showDeleteAlert)
            {
                Alert(title: Text(""), message: Text("delete_review_question".localized()),
                      primaryButton: .destructive(Text("delete_button_title".localized()), action: { callDeleteReview() }),
                      secondaryButton: .cancel())
            }
        }
        .frame(maxHeight:.infinity,  alignment: .top)
        .navigationBarHidden(true)
        .onAppear(perform: callReviewBoardDetail)
        .onReceive(reviewBoardDetailViewModel.reviewDeleteSuccess, perform: { value in
            if value {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .onReceive(reviewCommentViewModel.writeCommentSuccess, perform: { value in
            if value == CommentRequestResult.parentSuccess
            {
                callReviewBoardDetail()
                commentContent = ""
            }
        })
        .onReceive(reviewCommentViewModel.deleteCommentSuccess, perform: { value in
            if value == CommentRequestResult.parentSuccess
            {
                callReviewBoardDetail()
            }
        })
        .onReceive(reviewCommentViewModel.modifyCommentSuccess, perform: { value in
            if value == CommentRequestResult.parentSuccess
            {
                callReviewBoardDetail()
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
            
            HStack(spacing: 20){
                Button(action: {
                    self.showMoreAction = true
                }, label: {
                    Image("more-hori")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:20, height: 20)
                        .foregroundColor(Color("IconColor"))
                })
                .actionSheet(isPresented: $showMoreAction){
                    reviewActionSheet()
                }
            }
            .padding(.trailing, 10)
        }
    }
    
    fileprivate func reviewActionSheet() -> ActionSheet {
        var reviewButtons = [ActionSheet.Button]()
        
        if reviewBoardDetailViewModel.review.isAuthor {
            reviewButtons.append(.default(Text("modify".localized()), action: { self.showMofifyView = true }))
            reviewButtons.append(.destructive(Text("delete".localized()), action: { self.showDeleteAlert = true }))
        }else {
            reviewButtons.append(.destructive(Text("report".localized()), action: { self.showReportView = true }))
        }
        
        reviewButtons.append(.cancel())
        
        return ActionSheet(title: Text("review_actionSheet_title".localized()), buttons: reviewButtons)
    }
    
    func callReviewBoardDetail()
    {
        reviewBoardDetailViewModel.getReviewBoardDetail(id: selectedReviewId)
        reviewCommentViewModel.getCommentList(id: selectedReviewId)
    }
    
    func callDeleteReview()
    {
        reviewBoardDetailViewModel.delReview(reviewId: selectedReviewId)
    }
    
    func callWriteReviewComment()
    {
        reviewCommentViewModel.writeComment(reviewId: reviewBoardDetailViewModel.review.id, content: commentContent)
    }
}

struct ReviewDetailRow: View
{
    var onWriteReviewComment = {}
    
    var review_: ReviewBoardDetail
    var commentsList_ = [Comment]()
    
    @Binding var commentContent: String
    
    var body: some View
    {
        VStack {
            ScrollView(showsIndicators: false)
            {
                // 상단
                VStack(alignment: .leading, spacing: 5){
                    Text(review_.title)
                        .font(.title)
                    
                    Text(review_.nickname)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                    
                    Text(calcCreatedBefore(createdAt: review_.createdAt))
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 8)
                    
                    Divider()
                    
                    Text(review_.content)
                        .font(.body)
                        .padding(.top, 12)
                }
                .padding([.leading, .trailing], 12)
                .padding(.top, 8)
                .frame(minHeight: DeviceInfo.deviceHeight / 3.5, alignment: .top)
                
                // 하단
                HStack{
                    HStack(spacing: 10){
                        Image("like")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20, height: 20)
                            .foregroundColor(Color("IconColor"))
                        Text("\(review_.likeCnt)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth:.infinity)

                    Divider()
                    
                    HStack(spacing: 10){
                        Image("reply")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20, height: 20)
                            .foregroundColor(Color("IconColor"))
                        Text("\(review_.replyCnt)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth:.infinity)
                }
                .frame(height: 20)
                .padding([.leading, .trailing], 12)
                .padding([.top, .bottom], 13)
                
                BoardDetailDivider()
                
                // 댓글 상단
                HStack{
                    HStack(spacing: 1){
                        Text("sort_type_time".localized())
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
//                        Image("arrow-drop-down")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(Color("IconColor"))
                    }
                    .padding(.leading, 12)
                    
                    Spacer()
                    
                    HStack(spacing: 3){
                        Text("go_to_bottom_comment".localized())
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Image("align-bottom")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("IconColor"))
                    }
                    .padding(.trailing, 8)
                }
                .frame(height: 25)
                
                Divider()
                
                // 댓글
                LazyVStack(spacing: 0){
                    ForEach(commentsList_){ comment in
                        if comment.depth == CommentConst.parentComment {
                            ReviewCommentRowView(comment: comment, moreFlag: true, isCommentView: false)
                        } else if comment.depth == CommentConst.childComment {
                            ReviewChildCommentRowView(comment: comment, isCommentView: false)
                        }
                    }
                }
            }
            
            Divider()
            
            // 댓글 입력
            HStack(spacing: 4){
                TextField("comment_hint".localized(), text: $commentContent)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .autocapitalization(.none)
                
                if $commentContent.wrappedValue.count > 0
                {
                    Button(action: { self.onWriteReviewComment() })
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
    }
    
    func onWriteReviewComment(_ callback: @escaping () -> ()) -> some View {
        ReviewDetailRow(onWriteReviewComment: callback, review_: self.review_, commentsList_: self.commentsList_, commentContent: self.$commentContent)
    }
}
