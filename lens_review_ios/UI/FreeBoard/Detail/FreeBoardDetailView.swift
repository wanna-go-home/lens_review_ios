//
//  FreeBoardDetailView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/06.
//

import SwiftUI

struct FreeBoardDetailView: View
{
    var selectedArticleId: Int
    @ObservedObject var freeBoardDetailViewModel:FreeBoardDetailViewModel = FreeBoardDetailViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showMofifyView = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack(spacing: 0)
        {
            customTitleBar
            FreeBoardDetailRow(article_:freeBoardDetailViewModel.article, commentsList_: freeBoardDetailViewModel.commentList)
            
            NavigationLink(destination: ArticleModifyView(articleId: freeBoardDetailViewModel.article.id, articleTitle: freeBoardDetailViewModel.article.title, articleContent: freeBoardDetailViewModel.article.content), isActive: $showMofifyView){
                EmptyView()
            }
            
            .alert(isPresented: $showDeleteAlert)
            {
                Alert(title: Text(""), message: Text("delete_article_question".localized),
                      primaryButton: .destructive(Text("delete_button_title".localized), action: {
                                // Call delete api
                            }),
                      secondaryButton: .cancel())
            }
        }
        .onAppear(perform: callFreeBoardDetail)
        .frame(maxHeight:.infinity,  alignment: .top)
        .navigationBarHidden(true)
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
                        Text("돌아가기")
                            .foregroundColor(.gray)
                    }
            }
            
            Spacer()
            
            HStack(spacing: 20){
                Image("noti-off") // set image here
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20, height: 20)
                    .foregroundColor(Color("IconColor"))
                
                Image("bookmark-empty") // set image here
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20, height: 20)
                    .foregroundColor(Color("IconColor"))
                
                Menu(content: {
                    Button("수정하기", action: { self.showMofifyView = true })
                    Button("삭제하기", action: { self.showDeleteAlert = true })
                },
                label: {
                    Image("more-hori")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:20, height: 20)
                        .foregroundColor(Color("IconColor"))
                })
            }
            .padding(.trailing, 10)
        }
    }
    
    func callFreeBoardDetail()
    {
        freeBoardDetailViewModel.getFreeBoardDetail(id: selectedArticleId)
        freeBoardDetailViewModel.getCommentList(id: selectedArticleId)
    }
}

struct FreeBoardDetailRow: View
{
    var article_: FreeBoardDetail
    var commentsList_ = [FreeBoardComment]()
    
    var body: some View
    {
        VStack {
            ScrollView(showsIndicators: false)
            {
                // 상단
                VStack(alignment: .leading, spacing: 5){
                    Text(article_.title)
                        .font(.title)
                    
                    Text(article_.nickname)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                    
                    Text(article_.getDateTime())
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 8)
                    
                    Divider()
                    
                    Text(article_.content)
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
                        Text("\(article_.likeCnt)")
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
                        Text("\(article_.replyCnt)")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth:.infinity)
                    
                    Divider()
                    
                    HStack(spacing: 10) {
                        Image("share")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:20, height: 20)
                            .foregroundColor(Color("IconColor"))
                        Text("공유")
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
                        Text("시간순")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        Image("arrow-drop-down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("IconColor"))
                    }
                    .padding(.leading, 12)
                    
                    Spacer()
                    
                    HStack(spacing: 3){
                        Text("마지막 댓글로 이동")
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
                            CommentRowView(comment: comment, moreFlag: true)
                        } else if comment.depth == CommentConst.childComment {
                            ChildCommentRowView(comment: comment)
                        }
                    }
                }
            }
            
            Divider()
            
            // 댓글 입력
            HStack(spacing: 4){
                Image("camera")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("IconColor"))
                Text("댓글을 남겨주세요")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.bottom, 20)
        }
    }
}

struct FreeBoardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FreeBoardDetailView(selectedArticleId: 6)
    }
}
