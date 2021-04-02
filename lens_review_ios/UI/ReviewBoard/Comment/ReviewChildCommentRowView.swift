//
//  ReviewChildCommentRowView.swift
//  lens_review_ios
//
//  Created by sance on 2021/04/03.
//

import SwiftUI

struct ReviewChildCommentRowView: View
{
    @EnvironmentObject var reviewCommentViewModel: ReviewCommentViewModel
    
    @State private var showMoreAction = false
    @State private var showDeleteAlert = false
    @State private var showReportView = false
    
    var comment: Comment
    var isCommentView : Bool
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading, spacing: 12)
            {
                Text(comment.nickname)
                    .font(.system(size: 14))
                    .foregroundColor(Color("BoardContentColor"))
                    
                Text(comment.content)
                    .font(.system(size: 17))
                    .foregroundColor(Color("BoardTitleColor"))
                    
                HStack(spacing: 20)
                {
                    Text(calcCreatedBefore(createdAt: comment.createdAt))
                    
                    HStack(spacing: 5)
                    {
                        Image("like")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:18, height: 18)
                            .foregroundColor(Color("IconColor"))
                    
                        Text("\(comment.likeCnt)")
                    }
                    
                    Spacer()
                    
                    if isCommentView
                    {
                        Button(action: {
                            self.showMoreAction = true
                        }, label: {
                            Image("more-hori")
                                .aspectRatio(contentMode: .fit)
                                .frame(width:18, height: 18)
                                .foregroundColor(Color("IconColor"))
                                .padding(.trailing, 25)
                        })
                        .actionSheet(isPresented: $showMoreAction){
                            commentActionSheet()
                        }
                    }
                }
                .font(.system(size: 14))
                .foregroundColor(Color("BoardContentColor"))
                .frame(height: 25)
            }
            .padding(.leading, 37)
            .padding([.top, .bottom], 7)
            
            Divider()
        }
        .background(Color("ChildCommentColor"))
        .alert(isPresented: $showDeleteAlert)
        {
            Alert(title: Text(""), message: Text("delete_review_question".localized()),
                  primaryButton: .destructive(Text("delete_button_title".localized()), action: { callDeleteComment() }),
                  secondaryButton: .cancel())
        }
    }
    
    fileprivate func callDeleteComment()
    {
        reviewCommentViewModel.deleteComment(postId: comment.postId, commentId: comment.id, isChildComment: true)
    }
    
    fileprivate func commentActionSheet() -> ActionSheet {
        var commentButtons = [ActionSheet.Button]()
        
        if comment.isAuthor == true {
            commentButtons.append(.default(Text("modify".localized()), action: {
                                            let customAlert = CommentModifyAlert(postId: comment.postId, commentId: comment.id, bundleId: comment.bundleId, onModify: reviewCommentViewModel.modifyComment(postId:commentId:comment:bundleId:))
                                            customAlert.alert(comment: comment.content) }))
            commentButtons.append(.destructive(Text("delete".localized()), action: { self.showDeleteAlert = true }))
        }else if comment.isAuthor == false {
            commentButtons.append(.destructive(Text("report".localized()), action: { self.showReportView = true }))
        }
        
        commentButtons.append(.cancel())
        
        return ActionSheet(title: Text("review_comment_actionSheet_title".localized()), buttons: commentButtons)
    }
}
