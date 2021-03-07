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
    @EnvironmentObject var commentViewModel: CommentViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var showMoreAction = false
    @State private var showMofifyView = false
    @State private var showDeleteAlert = false
    @State private var showReportView = false
    @State private var commentContent = ""

    var body: some View {
        VStack(spacing: 0)
        {
            customTitleBar
            FreeBoardDetailRow(article_:freeBoardDetailViewModel.article, commentsList_: commentViewModel.commentList, commentContent: $commentContent)
                .onWriteArticleComment {
                    self.callWriteArticleComment()
                }
            
            NavigationLink(destination: ArticleModifyView(articleId: selectedArticleId, articleTitle: freeBoardDetailViewModel.article.title, articleContent: freeBoardDetailViewModel.article.content), isActive: $showMofifyView){
                EmptyView()
            }
            
            .alert(isPresented: $showDeleteAlert)
            {
                Alert(title: Text(""), message: Text("delete_article_question".localized()),
                      primaryButton: .destructive(Text("delete_button_title".localized()), action: { callDeleteArticle() }),
                      secondaryButton: .cancel())
            }
        }
        .onAppear(perform: callFreeBoardDetail)
        .frame(maxHeight:.infinity,  alignment: .top)
        .navigationBarHidden(true)
        .onChange(of: freeBoardDetailViewModel.deleteSuccess) { (newValue) in
            if(newValue == true)
            {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .onReceive(commentViewModel.writeCommentSuccess, perform: { value in
            if value == CommentRequestResult.parentSuccess
            {
                // TODO refresh 후에 제일 스크롤 제일 아래로 내리기
                callFreeBoardDetail()
                commentContent = ""
            }
        })
        .onReceive(commentViewModel.deleteCommentSuccess, perform: { value in
            if value == CommentRequestResult.parentSuccess
            {
                callFreeBoardDetail()
            }
        })
        .onReceive(commentViewModel.modifyCommentSuccess, perform: { value in
            if value == CommentRequestResult.parentSuccess
            {
                callFreeBoardDetail()
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
                Image("noti-off") // set image here
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20, height: 20)
                    .foregroundColor(Color("IconColor"))
                
                Image("bookmark-empty") // set image here
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20, height: 20)
                    .foregroundColor(Color("IconColor"))
                
                Button(action: {
                    self.showMoreAction = true
                }, label: {
                    Image("more-hori")
                        .aspectRatio(contentMode: .fit)
                        .frame(width:20, height: 20)
                        .foregroundColor(Color("IconColor"))
                })
                .actionSheet(isPresented: $showMoreAction){
                    articleActionSheet()
                }
            }
            .padding(.trailing, 10)
        }
    }
    
    fileprivate func articleActionSheet() -> ActionSheet {
        var articleButtons = [ActionSheet.Button]()
        
        if freeBoardDetailViewModel.article.isAuthor {
            articleButtons.append(.default(Text("modify".localized()), action: { self.showMofifyView = true }))
            articleButtons.append(.destructive(Text("delete".localized()), action: { self.showDeleteAlert = true }))
        }else {
            articleButtons.append(.destructive(Text("report".localized()), action: { self.showReportView = true }))
        }
        
        articleButtons.append(.cancel())
        
        return ActionSheet(title: Text("article_actionSheet_title".localized()), buttons: articleButtons)
    }
    
    func callFreeBoardDetail()
    {
        freeBoardDetailViewModel.getFreeBoardDetail(id: selectedArticleId)
        commentViewModel.getCommentList(id: selectedArticleId)
    }
    
    func callDeleteArticle()
    {
        freeBoardDetailViewModel.delArticle(articleId: selectedArticleId)
    }
    
    func callWriteArticleComment()
    {
        commentViewModel.writeComment(articleId: freeBoardDetailViewModel.article.id, content: commentContent)
    }
}

struct FreeBoardDetailRow: View
{
    var onWriteArticleComment = {}
    
    var article_: FreeBoardDetail
    var commentsList_ = [Comment]()
    
    @Binding var commentContent: String
    
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
                    
                    Text(calcCreatedBefore(createdAt: article_.createdAt))
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
                        Text("share".localized())
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
                        Image("arrow-drop-down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color("IconColor"))
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
                            CommentRowView(comment: comment, moreFlag: true, isCommentView: false)
                        } else if comment.depth == CommentConst.childComment {
                            ChildCommentRowView(comment: comment, isCommentView: false)
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
                TextField("comment_hint".localized(), text: $commentContent)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .autocapitalization(.none)
                
                if $commentContent.wrappedValue.count > 0
                {
                    Button(action: { self.onWriteArticleComment() })
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
    
    func onWriteArticleComment(_ callback: @escaping () -> ()) -> some View {
        FreeBoardDetailRow(onWriteArticleComment: callback, article_: self.article_, commentsList_: self.commentsList_, commentContent: self.$commentContent)
    }
}

struct FreeBoardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FreeBoardDetailView(selectedArticleId: 6)
    }
}
