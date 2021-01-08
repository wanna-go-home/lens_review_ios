//
//  LensListView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/14.
//

import SwiftUI
import URLImage

struct LensListView: View {
    
    @EnvironmentObject var lensViewModel: LensListViewModel
    
    var body: some View {
        NavigationView
        {
            ScrollView(showsIndicators: false)
            {
                LazyVStack(alignment: .leading)
                {
                    ForEach(lensViewModel.lensList) { lens_ in
                        NavigationLink(destination: LensDetailView(selectedLensId: lens_.id))
                        {
                            LensListRow(lens_: lens_)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(minHeight: 100)
            }
            .padding([.leading, .trailing])
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LensListRow: View {
    
    var lens_: LensPreview
    
    var body: some View {
        VStack {
            HStack {
                Text("\(lens_.id)")
                URLImage(url: URL(string: lens_.productImage[0])!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                }
                VStack(alignment: .leading) {
                    // TODO : 브랜드명은 보고 없애거나 API에서 받아오도록 수정 필요
                    Text("렌즈 브랜드")
                        .font(.system(size: 10))
                        .padding(.bottom, 3)
                    Text(lens_.name)
                        .font(.system(size: 12))
                        .padding(.bottom, 5)
                    // TODO : Text 상수 처리, spacing 조절
                    HStack(spacing: 1) {
                        Text("lens_graphicDia".localized(with: lens_.graphicDia))
                        Text("lens_divider".localized())
                        Text("lens_price".localized(with: lens_.price))
                        Text("lens_divider".localized())
                        Text("lens_grade".localized())
                        Text("4.15")
                            .foregroundColor(.purple)
                    }.font(.system(size: 10))
                }
            }
            
            Divider()
        }
    }
}
