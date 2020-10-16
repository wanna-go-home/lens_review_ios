//
//  ReviewListView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/17.
//

import SwiftUI

struct ReviewListView: View {

    @EnvironmentObject var reviewListViewModel: ReviewListViewModel

    var body: some View {
        NavigationView
        {
            List
            {
                ForEach(reviewListViewModel.reviewList) { review_ in
                    HStack {
                        NavigationLink(destination: Text(review_.content))
                        {
                            Text(review_.title)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Review List"))
        }
    }
}
