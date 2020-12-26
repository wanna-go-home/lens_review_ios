//
//  FreeBoardWriteView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/12/23.
//

import SwiftUI

struct FreeBoardWriteView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View
    {
        VStack
        {
            customTitleBar
            Text("sh")
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
                        Text("돌아가기")
                            .foregroundColor(.gray)
                    }
            }
            
            Spacer()
            
//            HStack(spacing: 20){
//                Image("noti-off") // set image here
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width:20, height: 20)
//                    .foregroundColor(Color("IconColor"))
//
//                Image("bookmark-empty") // set image here
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width:20, height: 20)
//                    .foregroundColor(Color("IconColor"))
//
//                Image("more-hori") // set image here
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width:20, height: 20)
//                    .foregroundColor(Color("IconColor"))
//            }
//            .padding(.trailing, 10)
        }
    }
}

struct FreeBoardWriteView_Previews: PreviewProvider {
    static var previews: some View {
        FreeBoardWriteView()
    }
}
