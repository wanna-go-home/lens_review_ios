//
//  CommentRowView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/19.
//

import SwiftUI

struct CommentRowView: View
{
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
                    Text(comment.accountId)
                        .font(.system(size: 14))
                        .foregroundColor(Color("BoardContentColor"))
                        
                    Text(comment.content)
                        .font(.system(size: 17))
                        .foregroundColor(Color("BoardTitleColor"))
                        
                    HStack(spacing: 20)
                    {
                        Text(convertDateFormat(inputData: comment.createdAt, outputFormat: "MM/dd-HH:mm"))
                        
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
                            
                            Text("대댓글")
                        }
                        
                        Spacer()
                        
                        Image("more-hori")
                            .aspectRatio(contentMode: .fit)
                            .frame(width:18, height: 18)
                            .foregroundColor(Color("IconColor"))
                            .padding(.trailing, 25)
                    }
                    .font(.system(size: 14))
                    .foregroundColor(Color("BoardContentColor"))
                    .frame(height: 25)

                }
                
                if moreFlag && comment.bundleSize > CommentConst.moreCommentSize {
                    Divider()
                    
                    NavigationLink(destination: CommentView(selectedCommentId: comment.bundleId, selectedArticleId: comment.postId))
                    {
                        Text("+ 대댓글 \(comment.bundleSize - CommentConst.moreCommentSize)개 더 보기...")
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
        }
    }
}

struct ChildCommentRowView: View
{
    var comment: FreeBoardComment
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            VStack(alignment: .leading, spacing: 12)
            {
                Text(comment.accountId)
                    .font(.system(size: 14))
                    .foregroundColor(Color("BoardContentColor"))
                    
                Text(comment.content)
                    .font(.system(size: 17))
                    .foregroundColor(Color("BoardTitleColor"))
                    
                HStack(spacing: 20)
                {
                    Text(convertDateFormat(inputData: comment.createdAt, outputFormat: "MM/dd-HH:mm"))
                    
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
                    
                    Image("more-hori")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:18, height: 18)
                        .foregroundColor(Color("IconColor"))
                        .padding(.trailing, 25)
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
    }
}
