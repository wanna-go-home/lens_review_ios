//
//  CommentRowView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/19.
//

import SwiftUI

struct CommentRowView: View
{
    @EnvironmentObject var commentViewModel: CommentViewModel
    
    @State private var showMoreAction = false
    @State private var showDeleteAlert = false
    @State private var showReportView = false
    
    @State private var newComment = ""
    
    @State private var showCommentView = false
    
    var comment: FreeBoardComment
    var moreFlag : Bool
    var isCommentView : Bool
    
    var body: some View
    {
        VStack(alignment: .leading)
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
                        
                        if !isCommentView
                        {
                            Button(action: { self.showCommentView = true })
                            {
                                HStack(spacing: 5)
                                {
                                    Image("reply")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:18, height: 18)
                                        .foregroundColor(Color("IconColor"))
                                    
                                    Text("child_comment".localized())
                                }
                            }
                        }
                        
                        Spacer()
                        
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
                    .font(.system(size: 14))
                    .foregroundColor(Color("BoardContentColor"))
                    .frame(height: 25)

                }
                
                if moreFlag && comment.bundleSize > CommentConst.moreCommentSize {
                    Divider()
                    
                    NavigationLink(destination: CommentView(selectedCommentId: comment.bundleId, selectedArticleId: comment.postId))
                    {
                        Text("more_view_child_comment".localized(with: comment.bundleSize - CommentConst.moreCommentSize))
                            .font(.system(size: 12))
                            .foregroundColor(Color("BoardContentColor"))
                            .padding(.leading, 10)
                            .multilineTextAlignment(.center)
                            
                    }
                    .frame(height: 10)
                }
            }
            .padding(.leading, 12)
            .padding([.top, .bottom], 7)
            
            Divider()
            
            .alert(isPresented: $showDeleteAlert)
            {
                Alert(title: Text(""), message: Text("delete_article_question".localized()),
                      primaryButton: .destructive(Text("delete_button_title".localized()), action: { callDeleteComment() }),
                      secondaryButton: .cancel())
            }
        }
        
        NavigationLink(destination: CommentView(selectedCommentId: comment.id, selectedArticleId: comment.postId), isActive: $showCommentView){
            EmptyView()
        }
    }
    
    fileprivate func callDeleteComment()
    {
        commentViewModel.deleteComment(postId: comment.postId, commentId: comment.id)
    }
    
    fileprivate func commentActionSheet() -> ActionSheet {
        var commentButtons = [ActionSheet.Button]()
        
        if comment.isAuthor {
            commentButtons.append(.default(Text("modify".localized()), action: {
                                            let customAlert = CommentModifyAlert(postId: comment.postId, commentId: comment.id, onModify: commentViewModel.modifyComment(postId:commentId:comment:))
                                            customAlert.alert(comment: comment.content) }))
            commentButtons.append(.destructive(Text("delete".localized()), action: { self.showDeleteAlert = true }))
        }else {
            commentButtons.append(.destructive(Text("report".localized()), action: { self.showReportView = true }))
        }
        
        commentButtons.append(.cancel())
        
        return ActionSheet(title: Text("article_comment_actionSheet_title".localized()), buttons: commentButtons)
    }
}
