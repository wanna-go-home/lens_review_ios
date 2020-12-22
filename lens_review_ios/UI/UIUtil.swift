//
//  UIUtil.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/11/29.
//

import SwiftUI

struct ScrollDivider: View {
    let color: Color = Color("ScrollDividerColor")
    let width: CGFloat = 5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct BoardDetailDivider: View {
    let color: Color = Color("ScrollDividerColor")
    let width: CGFloat = 13
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct DeviceInfo {
    static let deviceHeight:CGFloat = UIScreen.main.bounds.size.height
    static let deviceWidth:CGFloat = UIScreen.main.bounds.size.width
}

struct FloatingWriteBtn: View{
    var body: some View {
        HStack
        {
            Spacer()
            VStack
            {
                Spacer()
                
                Button(action: {},
                       label:{
                        Image("write")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width:35, height: 35)
                            .foregroundColor(.white)
                            .padding(10)
                       })
                    .background(Color("FloatingColor"))
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
            }
        }
    }
}
