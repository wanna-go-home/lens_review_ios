//
//  ContentView.swift
//  lens_review_ios
//
//  Created by suning on 2020/08/31.
//  Copyright © 2020 wannagohome. All rights reserved.
//

import SwiftUI

struct ContentView: View
{
    
    @EnvironmentObject var lensViewModel: LensListViewModel
    @EnvironmentObject var reviewListViewModel: ReviewListViewModel
    @EnvironmentObject var boardListViewModel: BoardListViewModel

    var body: some View {
        TabView{
            LensListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("렌즈 리스트")
                }
            ReviewListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("리뷰 게시판")
                }
            BoardListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("자유 게시판")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LensListViewModel()).environmentObject(ReviewListViewModel()).environmentObject(BoardListViewModel())
    }
}
