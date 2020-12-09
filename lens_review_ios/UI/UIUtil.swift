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
