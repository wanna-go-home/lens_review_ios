//
//  ArticleModifyView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/27.
//

import SwiftUI

struct ArticleModifyView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                TextField("write_title_hint".localized, text: $title)
                    .autocapitalization(.none)
                
                Divider()
                
                ScrollView(showsIndicators: true)
                {
                    TextField("write_content_hint".localized, text: $content)
                        .autocapitalization(.none)
                }
                .padding(.top , 3)
            }
            .padding(.top, 3)
            
            Divider()
            
            // Footer
            // TODO : Buton Action
            HStack(spacing: 15)
            {
                Button(action: {}){
                    Image("camera")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("IconColor"))
                }
                
                Button(action: {}){
                    Image("vote")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("IconColor"))
                }
                
                Button(action: {}){
                    Text("#")
                        .font(.system(size : 25))
                        .foregroundColor(Color("IconColor"))
                }
                
                Spacer()
            }
            .frame(height: 25)
        }
        .padding([.leading, .trailing], 15)
    }
    
    var customTitleBar : some View {
        HStack
        {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("취소")
            }
            
            Spacer()
            
            Button(action: {})
            {
                Text("등록")
            }
        }
        .foregroundColor(Color("BoardContentColor"))
    }
}

struct ArticleModifyView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleModifyView()
    }
}