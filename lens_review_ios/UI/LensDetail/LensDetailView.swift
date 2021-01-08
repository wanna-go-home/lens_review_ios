//
//  LensDetailView.swift
//  lens_review_ios
//
//  Created by suning on 2020/09/27.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI
import URLImage

struct LensDetailView: View
{
    var selectedLensId: Int
    @ObservedObject var lensDetailViewModel: LensDetailViewModel = LensDetailViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            customTitleBar
            LensDetailRow(lens_: lensDetailViewModel.lens)
        }.onAppear(perform: callLensDetail)
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
                        Image("arrow-left")
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
    
    func callLensDetail()
    {
        lensDetailViewModel.getLensDetail(id: selectedLensId)
    }
}

struct LensDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LensDetailView(selectedLensId: 1)
    }
}

struct LensDetailRow: View {
    
    var lens_: LensDetail

    var body: some View {
        if !lens_.productImage.isEmpty {
            URLImage(url: URL(string: lens_.productImage[0])!) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240, height: 240)
            }
        }
        Text("렌즈 브랜드")
            .font(.system(size: 15))
            .padding(.top, 12)
        Text(lens_.name)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .padding([.top, .bottom], 10)
        
        HStack(spacing: 1) {
            Text("lens_graphicDia".localized(with: lens_.graphicDia))
                .font(.system(size: 13))
            Text("lens_divider".localized())
            Text("lens_price".localized(with: lens_.price))
                .font(.system(size: 13))
        }
        
        HStack(spacing: 1) {
            Text("lens_grade".localized())
                .font(.system(size: 13))
            Text("4.15")
                .font(.system(size: 13))
                .foregroundColor(.purple)
        }
    }
}
