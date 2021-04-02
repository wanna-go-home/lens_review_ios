//
//  ReviewModifyView.swift
//  lens_review_ios
//
//  Created by sance on 2021/04/02.
//

import SwiftUI

import SwiftUI

struct ReviewModifyView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var reviewModifyViewModel:ReviewModifyViewModel = ReviewModifyViewModel()
    
    var reviewId = 0
    var reviewTitle = ""
    var reviewContent = ""
    var lensId = 0
    @State private var title = ""
    @State private var content = ""

    var body: some View
    {
        VStack(spacing: 10)
        {
            customTitleBar
            
            Divider()
            
            // Title & Content
            VStack
            {
                TextField("write_title_hint".localized(), text: $title)
                    .autocapitalization(.none)
                
                Divider()
                
                ScrollView(showsIndicators: true)
                {
                    TextField("write_content_hint".localized(), text: $content)
                        .autocapitalization(.none)
                }
                .padding(.top , 3)
            }
            .padding(.top, 3)
            
            Divider()
        }
        .padding([.leading, .trailing], 15)
        .onReceive(reviewModifyViewModel.reviewModifySuccess, perform: { value in
            if value {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        .onAppear(perform: {
            self.title = reviewTitle
            self.content = reviewContent
        })
    }
    
    var customTitleBar : some View {
        HStack
        {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("cancel".localized())
                }
            
            Spacer()
            
            Button(action: {
                modifyReview(reviewId: reviewId, title: title, content: content, lendId: lensId)
            })
            {
                Text("post".localized())
            }
        }
        .foregroundColor(Color("BoardContentColor"))
    }
    
    func modifyReview(reviewId: Int, title: String, content: String, lendId: Int)
    {
        reviewModifyViewModel.putReview(reviewId: reviewId, title: title, content: content, lensId: lendId)
    }
}
