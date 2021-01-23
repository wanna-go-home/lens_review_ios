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
    @State private var showMofifyView = false
    @State private var showDeleteAlert = false
    @State private var showReportView = false
    
    var comment: FreeBoardComment
    var moreFlag : Bool
    
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
                        
                        // TODO 클릭 시 대댓글 POST
                        HStack(spacing: 5)
                        {
                            Image("reply")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:18, height: 18)
                                .foregroundColor(Color("IconColor"))
                            
                            Text("child_comment".localized())
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
    }
    
    fileprivate func callDeleteComment()
    {
        commentViewModel.deleteComment(postId: comment.postId, commentId: comment.id)
    }
    
    fileprivate func commentActionSheet() -> ActionSheet {
        var commentButtons = [ActionSheet.Button]()
        
        if comment.isAuthor {
            commentButtons.append(.default(Text("modify".localized()), action: { self.showMofifyView = true }))
            commentButtons.append(.destructive(Text("delete".localized()), action: { self.showDeleteAlert = true }))
        }else {
            commentButtons.append(.destructive(Text("report".localized()), action: { self.showReportView = true }))
        }
        
        commentButtons.append(.cancel())
        
        return ActionSheet(title: Text("article_comment_actionSheet_title".localized()), buttons: commentButtons)
    }
}
