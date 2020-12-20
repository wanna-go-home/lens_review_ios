//
//  CommentRowView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/19.
//

import SwiftUI

let moreCommentSize = 3

struct CommentRowView: View
{
    var comment: FreeBoardComment
    
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
                    .frame(height: 30)

                }
                
                if comment.bundleSize > moreCommentSize {
                    NavigationLink(destination: Text("moreCommentView"))
                    {
                        Text("+ 대댓글 \(comment.bundleSize - moreCommentSize)개 더 보기...")
                            .font(.system(size: 12))
                            .foregroundColor(Color("BoardContentColor"))
                            .padding(.leading, 10)
                    }
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
                .frame(height: 30)
            }
            .padding(.leading, 37)
            .padding([.top, .bottom], 10)
            
            Divider()
        }
        .background(Color("ChildCommentColor"))
    }
}
