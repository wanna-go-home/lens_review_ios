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
            List
            {
                ForEach(lensViewModel.lensList) { lens_ in
                    HStack {
                        NavigationLink(destination: LensDetailView(selectedLensId: lens_.id))
                        {
                            HStack {
                                URLImage(url: URL(string: lens_.productImage[0])!) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                                Text(lens_.name)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Lens List"))
        }
    }
}
