//
//  MyReviewView.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/05.
//

import SwiftUI

struct MyReviewView: View
{
    @ObservedObject var myReviewViewModel = MyReviewViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View
    {
        VStack(spacing: 0)
        {
            customTitleBar
            ScrollView(showsIndicators: false)
            {
                LazyVStack(alignment: .leading)
                {
                    ForEach(myReviewViewModel.reviewList) { review in
                        MyReviewRow(review: review)
                    }
                }
                .frame(minHeight: 100)
            }
            .padding([.leading, .trailing, .top])
            .navigationBarHidden(true)
            .onAppear(perform: {
                myReviewViewModel.getMyReview()
            })
        }
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
        }
    }
}

struct MyReviewRow: View
{
    var review: ReviewBoardPreview
    
    var body: some View {
        VStack(alignment: .leading)
        {
            // 상단
            VStack(alignment: .leading, spacing: 10) {
                Text("\(review.title)")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                Text("\(review.content)")
                    .font(.system(size: 12))
                    .foregroundColor(Color("BoardContentColor"))
            }
            .padding([.leading, .trailing], 12)
            
            Divider()
        }
    }
}
