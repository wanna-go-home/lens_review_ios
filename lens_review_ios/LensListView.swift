//
//  LensListView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/14.
//

import SwiftUI

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
                            Text(lens_.name)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Lens List"))
        }
    }
}
