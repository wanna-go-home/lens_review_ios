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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            customTitleBar
            ReviewBoardDetailRow(review_:reviewBoardDetailViewModel.review)
        }
        .onAppear(perform: callReviewBoardDetail)
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
                
                Image("more-hori") // set image here
                    .aspectRatio(contentMode: .fit)
                    .frame(width:20, height: 20)
                    .foregroundColor(Color("IconColor"))
            }
            .padding(.trailing, 10)
        }
    }
    
    func callReviewBoardDetail()
    {
        reviewBoardDetailViewModel.getReviewBoardDetail(id: selectedReviewId)
    }
}

struct ReviewBoardDetailRow: View
{
    var review_: ReviewBoardDetail
    
    var body: some View
    {
        VStack {
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
                
                Spacer()
                Divider()
                
                // TODO: API에 Image 추가되면 수정 필요
                HStack(alignment:.bottom){
                    Image("no-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color("IconColor"))
                        .padding(7)
                        .border(Color.gray, width: 1)
                    
                    Image("no-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color("IconColor"))
                        .padding(7)
                        .border(Color.gray, width: 1)
                }
            }
            .padding([.leading, .trailing], 12)
            .padding(.top, 8)
            .frame(minHeight: DeviceInfo.deviceHeight / 2.5, alignment: .top)
            
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
            ScrollView
            {
                VStack{
                    Text("댓글을 넣어야 함")
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
                Text("comment_hint".localized())
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.bottom, 20)
        }
    }
}
