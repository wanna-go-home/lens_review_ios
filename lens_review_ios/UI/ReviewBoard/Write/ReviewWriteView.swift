//
//  ReviewWriteView.swift
//  lens_review_ios
//
//  Created by sance on 2021/03/28.
//

import SwiftUI

struct ReviewWriteView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var reviewWriteViewModel:ReviewWriteViewModel
    
    @State private var title = ""
    @State private var content = ""
    var lensId: Int

    var body: some View
    {
        VStack(spacing: 10)
        {
            customTitleBar
            
            Divider()
            
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
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 15)
        .onReceive(reviewWriteViewModel.reviewPostSuccess, perform: { value in
            if value {
                self.presentationMode.wrappedValue.dismiss()
            }
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
            
            Button(action: { writeReview(title: title, content: content, lensId: lensId) })
            {
                Text("post".localized())
            }
        }
        .foregroundColor(Color("BoardContentColor"))
    }
    
    func writeReview(title: String, content: String, lensId: Int)
    {
        reviewWriteViewModel.postArticle(title: title, content: content, lensId: lensId)
    }
}
