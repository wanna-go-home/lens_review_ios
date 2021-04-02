//
//  ReviewListView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/17.
//

import SwiftUI
import URLImage

struct ReviewListView: View {

    @EnvironmentObject var reviewListViewModel: ReviewListViewModel

    var body: some View {
        NavigationView
        {
            ZStack
            {
                ScrollView(showsIndicators: false)
                {
                    LazyVStack(alignment: .leading)
                    {
                        ForEach(reviewListViewModel.reviewList) { board_ in
                            NavigationLink(destination: ReviewBoardDetailView(selectedReviewId: board_.id).environmentObject(ReviewCommentViewModel()))
                            {
                                ReviewBoardRow(board_: board_)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(minHeight: 100)
                }
                .padding([.leading, .trailing])
                .navigationBarHidden(true)
                .onAppear(perform: {
                    reviewListViewModel.getReviewList()
                })
                
                FloatingWriteBtn(destinationView: SelectLensView(selectedLensId: 1).environmentObject(ReviewWriteViewModel()))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ReviewBoardRow: View {
    
    var board_: ReviewBoardPreview
    
    var body: some View {
        VStack(alignment: .leading)
        {
            // 상단
            HStack{
                VStack(alignment: .leading) {
                    Text("\(board_.title)")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .padding(.top, 5)
                    Text("\(board_.content)")
                        .font(.system(size: 12))
                        .foregroundColor(Color("BoardContentColor"))
                        .padding(.top, 5)
                    Text("\(board_.nickname)")
                        .font(.system(size: 11))
                        .foregroundColor(.black)
                        .padding(.top, 15)
                }
                
                Spacer()
                
                if !board_.lensPreviewEntity.productImage.isEmpty {
                    URLImage(url: URL(string: board_.lensPreviewEntity.productImage[0])!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                    }
                }else {
                    Image("no-photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("IconColor"))
                        .padding(10)
                        .border(Color("IconColor"), width: 1)
                }
            }
            .padding([.leading, .trailing], 12)
            .padding(.top, 20)
            
            Divider()
            
            // 하단
            HStack(spacing: 5) {
                
                Image("view")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    .foregroundColor(Color("IconColor"))
                Text("\(board_.viewCnt)")
                    .font(.system(size: 11))
                
                Image("like")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    .padding(.leading, 10)
                    .foregroundColor(Color("IconColor"))
                Text("\(board_.likeCnt)")
                    .font(.system(size: 11))
                
                Image("reply")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:14, height: 14)
                    .padding(.leading, 10)
                    .foregroundColor(Color("IconColor"))
                Text("\(board_.replyCnt)")
                    .font(.system(size: 11))
                
                Spacer()
                
                Text(calcCreatedBefore(createdAt: board_.createdAt))
                    .font(.system(size: 11))
            }
            .frame(height: 18)
            .padding([.leading, .trailing], 12)
            
            ScrollDivider()
        }
    }
}
