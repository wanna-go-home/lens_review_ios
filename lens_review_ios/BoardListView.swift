//
//  BoardListView.swift
//  lens_review_ios
//
//  Created by 김선희 on 2020/10/15.
//

import SwiftUI

struct BoardListView: View {

    @EnvironmentObject var boardListViewModel: BoardListViewModel

    var body: some View {
        NavigationView
        {
            List
            {
                ForEach(boardListViewModel.boardList) { board_ in
                    HStack {
                        Text(board_.name)
                    }
                }
            }
            .navigationBarTitle(Text("Board List"))
        }
    }
}
